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
