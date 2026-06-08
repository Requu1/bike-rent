import { useMemo } from "react";
import { useView } from "../hooks/useApi";
import type { RentHist, PriceHist } from "../types";

export default function HistPage() {
  const {
    data: rentHist,
    loading: loadingRent,
    refetch: refetchRent,
  } = useView<RentHist>("views/hist-rents");

  const {
    data: priceHist,
    loading: loadingPrice,
    refetch: refetchPrice,
  } = useView<PriceHist>("views/hist-price");

  return (
    <div>
      <h1 className="text-3xl font-extrabold tracking-tight mb-8">History</h1>

      <div className="flex gap-6 items-start">
        {/* ── Rent History ── */}
        <div className="flex-1 min-w-0">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-white">Rent History</h2>
            <button
              onClick={refetchRent}
              className="text-xs px-3 py-1.5 rounded-lg border border-slate-700 text-slate-400 hover:text-white hover:bg-slate-800 transition"
            >
              Refresh
            </button>
          </div>

          {loadingRent ? (
            <div className="text-slate-400 py-8 text-center bg-slate-900 border border-slate-800 rounded-xl">
              Loading...
            </div>
          ) : rentHist.length === 0 ? (
            <div className="text-center py-10 bg-slate-900 rounded-xl border border-slate-800">
              <p className="text-slate-400">No rent history in database.</p>
            </div>
          ) : (
            <div className="bg-slate-900 border border-slate-800 rounded-xl p-4 overflow-x-auto">
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b border-slate-800 text-slate-500 text-xs uppercase tracking-wider">
                    <th className="px-3 py-3 text-left font-medium">ID</th>
                    <th className="px-3 py-3 text-left font-medium">Bike</th>
                    <th className="px-3 py-3 text-left font-medium">Brand</th>
                    <th className="px-3 py-3 text-left font-medium">
                      Customer
                    </th>
                    <th className="px-3 py-3 text-left font-medium">
                      Rent date
                    </th>
                    <th className="px-3 py-3 text-left font-medium">
                      Return date
                    </th>
                  </tr>
                </thead>
                <tbody>
                  {rentHist.map((r) => (
                    <tr
                      key={r.rentId}
                      className="border-b border-slate-800 last:border-0 hover:bg-slate-800/40 transition"
                    >
                      <td className="px-3 py-3 text-slate-500">#{r.rentId}</td>
                      <td className="px-3 py-3 text-slate-400">#{r.bikeId}</td>
                      <td className="px-3 py-3 text-white">{r.brandName}</td>
                      <td className="px-3 py-3 text-white">
                        {r.firstName} {r.surrName}
                      </td>
                      <td className="px-3 py-3 text-slate-400">
                        {new Date(r.rentDate).toLocaleString("pl-PL")}
                      </td>
                      <td className="px-3 py-3 text-slate-400">
                        {r.returnDate
                          ? new Date(r.returnDate).toLocaleString("pl-PL")
                          : "—"}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>

        {/* Divider */}
        <div className="w-px self-stretch bg-slate-800 shrink-0" />

        {/* ── Price History ── */}
        <div className="flex-1 min-w-0">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-white">Price History</h2>
            <button
              onClick={refetchPrice}
              className="text-xs px-3 py-1.5 rounded-lg border border-slate-700 text-slate-400 hover:text-white hover:bg-slate-800 transition"
            >
              Refresh
            </button>
          </div>

          {loadingPrice ? (
            <div className="text-slate-400 py-8 text-center bg-slate-900 border border-slate-800 rounded-xl">
              Loading...
            </div>
          ) : priceHist.length === 0 ? (
            <div className="text-center py-10 bg-slate-900 rounded-xl border border-slate-800">
              <p className="text-slate-400">No price history in database.</p>
            </div>
          ) : (
            <div className="bg-slate-900 border border-slate-800 rounded-xl p-4 overflow-x-auto">
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b border-slate-800 text-slate-500 text-xs uppercase tracking-wider">
                    <th className="px-3 py-3 text-left font-medium">ID</th>
                    <th className="px-3 py-3 text-left font-medium">Bike</th>
                    <th className="px-3 py-3 text-left font-medium">Brand</th>
                    <th className="px-3 py-3 text-left font-medium">Price/h</th>
                    <th className="px-3 py-3 text-left font-medium">Start</th>
                    <th className="px-3 py-3 text-left font-medium">End</th>
                  </tr>
                </thead>
                <tbody>
                  {priceHist.map((p) => (
                    <tr
                      key={p.rentPriceHistId}
                      className="border-b border-slate-800 last:border-0 hover:bg-slate-800/40 transition"
                    >
                      <td className="px-3 py-3 text-slate-500">
                        #{p.rentPriceHistId}
                      </td>
                      <td className="px-3 py-3 text-slate-400">#{p.bikeId}</td>
                      <td className="px-3 py-3 text-white">{p.brandName}</td>
                      <td className="px-3 py-3 text-indigo-400 font-medium">
                        {p.hourlyPrice.toFixed(2)} zł
                      </td>
                      <td className="px-3 py-3 text-slate-400">
                        {new Date(p.startDate).toLocaleDateString("pl-PL")}
                      </td>
                      <td className="px-3 py-3 text-slate-400">
                        {p.endDate
                          ? new Date(p.endDate).toLocaleDateString("pl-PL")
                          : "—"}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
