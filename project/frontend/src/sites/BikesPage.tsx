import { useState } from "react";
import { useView, callProcedure } from "../hooks/useApi";
import {
  type Bike,
  type Bestseller,
  type BestBrand,
  type TopCategory,
  type FilterResult,
  type Category,
  type Brand,
} from "../types";

type Modal = "bike" | "brand" | "category" | null;

export default function BikesPage() {
  const { data: bikes, loading, refetch } = useView<Bike>("views/bike-stock");
  const { data: bestsellers } = useView<Bestseller>("views/best-sellers");
  const { data: bestBrands } = useView<BestBrand>("views/best-selling-brands");
  const { data: topCategory } = useView<TopCategory>(
    "views/most-rented-category",
  );
  const { data: categories } = useView<Category>("views/categories");
  const { data: brands } = useView<Brand>("views/brands");

  const [modal, setModal] = useState<Modal>(null);

  // FilterBike
  const [filterCategory, setFilterCategory] = useState("");
  const [filterBrand, setFilterBrand] = useState("");
  const [filterResults, setFilterResults] = useState<FilterResult[] | null>(
    null,
  );
  const [filterError, setFilterError] = useState<string | null>(null);
  const [filterLoading, setFilterLoading] = useState(false);

  // AddQuantity
  const [qBikeId, setQBikeId] = useState("");
  const [qQty, setQQty] = useState("");
  const [qError, setQError] = useState<string | null>(null);
  const [qSuccess, setQSuccess] = useState(false);
  const [qLoading, setQLoading] = useState(false);

  // ChangeRentPrice
  const [pBikeId, setPBikeId] = useState("");
  const [pPrice, setPPrice] = useState("");
  const [pError, setPError] = useState<string | null>(null);
  const [pSuccess, setPSuccess] = useState(false);
  const [pLoading, setPLoading] = useState(false);

  async function handleFilter() {
    if (!filterCategory.trim() || !filterBrand.trim()) {
      setFilterError("Missing Input Data.");
      return;
    }
    setFilterError(null);
    setFilterLoading(true);
    try {
      const res = await fetch(
        `http://localhost:8080/api/bikes?categoryName=${encodeURIComponent(filterCategory)}&brandName=${encodeURIComponent(filterBrand)}`,
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
    setFilterCategory("");
    setFilterBrand("");
    setFilterResults(null);
    setFilterError(null);
  }

  async function handleAddQuantity() {
    if (!qBikeId || !qQty) {
      setQError("Missing Input Data.");
      return;
    }
    setQLoading(true);
    setQError(null);
    setQSuccess(false);
    try {
      const res = await fetch(
        `http://localhost:8080/api/bikes/${encodeURIComponent(qQty)}/add-quantity?quantity=${encodeURIComponent(qBikeId)}`,
        { method: "PATCH" },
      );
      if (!res.ok) throw new Error(await res.text());
      setQSuccess(true);
      setQBikeId("");
      setQQty("");
      refetch();
    } catch (e: any) {
      setQError(e.message);
    } finally {
      setQLoading(false);
    }
  }

  async function handleChangePrice() {
    if (!pBikeId || !pPrice) {
      setPError("Missing Input Data.");
      return;
    }
    setPLoading(true);
    setPError(null);
    setPSuccess(false);
    try {
      await callProcedure(`rent-price-hist`, {
        bikeId: Number(pBikeId),
        hourlyPrice: Number(pPrice),
      });
      setPSuccess(true);
      setPBikeId("");
      setPPrice("");
      refetch();
    } catch (e: any) {
      setPError(e.message);
    } finally {
      setPLoading(false);
    }
  }

  const displayedBikes = filterResults
    ? bikes.filter((b) => filterResults.some((f) => f.bikeId === b.bikeId))
    : bikes;

  return (
    <div>
      {/* Header */}
      <div className="flex justify-between items-center mb-8">
        <h1 className="text-3xl font-extrabold tracking-tight">Bikes</h1>
        <div className="flex gap-2">
          <button
            onClick={() => setModal("category")}
            className="px-4 py-2 rounded-lg border border-slate-700 text-slate-300 hover:bg-slate-800 transition text-sm"
          >
            + Category
          </button>
          <button
            onClick={() => setModal("brand")}
            className="px-4 py-2 rounded-lg border border-slate-700 text-slate-300 hover:bg-slate-800 transition text-sm"
          >
            + Brand
          </button>
          <button
            onClick={() => setModal("bike")}
            className="px-4 py-2 rounded-lg bg-indigo-600 hover:bg-indigo-500 text-white transition text-sm font-medium"
          >
            + Add bike
          </button>
        </div>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8">
        {/* Bestsellers */}
        <div className="bg-slate-900 border border-slate-800 rounded-xl p-4">
          <p className="text-xs text-slate-500 uppercase tracking-wider mb-3">
            Top 10 bestsellers
          </p>
          <div className="flex flex-col gap-1">
            {bestsellers.slice(0, 5).map((b, i) => (
              <div
                key={b.bikeId}
                className="flex justify-between items-center text-sm"
              >
                <span className="text-slate-400">
                  <span className="text-slate-600 mr-2">#{i + 1}</span>
                  {b.brand} · {b.category}
                </span>
                <span className="text-indigo-400 font-medium">{b.rents}x</span>
              </div>
            ))}
          </div>
        </div>

        {/* Best brands */}
        <div className="bg-slate-900 border border-slate-800 rounded-xl p-4">
          <p className="text-xs text-slate-500 uppercase tracking-wider mb-3">
            Top brands
          </p>
          <div className="flex flex-col gap-3">
            {bestBrands.map((b) => (
              <div key={b.brand}>
                <div className="flex justify-between text-sm mb-1">
                  <span className="text-slate-300">{b.brand}</span>
                  <span className="text-slate-400">{b.rents} rents</span>
                </div>
                <div className="w-full bg-slate-800 rounded-full h-1.5">
                  <div
                    className="bg-indigo-500 h-1.5 rounded-full"
                    style={{
                      width: `${Math.round(
                        (b.rents / (bestBrands[0]?.rents || 1)) * 100,
                      )}%`,
                    }}
                  />
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Most rented category */}
        <div className="bg-slate-900 border border-slate-800 rounded-xl p-4 flex flex-col justify-between">
          <p className="text-xs text-slate-500 uppercase tracking-wider mb-3">
            Most rented category
          </p>
          {topCategory[0] && (
            <>
              <p className="text-2xl font-bold text-white">
                {topCategory[0].category}
              </p>
              <p className="text-slate-400 text-sm mt-1">
                {topCategory[0].rents} total rents
              </p>
            </>
          )}
        </div>
      </div>

      {/* Brands & Categories */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-8">
        {/* Brands */}
        <div className="bg-slate-900 border border-slate-800 rounded-xl p-4">
          <p className="text-xs text-slate-500 uppercase tracking-wider mb-3">
            Brands
          </p>
          <div className="flex flex-col gap-1">
            {brands.map((b) => (
              <div
                key={b.brandId}
                className="flex items-center justify-between text-sm py-1.5 border-b border-slate-800 last:border-0"
              >
                <span className="text-slate-300">{b.brandName}</span>
                <span className="text-xs text-slate-600">#{b.brandId}</span>
              </div>
            ))}
          </div>
        </div>

        {/* Categories */}
        <div className="bg-slate-900 border border-slate-800 rounded-xl p-4">
          <p className="text-xs text-slate-500 uppercase tracking-wider mb-3">
            Categories
          </p>
          <div className="flex flex-col gap-1">
            {categories.map((c) => (
              <div
                key={c.categoryId}
                className="flex items-center justify-between text-sm py-1.5 border-b border-slate-800 last:border-0"
              >
                <span className="text-slate-300">{c.categoryName}</span>
                <span className="text-xs text-slate-600">#{c.categoryId}</span>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Filter bar */}
      <div className="flex gap-3 mb-6 items-end">
        <div className="flex flex-col gap-1">
          <label className="text-xs text-slate-500">Category</label>
          <input
            type="text"
            value={filterCategory}
            onChange={(e) => setFilterCategory(e.target.value)}
            placeholder="e.g. Mountain"
            className="bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-indigo-500 w-40"
          />
        </div>
        <div className="flex flex-col gap-1">
          <label className="text-xs text-slate-500">Brand</label>
          <input
            type="text"
            value={filterBrand}
            onChange={(e) => setFilterBrand(e.target.value)}
            onKeyDown={(e) => e.key === "Enter" && handleFilter()}
            placeholder="e.g. Trek"
            className="bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-indigo-500 w-40"
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

      {/* Bike grid */}
      {loading ? (
        <div className="text-slate-400 py-12 text-center">Loading...</div>
      ) : displayedBikes.length === 0 ? (
        <div className="text-center py-12 bg-slate-900 rounded-xl border border-slate-800">
          <p className="text-slate-400">
            {filterResults !== null
              ? "No Bikes found."
              : "No Bikes in Database."}
          </p>
        </div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
          {displayedBikes.map((bike) => (
            <BikeCard key={bike.bikeId} bike={bike} />
          ))}
        </div>
      )}

      {/* Operations */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mt-10">
        {/* Add quantity */}
        <div className="bg-slate-900 border border-slate-800 rounded-xl p-5">
          <p className="text-sm font-semibold text-white mb-4">Add quantity</p>
          <div className="flex gap-3 mb-3">
            <div className="flex flex-col gap-1 flex-1">
              <label className="text-xs text-slate-500">Bike ID</label>
              <input
                type="number"
                value={qBikeId}
                onChange={(e) => {
                  setQBikeId(e.target.value);
                  setQError(null);
                  setQSuccess(false);
                }}
                placeholder="1"
                className="bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-indigo-500"
              />
            </div>
            <div className="flex flex-col gap-1 flex-1">
              <label className="text-xs text-slate-500">Quantity to add</label>
              <input
                type="number"
                value={qQty}
                onChange={(e) => {
                  setQQty(e.target.value);
                  setQError(null);
                  setQSuccess(false);
                }}
                placeholder="5"
                className="bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-indigo-500"
              />
            </div>
          </div>
          {qError && <p className="text-red-400 text-xs mb-2">{qError}</p>}
          {qSuccess && <p className="text-green-400 text-xs mb-2">Updated!</p>}
          <button
            onClick={handleAddQuantity}
            disabled={qLoading}
            className="w-full py-2 rounded-lg bg-indigo-600 hover:bg-indigo-500 disabled:opacity-50 text-white text-sm font-medium transition"
          >
            {qLoading ? "Saving..." : "Add quantity"}
          </button>
        </div>

        {/* Change price */}
        <div className="bg-slate-900 border border-slate-800 rounded-xl p-5">
          <p className="text-sm font-semibold text-white mb-4">
            Change hourly price
          </p>
          <div className="flex gap-3 mb-3">
            <div className="flex flex-col gap-1 flex-1">
              <label className="text-xs text-slate-500">Bike ID</label>
              <input
                type="number"
                value={pBikeId}
                onChange={(e) => {
                  setPBikeId(e.target.value);
                  setPError(null);
                  setPSuccess(false);
                }}
                placeholder="1"
                className="bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-indigo-500"
              />
            </div>
            <div className="flex flex-col gap-1 flex-1">
              <label className="text-xs text-slate-500">New price (zł/h)</label>
              <input
                type="number"
                value={pPrice}
                onChange={(e) => {
                  setPPrice(e.target.value);
                  setPError(null);
                  setPSuccess(false);
                }}
                placeholder="20"
                className="bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-sm text-white focus:outline-none focus:border-indigo-500"
              />
            </div>
          </div>
          {pError && <p className="text-red-400 text-xs mb-2">{pError}</p>}
          {pSuccess && (
            <p className="text-green-400 text-xs mb-2">Price changed!</p>
          )}
          <button
            onClick={handleChangePrice}
            disabled={pLoading}
            className="w-full py-2 rounded-lg bg-indigo-600 hover:bg-indigo-500 disabled:opacity-50 text-white text-sm font-medium transition"
          >
            {pLoading ? "Saving..." : "Change price"}
          </button>
        </div>
      </div>

      {/* Modals */}
      {modal === "bike" && (
        <AddBikeModal onClose={() => setModal(null)} onSuccess={refetch} />
      )}
      {modal === "brand" && (
        <AddSimpleModal
          title="Add brand"
          label="Brand name"
          endpoint="brands"
          field="brandName"
          onClose={() => setModal(null)}
          onSuccess={refetch}
        />
      )}
      {modal === "category" && (
        <AddSimpleModal
          title="Add category"
          label="Category name"
          endpoint="categories"
          field="name"
          onClose={() => setModal(null)}
          onSuccess={refetch}
        />
      )}
    </div>
  );
}

function BikeCard({ bike }: { bike: Bike }) {
  return (
    <div className="bg-slate-900 border border-slate-800 rounded-xl overflow-hidden hover:border-slate-600 transition flex flex-col">
      <div className="p-5 flex flex-col gap-3 flex-1">
        <div>
          <p className="text-xs text-slate-500 uppercase tracking-wider mb-1">
            {bike.category}
          </p>
          <h2 className="text-lg font-semibold text-white">{bike.brand}</h2>
          <p className="text-xs text-slate-500">ID #{bike.bikeId}</p>
        </div>
        <div className="mt-auto flex justify-between items-end pt-3 border-t border-slate-800">
          <div>
            <p className="text-xs text-slate-500">In stock</p>
            <p
              className={`text-xl font-bold ${bike.quantity === 0 ? "text-red-400" : "text-white"}`}
            >
              {bike.quantity}
            </p>
          </div>
          <div className="text-right">
            <p className="text-xs text-slate-500">Per hour</p>
            <p className="text-xl font-bold text-indigo-400">
              {bike.hourlyPrice} zł
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}

function AddBikeModal({
  onClose,
  onSuccess,
}: {
  onClose: () => void;
  onSuccess: () => void;
}) {
  const [brandName, setBrandName] = useState("");
  const [categoryName, setCategoryName] = useState("");
  const [hourlyPrice, setHourlyPrice] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function handleSubmit() {
    if (!brandName || !categoryName || !hourlyPrice) {
      setError("Missing Input Data..");
      return;
    }
    setLoading(true);
    try {
      await callProcedure("bikes", {
        brandName: String(brandName),
        categoryName: String(categoryName),
        hourlyPrice: Number(hourlyPrice),
      });
      onSuccess();
      onClose();
    } catch (e: any) {
      setError(e.message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <Modal title="Add bike" onClose={onClose}>
      <label className="block text-sm text-slate-400 mb-1">Brand</label>
      <input
        type="text"
        value={brandName}
        onChange={(e) => setBrandName(e.target.value)}
        className="w-full bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-white mb-4 focus:outline-none focus:border-indigo-500"
        placeholder="e.g. Romet"
      />
      <label className="block text-sm text-slate-400 mb-1">Category</label>
      <input
        type="text"
        value={categoryName}
        onChange={(e) => setCategoryName(e.target.value)}
        className="w-full bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-white mb-4 focus:outline-none focus:border-indigo-500"
        placeholder="e.g. Touring"
      />
      <label className="block text-sm text-slate-400 mb-1">
        Hourly price (zł)
      </label>
      <input
        type="number"
        value={hourlyPrice}
        onChange={(e) => setHourlyPrice(e.target.value)}
        className="w-full bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-white mb-4 focus:outline-none focus:border-indigo-500"
        placeholder="e.g. 15"
      />
      {error && <p className="text-red-400 text-sm mb-3">{error}</p>}
      <ModalFooter
        onClose={onClose}
        onSubmit={handleSubmit}
        loading={loading}
      />
    </Modal>
  );
}

function AddSimpleModal({
  title,
  label,
  endpoint,
  field,
  onClose,
  onSuccess,
}: {
  title: string;
  label: string;
  endpoint: string;
  field: string;
  onClose: () => void;
  onSuccess: () => void;
}) {
  const [value, setValue] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function handleSubmit() {
    if (!value.trim()) {
      setError("Missing Input Data.");
      return;
    }
    setLoading(true);
    try {
      await callProcedure(endpoint, { [field]: value });
      onSuccess();
      onClose();
    } catch (e: any) {
      setError(e.message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <Modal title={title} onClose={onClose}>
      <label className="block text-sm text-slate-400 mb-1">{label}</label>
      <input
        type="text"
        value={value}
        onChange={(e) => setValue(e.target.value)}
        onKeyDown={(e) => e.key === "Enter" && handleSubmit()}
        className="w-full bg-slate-800 border border-slate-700 rounded-lg px-3 py-2 text-white mb-4 focus:outline-none focus:border-indigo-500"
      />
      {error && <p className="text-red-400 text-sm mb-3">{error}</p>}
      <ModalFooter
        onClose={onClose}
        onSubmit={handleSubmit}
        loading={loading}
      />
    </Modal>
  );
}

function Modal({
  title,
  onClose,
  children,
}: {
  title: string;
  onClose: () => void;
  children: React.ReactNode;
}) {
  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center bg-black/60"
      onClick={onClose}
    >
      <div
        className="bg-slate-900 border border-slate-700 rounded-2xl p-6 w-full max-w-sm mx-4"
        onClick={(e) => e.stopPropagation()}
      >
        <h2 className="text-lg font-semibold text-white mb-5">{title}</h2>
        {children}
      </div>
    </div>
  );
}

function ModalFooter({
  onClose,
  onSubmit,
  loading,
}: {
  onClose: () => void;
  onSubmit: () => void;
  loading: boolean;
}) {
  return (
    <div className="flex justify-end gap-2 mt-2">
      <button
        onClick={onClose}
        className="px-4 py-2 rounded-lg text-slate-400 hover:text-white hover:bg-slate-800 transition text-sm"
      >
        Cancel
      </button>
      <button
        onClick={onSubmit}
        disabled={loading}
        className="px-4 py-2 rounded-lg bg-indigo-600 hover:bg-indigo-500 disabled:opacity-50 text-white text-sm font-medium transition"
      >
        {loading ? "Saving..." : "Save"}
      </button>
    </div>
  );
}
