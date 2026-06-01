import { useState } from "react";
import { useView, callProcedure } from "../hooks/useApi";
import type { ActiveRent, CustomerRent } from "../types";

export default function RentsPage() {
  const {
    data: activeRents,
    loading,
    refetch,
  } = useView<ActiveRent>("rents/active");

  // CurrentRentsForCustomer
  const [customerId, setCustomerId] = useState("");
  const [customerRents, setCustomerRents] = useState<CustomerRent[] | null>(
    null,
  );
  const [customerError, setCustomerError] = useState<string | null>(null);
  const [customerLoading, setCustomerLoading] = useState(false);

  // AddRent
  const [arBikeId, setArBikeId] = useState("");
  const [arCustomerId, setArCustomerId] = useState("");
  const [arError, setArError] = useState<string | null>(null);
  const [arSuccess, setArSuccess] = useState(false);
  const [arLoading, setArLoading] = useState(false);

  // EndRent
  const [erRentId, setErRentId] = useState("");
  const [erError, setErError] = useState<string | null>(null);
  const [erSuccess, setErSuccess] = useState(false);
  const [erLoading, setErLoading] = useState(false);

  async function handleCustomerFilter() {
    if (!customerId.trim()) {
      setCustomerError("Podaj Customer ID.");
      return;
    }
    setCustomerLoading(true);
    setCustomerError(null);
    try {
      const res = await fetch(
        `http://localhost:8080/api/rents/customer/${customerId}`,
      );
      if (!res.ok) throw new Error(await res.text());
      setCustomerRents(await res.json());
    } catch (e: any) {
      setCustomerError(e.message);
      setCustomerRents(null);
    } finally {
      setCustomerLoading(false);
    }
  }

  function clearCustomerFilter() {
    setCustomerId("");
    setCustomerRents(null);
    setCustomerError(null);
  }

  async function handleAddRent() {
    if (!arBikeId || !arCustomerId) {
      setArError("Wypełnij oba pola.");
      return;
    }
    setArLoading(true);
    setArError(null);
    setArSuccess(false);
    try {
      await callProcedure("rents/add", {
        bikeId: Number(arBikeId),
        customerId: Number(arCustomerId),
      });
      setArSuccess(true);
      setArBikeId("");
      setArCustomerId("");
      refetch();
    } catch (e: any) {
      setArError(e.message);
    } finally {
      setArLoading(false);
    }
  }

  async function handleEndRent() {
    if (!erRentId) {
      setErError("Podaj Rent ID.");
      return;
    }
    setErLoading(true);
    setErError(null);
    setErSuccess(false);
    try {
      await callProcedure("rents/end", { rentId: Number(erRentId) });
      setErSuccess(true);
      setErRentId("");
      refetch();
      if (customerRents !== null) handleCustomerFilter();
    } catch (e: any) {
      setErError(e.message);
    } finally {
      setErLoading(false);
    }
  }

  return (
    <div>
      <h1 className="text-3xl font-extrabold tracking-tight mb-8">Rents</h1>

      {/* Customer rents filter */}
      <div className="flex gap-3 mb-2 items-end">
        <div className="flex flex-col gap-1">
          <label className="text-xs text-slate-500">Customer ID</label>
          <input
            type="number"
            value={customerId}
            onChange={(e) => {
              setCustomerId(e.target.value);
              setCustomerError(null);
            }}
            onKeyDown={(e) => e.key === "Enter" && handleCustomerFilter()}
            placeholder="np. 1"
            className="bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-indigo-500 w-36"
          />
        </div>
        <button
          onClick={handleCustomerFilter}
          disabled={customerLoading}
          className="px-4 py-2 rounded-lg bg-indigo-600 hover:bg-indigo-500 disabled:opacity-50 text-white text-sm transition"
        >
          {customerLoading ? "..." : "Search"}
        </button>
        <button
          onClick={clearCustomerFilter}
          className="px-4 py-2 rounded-lg border border-slate-700 text-slate-400 hover:text-white hover:bg-slate-800 text-sm transition"
        >
          Clear
        </button>
        {customerError && (
          <p className="text-red-400 text-sm self-center">{customerError}</p>
        )}
        {customerRents !== null && (
          <p className="text-slate-500 text-sm self-center">
            {customerRents.length} rent{customerRents.length !== 1 && "s"}
          </p>
        )}
      </div>

      {/* Customer rents */}
      {customerRents !== null &&
        (customerRents.length === 0 ? (
          <div className="text-center py-8 bg-slate-900 rounded-xl border border-slate-800 mb-6">
            <p className="text-slate-400">
              Ten klient nie ma żadnych wypożyczeń.
            </p>
          </div>
        ) : (
          <div className="overflow-x-auto rounded-xl border border-slate-800 mb-6">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b border-slate-800 text-slate-500 text-xs uppercase tracking-wider">
                  <th className="px-4 py-3 text-left font-medium">Rent ID</th>
                  <th className="px-4 py-3 text-left font-medium">Bike ID</th>
                  <th className="px-4 py-3 text-left font-medium">Rent date</th>
                  <th className="px-4 py-3 text-left font-medium">
                    Return date
                  </th>
                  <th className="px-4 py-3 text-left font-medium">Status</th>
                </tr>
              </thead>
              <tbody>
                {customerRents.map((r) => (
                  <tr
                    key={r.RentID}
                    className="border-b border-slate-800 last:border-0 hover:bg-slate-800/40 transition"
                  >
                    <td className="px-4 py-3 text-slate-400">#{r.RentID}</td>
                    <td className="px-4 py-3 text-slate-400">#{r.BikeID}</td>
                    <td className="px-4 py-3 text-slate-300">
                      {new Date(r.RentDate).toLocaleString("pl-PL")}
                    </td>
                    <td className="px-4 py-3 text-slate-400">
                      {r.ReturnDate
                        ? new Date(r.ReturnDate).toLocaleString("pl-PL")
                        : "—"}
                    </td>
                    <td className="px-4 py-3">
                      {r.ReturnDate ? (
                        <span className="text-xs px-2 py-1 rounded-full bg-slate-800 text-slate-400">
                          returned
                        </span>
                      ) : (
                        <span className="text-xs px-2 py-1 rounded-full bg-indigo-950 text-indigo-400">
                          active
                        </span>
                      )}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        ))}

      {/* Active rents */}
      <h2 className="text-lg font-semibold text-white mb-4">Active rents</h2>
      {loading ? (
        <div className="text-slate-400 py-8 text-center">Ładowanie...</div>
      ) : activeRents.length === 0 ? (
        <div className="text-center py-10 bg-slate-900 rounded-xl border border-slate-800">
          <p className="text-slate-400">Brak aktywnych wypożyczeń.</p>
        </div>
      ) : (
        <div className="overflow-x-auto rounded-xl border border-slate-800">
          <table className="w-full text-sm">
            <thead>
              <tr className="border-b border-slate-800 text-slate-500 text-xs uppercase tracking-wider">
                <th className="px-4 py-3 text-left font-medium">Customer</th>
                <th className="px-4 py-3 text-left font-medium">Bike</th>
                <th className="px-4 py-3 text-left font-medium">Brand</th>
                <th className="px-4 py-3 text-left font-medium">Rent date</th>
                <th className="px-4 py-3 text-right font-medium">
                  Price so far
                </th>
              </tr>
            </thead>
            <tbody>
              {activeRents.map((rent, i) => (
                <tr
                  key={i}
                  className="border-b border-slate-800 last:border-0 hover:bg-slate-800/40 transition"
                >
                  <td className="px-4 py-3 text-white">{rent.CustomerName}</td>
                  <td className="px-4 py-3 text-slate-400">#{rent.BikeID}</td>
                  <td className="px-4 py-3 text-slate-300">{rent.BrandName}</td>
                  <td className="px-4 py-3 text-slate-400">
                    {new Date(rent.RentDate).toLocaleString("pl-PL")}
                  </td>
                  <td className="px-4 py-3 text-right text-indigo-400 font-medium">
                    {rent.RentPrice} zł
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {/* Operations */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mt-4">
        {/* Add rent */}
        <div className="bg-slate-900 border border-slate-800 rounded-xl p-5">
          <p className="text-sm font-semibold text-white mb-4">Add rent</p>
          <div className="flex gap-3 mb-3">
            <div className="flex flex-col gap-1 flex-1">
              <label className="text-xs text-slate-500">Bike ID</label>
              <input
                type="number"
                value={arBikeId}
                onChange={(e) => {
                  setArBikeId(e.target.value);
                  setArError(null);
                  setArSuccess(false);
                }}
                placeholder="1"
                className="bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-indigo-500"
              />
            </div>
            <div className="flex flex-col gap-1 flex-1">
              <label className="text-xs text-slate-500">Customer ID</label>
              <input
                type="number"
                value={arCustomerId}
                onChange={(e) => {
                  setArCustomerId(e.target.value);
                  setArError(null);
                  setArSuccess(false);
                }}
                placeholder="1"
                className="bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-indigo-500"
              />
            </div>
          </div>
          {arError && <p className="text-red-400 text-xs mb-2">{arError}</p>}
          {arSuccess && (
            <p className="text-green-400 text-xs mb-2">Wypożyczenie dodane!</p>
          )}
          <button
            onClick={handleAddRent}
            disabled={arLoading}
            className="w-full py-2 rounded-lg bg-indigo-600 hover:bg-indigo-500 disabled:opacity-50 text-white text-sm font-medium transition"
          >
            {arLoading ? "Saving..." : "Add rent"}
          </button>
        </div>

        {/* End rent */}
        <div className="bg-slate-900 border border-slate-800 rounded-xl p-5">
          <p className="text-sm font-semibold text-white mb-4">End rent</p>
          <div className="flex flex-col gap-1 mb-3">
            <label className="text-xs text-slate-500">Rent ID</label>
            <input
              type="number"
              value={erRentId}
              onChange={(e) => {
                setErRentId(e.target.value);
                setErError(null);
                setErSuccess(false);
              }}
              onKeyDown={(e) => e.key === "Enter" && handleEndRent()}
              placeholder="1"
              className="bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-indigo-500"
            />
          </div>
          {erError && <p className="text-red-400 text-xs mb-2">{erError}</p>}
          {erSuccess && (
            <p className="text-green-400 text-xs mb-2">
              Wypożyczenie zakończone!
            </p>
          )}
          <button
            onClick={handleEndRent}
            disabled={erLoading}
            className="w-full py-2 rounded-lg bg-red-700 hover:bg-red-600 disabled:opacity-50 text-white text-sm font-medium transition"
          >
            {erLoading ? "Ending..." : "End rent"}
          </button>
        </div>
      </div>
    </div>
  );
}
