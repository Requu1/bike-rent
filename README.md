# Bike renting page

### Authors:

Krzysztof Patla, Szymon Potępa

#### Technologies used: JavaScript + React + Vite + Tailwind

#### Database: MySQL

---

aby pobrać wszystkie potrzebne pakiety trzeba uruchomić

`npm install`

aby uruchomić projekt należy wpisać w terminalu

`npm run dev`

---

### Baza danych ma następującą strukturę

![alt text](erd/diagram.png)

### Triggery dla poszczególnych tabel:

#### Bikes:

- AddBike_tr

```js
create trigger AddBike_tr
    before insert
    on Bikes
    for each row
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Brands WHERE BrandID=NEW.BrandID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Podane BrandID nie istnieje';
    end if;

    IF NOT EXISTS(SELECT 1 FROM Categories WHERE CategoryID=NEW.CategoryID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Podane CategoryID nie istnieje';
    end if;
end;
```

- AddQuantity_tr

```js
create trigger AddQuantity_tr
    before update
    on Bikes
    for each row
BEGIN
    IF (NEW.Quantity<0) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantity nie może być mniejsze od 0';
end if;
end;
```

#### Brands

- AddBrand_tr

```js
create trigger AddBrand_tr
    before insert
    on Brands
    for each row
BEGIN
    IF EXISTS(SELECT 1 FROM  Brands WHERE BrandName=NEW.BrandName) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Podany Brand już istnieje';
    end if;
end;
```

#### Categories

- AddCategory_tr

```js
create trigger AddCategory_tr
    before insert
    on Categories
    for each row
BEGIN
    IF EXISTS(SELECT 1 FROM Categories WHERE CategoryName=NEW.CategoryName) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Podane Category już istnieje';
    end if;
end;

```

#### Customers

- AddCustomer_tr

```js
create trigger AddCustomer_tr
    before insert
    on Customers
    for each row
BEGIN
    IF EXISTS (SELECT 1 FROM Customers WHERE Phone=NEW.Phone) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Dany numer telefonu już istnieje';
end if;
end;
```

#### RentPriceHist

- ChangeRentPrice_tr

```js
create trigger ChangeRentPrice_tr
    before insert
    on RentPriceHist
    for each row
BEGIN
        IF NOT EXISTS(SELECT 1 FROM Bikes WHERE Bikes.BikeID=NEW.BikeID) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT ='Podany BikeID nie istnieje';
        end if;

        IF (NEW.HourlyPrice<=0) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT ='Nowy koszt wynajęcia roweru musi być większy od 0';
        end if;

        IF (SELECT 1 FROM RentPriceHist WHERE BikeID=NEW.BikeID) THEN
            UPDATE RentPriceHist
            SET EndDate=CURRENT_DATE()
            WHERE RentPriceHist.BikeID=NEW.BikeID AND EndDate IS NULL;
        end if;

    end;
```

#### Rents

- AddRent_tr

```js
create trigger AddRent_tr
    before insert
    on Rents
    for each row
BEGIN
        DECLARE rents_count integer default 0;

        IF NOT EXISTS(SELECT 1 FROM Bikes WHERE Bikes.BikeID=NEW.BikeID) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT ='Podany BikeID nie istnieje';
        end if;

        IF NOT EXISTS(SELECT 1 FROM Customers WHERE Customers.CustomerID=NEW.CustomerID) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT ='Podany CustomerID nie istnieje';
        end if;

        if (SELECT Quantity FROM Bikes WHERE Bikes.BikeID=NEW.BikeID)=0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT ='Roweru o podanym BikeID nie ma obecnie na stanie.';
        end if;

        SELECT COUNT(*) INTO rents_count FROM Rents WHERE Rents.CustomerID=NEW.CustomerID AND Rents.ReturnDate IS NULL;
        IF rents_count>=5 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Nie można dodać rezerwacji, ponieważ klient o podanym CustomerID ma już 5 rezerwacji';
        end if;
    end;
```

- EndRent_tr

```js
create trigger EndRent_tr
    before update
    on Rents
    for each row
BEGIN
        IF NOT EXISTS(SELECT 1 FROM Rents WHERE RentID=NEW.RentID) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT ='Wypożyczenie o podanym RentID nie istnieje.';
        end if;

        IF (SELECT ReturnDate FROM Rents WHERE RentID=NEW.RentID) IS NOT NULL THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT ='Rower został już zwrócony.';
        end if;
    end;
```

### Funkcje:

- AvgBikeRentPrice_f

