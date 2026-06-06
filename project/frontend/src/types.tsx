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
  rentId: number;
  customerName: string;
  bikeId: number;
  brandName: string;
  rentDate: string;
  rentPrice: number;
}

export interface RentHist {
  rentId: number;
  bikeId: number;
  brandName: string;
  firstName: string;
  surrName: string;
  rentDate: number;
  returnDate: number;
}

export interface PriceHist {
  rentPriceHistId: number;
  bikeId: number;
  brandName: string;
  hourlyPrice: number;
  startDate: string;
  endDate: string;
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

export interface Brand {
  brandId: number;
  brandName: string;
}

export interface Category {
  categoryId: number;
  categoryName: string;
}
