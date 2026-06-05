export interface Bike {
  bikeId: number;
  brand: string;
  category: string;
  quantity: number;
  hourlyPrice: number;
}

export interface Bestseller {
  bikeId: number;
  brand: string;
  category: string;
  rents: number;
}

export interface BestBrand {
  brand: string;
  rents: number;
}

export interface TopCategory {
  category: string;
  rents: number;
}

export interface FilterResult {
  bikeId: number;
  quantity: number;
}

export interface ActiveRent {
  customerName: string;
  bikeId: number;
  brandName: string;
  rentDate: string;
  rentPrice: number;
}

export interface RentHist {
  RentID: number;
  BikeID: number;
  BrandName: string;
  Firstname: string;
  Surrname: string;
  RentDate: number;
  ReturnDate: number;
}

export interface PriceHist {
  RentPriceHistID: number;
  BikeID: number;
  BrandName: string;
  HourlyPrice: number;
  StartDate: string;
  EndDate: string;
}

export interface CustomerRent {
  rentId: number;
  bikeId: number;
  rentDate: string;
  returnDate: string | null;
}

export interface Customer {
  customerId: number;
  firstName: string;
  surrName: string;
  phone: string;
}