```js
create
     function AvgBikeRentPrice_f(bikeId_v int, startDate_v date, endDate_v date)
     returns int
     deterministic
BEGIN
    DECLARE avgPrice int;
    DECLARE numOfPrices int;
    DECLARE sumOfPrices int;

    IF endDate_v<startDate_v THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT ='Data końcowa musi być późniejsza od startowej';
    end if;

    IF NOT EXISTS (SELECT 1 FROM RentPriceHist WHERE BikeID=bikeId_v) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT ='Historia cen roweru o podanym id nie istnieje.';
    end if;

    SELECT SUM(RentPriceHist.HourlyPrice) ,COUNT(*) INTO sumOfPrices,numOfPrices
    FROM RentPriceHist
    WHERE BikeID=bikeId_v AND (StartDate <= endDate_v AND (EndDate >= startDate_v OR EndDate IS NULL));

    IF numOfPrices=0 THEN
        RETURN 0;
    end if;

    SET avgPrice=sumOfPrices/numOfPrices;

    RETURN avgPrice;
END;
```

- Income_f

```js
create
     function Income_f(p_StartDate date, p_EndDate date)
     returns decimal(10, 2)
     reads sql data
BEGIN
    DECLARE price DECIMAL(10,2);

    SELECT COALESCE(SUM(RentalPrice_f(RentID)), 0) INTO price FROM Rents
    WHERE RentDate BETWEEN p_StartDate AND p_EndDate;

    RETURN price;
END;
```

- RentalPrice_f

```js
create
     function RentalPrice_f(p_RentID int)
     returns int
     deterministic
BEGIN
    DECLARE hourly_price INT;
    DECLARE rent_date DATE;
    DECLARE return_date DATE;

    SELECT HourlyPrice INTO hourly_price
    FROM RentPriceHist
    INNER JOIN Rents
    ON Rents.BikeID=RentPriceHist.BikeID
    WHERE RentID = p_RentID AND EndDate IS NULL LIMIT 1;

    SELECT RentDate,ReturnDate INTO rent_date,return_date FROM Rents
    WHERE RentID=p_RentID;


    RETURN (TIMESTAMPDIFF(
        HOUR,
        rent_date,
        IFNULL(return_date, NOW()))
        )*hourly_price;
END;
```

### Procedury:

- AddBike_p

```js
create
    procedure AddBike_p(IN brandId_v int, IN categoryId_v int, IN hourly_price_v int)
BEGIN
     INSERT INTO Bikes(brandid, categoryid, quantity) VALUES (brandId_v,categoryId_v,0);
     INSERT INTO RentPriceHist(BikeID, HourlyPrice, StartDate, EndDate)  VALUES(LAST_INSERT_ID(),hourly_price_v,CURRENT_DATE(),NULL);
END;
```

- AddBrand_p

```js
create
    procedure AddBrand_p(IN brandName_v varchar(255))
BEGIN
    INSERT INTO Brands (BrandName)
VALUES (brandName_v);
END;
```

- AddCategory_p

```js
create
    procedure AddCategory_p(IN categoryName_v varchar(255))
BEGIN
    INSERT INTO Categories (CategoryName)
VALUES (categoryName_v);
END;
```

- AddCustomer_p

```js
create
    procedure AddCustomer_p(IN firstname_v varchar(255), IN surrname_v varchar(255),
                                                   IN phone_v varchar(15))
BEGIN
    INSERT INTO Customers(firstname, surrname,phone) VALUES(firstname_v,surrname_v,phone_v);
END;
```

- AddQuantity_p

```js
create
    procedure AddQuantity_p(IN quantity_v int, IN bikeID_v int)
BEGIN
    IF EXISTS (SELECT 1 FROM Bikes WHERE BikeID = bikeID_v) THEN
        UPDATE Bikes
        SET Quantity = Quantity+quantity_v
        WHERE BikeID = bikeID_v;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nie ma takiego BikeID';
    end if;
end;
```

- AddRent_p

```js
create
    procedure AddRent_p(IN bike_id_v int, IN customer_id_v int)
BEGIN
    INSERT INTO Rents(bikeid, customerid, rentdate, returndate)  VALUES(bike_id_v,customer_id_v,NOW(),NULL);
    CALL AddQuantity_p(-1,bike_id_v);
end;
```

- ChangeRentPrice_p

```js
create
    procedure ChangeRentPrice_p(IN bike_id_v int, IN hourly_price_v int)
BEGIN
    INSERT INTO RentPriceHist(BikeID, HourlyPrice, StartDate, EndDate) VALUES (bike_id_v,hourly_price_v,CURRENT_DATE(),NULL);
end;
```

- CurrentRentsForCustomer_p

