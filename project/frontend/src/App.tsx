import { BrowserRouter, Link, Route, Routes } from "react-router-dom";
import { useState } from "react";
import "./App.css";

import {
  Home as HomeIcon,
  Bike as BikeIcon,
  Notebook as RentsIcon,
  Contact as CustomerIcon,
} from "lucide-react";

// sites
import Bikes from "./sites/BikesPage";
import HomePage from "./sites/HomePage";
import RentsPage from "./sites/RentsPage";

// types
import { type Bike } from "./types";
import CustomersPage from "./sites/CustomersPage";

function App() {
  return (
    <BrowserRouter>
      {/* NavBar for all sites */}
      <nav className="sticky top-0 z-50 bg-slate-900/80 backdrop-blur-md border-b border-slate-800 px-6 py-4 flex justify-between items-center">
        <div className="flex items-center gap-12">
          <Link
            to="/"
            className="text-slate-400 hover:text-indigo-400 transition-colors p-2 rounded-lg hover:bg-slate-800/50 flex flex-col items-center"
          >
            <HomeIcon className="w-6 h-6" />
            Home
          </Link>
          <Link
            to="/rents"
            className="text-slate-400 hover:text-indigo-400 transition-colors p-2 rounded-lg hover:bg-slate-800/50 flex flex-col items-center"
          >
            <RentsIcon className="w-6 h-6" />
            Rents
          </Link>
          <Link
            to="/customers"
            className="text-slate-400 hover:text-indigo-400 transition-colors p-2 rounded-lg hover:bg-slate-800/50 flex flex-col items-center"
          >
            <CustomerIcon className="w-6 h-6" />
            Customers
          </Link>
          <Link
            to="/bikes"
            className="text-slate-400 hover:text-indigo-400 transition-colors p-2 rounded-lg hover:bg-slate-800/50 flex flex-col items-center"
          >
            <BikeIcon className="w-6 h-6" />
            Bikes
          </Link>
        </div>
      </nav>

      {/* Routes */}
      <main className="max-w-7xl mx-auto px-4 py-8">
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/rents" element={<RentsPage />} />
          <Route path="/customers" element={<CustomersPage />} />
          <Route path="/bikes" element={<Bikes />} />
        </Routes>
      </main>
    </BrowserRouter>
  );
}

export default App;
