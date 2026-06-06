import { useState } from "react";
import { useView, callProcedure } from "../hooks/useApi";
import type { Customer } from "../types";

export default function CustomersPage() {
  const {
    data: customers,
    loading,
    refetch,
  } = useView<Customer>("views/customers");

  // FilterCustomer
  const [filterPhone, setFilterPhone] = useState("");
  const [filterResults, setFilterResults] = useState<Customer[] | null>(null);
  const [filterError, setFilterError] = useState<string | null>(null);
  const [filterLoading, setFilterLoading] = useState(false);

  // AddCustomer
  const [firstName, setFirstName] = useState("");
  const [surrName, setSurrName] = useState("");
  const [phone, setPhone] = useState("");
  const [addError, setAddError] = useState<string | null>(null);
  const [addSuccess, setAddSuccess] = useState(false);
  const [addLoading, setAddLoading] = useState(false);

  async function handleFilter() {
    if (!filterPhone.trim()) {
      setFilterError("Input a phone number.");
      return;
    }
    setFilterLoading(true);
    setFilterError(null);
    try {
      const res = await fetch(
        `http://localhost:8080/api/customers/filter?phone=${encodeURIComponent(filterPhone)}`,
      );
      if (!res.ok) throw new Error(await res.text());
      setFilterResults(await res.json());
    } catch (e: any) {
      setFilterError(e.message);
      setFilterResults(null);
    } finally {
      setFilterLoading(false);
    }
  }

  function clearFilter() {
    setFilterPhone("");
    setFilterResults(null);
    setFilterError(null);
  }

  async function handleAddCustomer() {
    if (!firstName.trim() || !surrName.trim() || !phone.trim()) {
      setAddError("Missing input data.");
      return;
    }
    setAddLoading(true);
    setAddError(null);
    setAddSuccess(false);
    try {
      await callProcedure("customers", { firstName, surrName, phone });
      setAddSuccess(true);
      setFirstName("");
      setSurrName("");
      setPhone("");
      refetch();
    } catch (e: any) {
      setAddError(e.message);
    } finally {
      setAddLoading(false);
    }
  }

  const displayedCustomers = filterResults
    ? customers.filter((c) => filterResults.some((f) => f.phone === c.phone))
    : customers;

  return (
    <div>
      <h1 className="text-3xl font-extrabold tracking-tight mb-8">Customers</h1>

      {/* Filter bar */}
      <div className="flex gap-3 mb-6 items-end">
        <div className="flex flex-col gap-1">
          <label className="text-xs text-slate-500">Phone</label>
          <input
            type="text"
            value={filterPhone}
            onChange={(e) => {
              setFilterPhone(e.target.value);
              setFilterError(null);
            }}
            onKeyDown={(e) => e.key === "Enter" && handleFilter()}
            placeholder="e.g. +48123123123"
            className="bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-indigo-500 w-44"
          />
        </div>
        <button
          onClick={handleFilter}
          disabled={filterLoading}
          className="px-4 py-2 rounded-lg bg-indigo-600 hover:bg-indigo-500 disabled:opacity-50 text-white text-sm transition"
        >
          {filterLoading ? "..." : "Filter"}
        </button>
        <button
          onClick={clearFilter}
          className="px-4 py-2 rounded-lg border border-slate-700 text-slate-400 hover:text-white hover:bg-slate-800 text-sm transition"
        >
          Clear
        </button>
        {filterError && (
          <p className="text-red-400 text-sm self-center">{filterError}</p>
        )}
        {filterResults !== null && (
          <p className="text-slate-500 text-sm self-center">
            {filterResults.length} result{filterResults.length !== 1 && "s"}
          </p>
        )}
      </div>

      {/* Customers table */}
      {loading ? (
        <div className="text-slate-400 py-8 text-center">Loading...</div>
      ) : displayedCustomers.length === 0 ? (
        <div className="text-center py-10 bg-slate-900 rounded-xl border border-slate-800">
          <p className="text-slate-400">
            {filterResults !== null
              ? "No Customers with this number."
              : "No Customers in database."}
          </p>
        </div>
      ) : (
        <div className="bg-slate-900 border border-slate-800 rounded-xl p-4">
          <table className="w-full text-sm">
            <thead>
              <tr className="border-b border-slate-800 text-slate-500 text-xs uppercase tracking-wider">
                <th className="px-4 py-3 text-left font-medium">ID</th>
                <th className="px-4 py-3 text-left font-medium">First name</th>
                <th className="px-4 py-3 text-left font-medium">Surname</th>
                <th className="px-4 py-3 text-left font-medium">Phone</th>
              </tr>
            </thead>
            <tbody>
              {displayedCustomers.map((c) => (
                <tr
                  key={c.customerId}
                  className="border-b border-slate-800 text-slate-500 last:border-0 hover:bg-slate-800/40 transition"
                >
                  <td className="px-4 py-3">#{c.customerId}</td>
                  <td className="px-4 py-3 text-white">{c.firstName}</td>
                  <td className="px-4 py-3 text-white">{c.surrName}</td>
                  <td className="px-4 py-3 ">{c.phone}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {/* Add customer */}
      <div className="mt-10 bg-slate-900 border border-slate-800 rounded-xl p-5 max-w-lg">
        <p className="text-sm font-semibold text-white mb-4">Add customer</p>
        <div className="flex gap-3 mb-3">
          <div className="flex flex-col gap-1 flex-1">
            <label className="text-xs text-slate-500">First name</label>
            <input
              type="text"
              value={firstName}
              onChange={(e) => {
                setFirstName(e.target.value);
                setAddError(null);
                setAddSuccess(false);
              }}
              placeholder="Jan"
              className="bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-indigo-500"
            />
          </div>
          <div className="flex flex-col gap-1 flex-1">
            <label className="text-xs text-slate-500">Surname</label>
            <input
              type="text"
              value={surrName}
              onChange={(e) => {
                setSurrName(e.target.value);
                setAddError(null);
                setAddSuccess(false);
              }}
              placeholder="Kowalski"
              className="bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-indigo-500"
            />
          </div>
        </div>
        <div className="flex flex-col gap-1 mb-3">
          <label className="text-xs text-slate-500">Phone</label>
          <input
            type="text"
            value={phone}
            onChange={(e) => {
              setPhone(e.target.value);
              setAddError(null);
              setAddSuccess(false);
            }}
            onKeyDown={(e) => e.key === "Enter" && handleAddCustomer()}
            placeholder="500123456"
            className="bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-indigo-500"
          />
        </div>
        {addError && <p className="text-red-400 text-xs mb-2">{addError}</p>}
        {addSuccess && (
          <p className="text-green-400 text-xs mb-2">Customer Added!</p>
        )}
        <button
          onClick={handleAddCustomer}
          disabled={addLoading}
          className="w-full py-2 rounded-lg bg-indigo-600 hover:bg-indigo-500 disabled:opacity-50 text-white text-sm font-medium transition"
        >
          {addLoading ? "Saving..." : "Add customer"}
        </button>
      </div>
    </div>
  );
}