```js
create
    procedure CurrentRentsForCustomer_p(IN customerId_v int)
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Customers WHERE CustomerID=customerId_v) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT ='Customer o podanym id nie istnieje.';
    end if;

    SELECT RentID,BikeID,RentDate,ReturnDate
    FROM Rents
    WHERE Rents.CustomerID=customerId_v;
end;
```

- EndRent_p

```js
create
    procedure EndRent_p(IN rent_id_v int)
BEGIN
    UPDATE Rents
    SET ReturnDate=NOW()
    WHERE Rents.RentID=rent_id_v;

    CALL AddQuantity_p(1,(SELECT BikeID FROM Rents WHERE RentID=rent_id_v));
end;
```

- FilterBike_p

```js
create
    procedure FilterBike_p(IN categoryName_v varchar(255), IN brandName_v varchar(255))
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Categories WHERE CategoryName=categoryName_v) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT ='Podane categoryName nie istnieje.';
    end if;

    IF NOT EXISTS(SELECT 1 FROM Brands WHERE BrandName=brandName_v) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT ='Podane brandName nie istnieje.';
    end if;

    SELECT Bikes.BikeID,Bikes.Quantity
    FROM Bikes
    INNER JOIN Brands ON Bikes.BrandID = Brands.BrandID
    INNER JOIN Categories ON Bikes.CategoryID = Categories.CategoryID
    WHERE Brands.BrandName LIKE brandName_v AND Categories.CategoryName LIKE categoryName_v;
end;
```

- FilterCustomer_p

```js
create
    procedure FilterCustomer_p(IN customerPhone_v varchar(255))
BEGIN
    SELECT Firstname,Surrname,Phone
    FROM Customers
    WHERE Phone LIKE customerPhone_v;
end;

```

### Widoki:

- view_active_rents

```js
CREATE VIEW view_active_rents AS
SELECT CONCAT(c.Firstname, ' ', c.Surrname) AS CustomerName,
       r.BikeID                             AS BikeID,
       b.BrandName                          AS BrandName,
       r.RentDate                           AS RentDate,
       RentalPrice_f(r.RentID)              AS RentPrice
FROM Rents r
    LEFT JOIN Customers c ON r.CustomerID = c.CustomerID
    LEFT JOIN Bikes bi ON r.BikeID = bi.BikeID
    JOIN Brands b ON bi.BrandID = b.BrandID
WHERE r.ReturnDate IS NULL
```

- view_bestsellers

```js
CREATE VIEW view_bestsellers AS
SELECT r.BikeID            AS BikeID,
       br.BrandName        AS Brand,
       c.CategoryName      AS Category,
       COUNT(r.RentID)     AS Rents
FROM Rents r
    JOIN Bikes bi ON r.BikeID = bi.BikeID
    JOIN Brands br ON bi.BrandID = br.BrandID
    JOIN Categories c ON bi.CategoryID = c.CategoryID
GROUP BY r.BikeID
ORDER BY COUNT(r.RentID) DESC
LIMIT 10
```

- view_bestselling_brands

```js
CREATE VIEW view_bestselling_brands AS
SELECT br.BrandName        AS Brand,
       COUNT(r.RentID)     AS Rents
FROM Rents r
    JOIN Bikes bi ON r.BikeID = bi.BikeID
    JOIN Brands br ON bi.BrandID = br.BrandID
GROUP BY bi.BrandID
ORDER BY COUNT(r.RentID) DESC
LIMIT 2
```

- view_bike_stock

```js
CREATE VIEW view_bike_stock AS
SELECT bi.BikeID            AS BikeID,
       br.BrandName         AS Brand,
       c.CategoryName       AS Category,
       bi.Quantity          AS Quantity,
       (SELECT rph.HourlyPrice
        FROM RentPriceHist rph
        WHERE rph.BikeID = bi.BikeID
          AND rph.EndDate IS NULL)      AS HourlyPrice
FROM Bikes bi
    JOIN Brands br ON bi.BrandID = br.BrandID
    JOIN Categories c ON bi.CategoryID = c.CategoryID
```

- view_most_rented_category

```js
CREATE VIEW view_most_rented_category AS
SELECT c.CategoryName       AS Category,
       COUNT(r.RentID)      AS Rents
FROM Rents r
    JOIN Bikes bi ON r.BikeID = bi.BikeID
    JOIN Categories c ON bi.CategoryID = c.CategoryID
GROUP BY bi.CategoryID
ORDER BY COUNT(r.RentID) DESC
LIMIT 1
```

- view_customers

```js
CREATE VIEW view_customers AS
    SELECT * FROM Customers
```
