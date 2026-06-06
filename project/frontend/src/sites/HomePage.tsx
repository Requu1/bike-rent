import { Link } from "react-router-dom";
import {
  Bike as BikeIcon,
  Notebook as RentsIcon,
  Contact as CustomerIcon,
  History as HistoryIcon,
} from "lucide-react";
import { useState } from "react";

type IncomeResult = number;

export default function HomePage() {
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const [income, setIncome] = useState<number | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  async function handleIncome() {
    if (!startDate || !endDate) {
      setError("Wybierz obie daty.");
      return;
    }
    if (startDate > endDate) {
      setError("Data początkowa nie może być późniejsza niż końcowa.");
      return;
    }
    setLoading(true);
    setError(null);
    setIncome(null);
    try {
      const res = await fetch(
        `http://localhost:8080/api/rents/income?startDate=${startDate}&endDate=${endDate}`,
      );
      if (!res.ok) throw new Error(await res.text());
      const data: IncomeResult = await res.json();
      setIncome(data);
    } catch (e: any) {
      setError(e.message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="flex flex-col gap-12">
      <div className="text-center pt-6">
        <h1 className="text-4xl font-extrabold tracking-tight mb-3">
          Potępa - Patla - Bike Rent
        </h1>
        <p className="text-slate-400 text-lg">Bike rental control panel App</p>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 gap-5">
        <Link
          to="/bikes"
          className="bg-slate-900 border border-slate-800 hover:border-slate-600 rounded-2xl p-8 flex flex-col gap-3 transition"
        >
          <BikeIcon className="w-8 h-8 text-indigo-400" />
          <p className="text-white text-xl font-semibold">Bikes</p>
          <p className="text-slate-400 text-sm">
            Search, add, manage bikes stock
          </p>
        </Link>

        <Link
          to="/rents"
          className="bg-slate-900 border border-slate-800 hover:border-slate-600 rounded-2xl p-8 flex flex-col gap-3 transition"
        >
          <RentsIcon className="w-8 h-8 text-indigo-400" />
          <p className="text-white text-xl font-semibold">Rents</p>
          <p className="text-slate-400 text-sm">
            Active rents, add, delete rent
          </p>
        </Link>

        <Link
          to="/customers"
          className="bg-slate-900 border border-slate-800 hover:border-slate-600 rounded-2xl p-8 flex flex-col gap-3 transition"
        >
          <CustomerIcon className="w-8 h-8 text-indigo-400" />
          <p className="text-white text-xl font-semibold">Customers</p>
          <p className="text-slate-400 text-sm">Our clients</p>
        </Link>

        <Link
          to="/hist"
          className="bg-slate-900 border border-slate-800 hover:border-slate-600 rounded-2xl p-8 flex flex-col gap-3 transition"
        >
          <HistoryIcon className="w-8 h-8 text-indigo-400" />
          <p className="text-white text-xl font-semibold">History</p>
          <p className="text-slate-400 text-sm">Historical rents and prices</p>
        </Link>
      </div>

      <div className="bg-slate-900 border border-slate-800 rounded-2xl p-7">
        <p className="text-lg font-semibold text-white mb-1">Income</p>
        <p className="text-slate-500 text-sm mb-6">
          Calculate income from a certain period
        </p>
        <div className="flex flex-wrap gap-4 items-end">
          <div className="flex flex-col gap-1">
            <label className="text-xs text-slate-500">From</label>
            <input
              type="date"
              value={startDate}
              onChange={(e) => {
                setStartDate(e.target.value);
                setError(null);
                setIncome(null);
              }}
              className="bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-indigo-500 [color-scheme:dark]"
            />
          </div>
          <div className="flex flex-col gap-1">
            <label className="text-xs text-slate-500">To</label>
            <input
              type="date"
              value={endDate}
              onChange={(e) => {
                setEndDate(e.target.value);
                setError(null);
                setIncome(null);
              }}
              className="bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-indigo-500 [color-scheme:dark]"
            />
          </div>
          <button
            onClick={handleIncome}
            disabled={loading}
            className="px-6 py-2 rounded-lg bg-indigo-600 hover:bg-indigo-500 disabled:opacity-50 text-white text-sm font-medium transition"
          >
            {loading ? "Calculating..." : "Calculate income"}
          </button>
        </div>
        {error && <p className="text-red-400 text-sm mt-4">{error}</p>}
        {income !== null && (
          <div className="mt-6 flex items-baseline gap-3">
            <span className="text-slate-400 text-sm">Przychód:</span>
            <span className="text-3xl font-bold text-indigo-400">
              {income.toLocaleString("pl-PL", { minimumFractionDigits: 2 })} zł
            </span>
            <span className="text-slate-500 text-sm">
              ({startDate} – {endDate})
            </span>
          </div>
        )}
      </div>
    </div>
  );
}
