export interface Bike {
  BikeID: number;
  Brand: string;
  Category: string;
  Quantity: number;
  HourlyPrice: number;
}

export interface Bestseller {
  BikeID: number;
  Brand: string;
  Category: string;
  Rents: number;
}

export interface BestBrand {
  Brand: string;
  Rents: number;
}

export interface TopCategory {
  Category: string;
  Rents: number;
}

export interface FilterResult {
  BikeID: number;
  Quantity: number;
}

export interface ActiveRent {
  CustomerName: string;
  BikeID: number;
  BrandName: string;
  RentDate: string;
  RentPrice: number;
}

export interface CustomerRent {
  RentID: number;
  BikeID: number;
  RentDate: string;
  ReturnDate: string | null;
}

export interface Customer {
  CustomerID: number;
  Firstname: string;
  Surrname: string;
  Phone: string;
}
