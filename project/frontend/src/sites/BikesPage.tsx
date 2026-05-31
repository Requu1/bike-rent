import { Link } from "react-router-dom";
import { type Bike } from "../types";

interface BikeProps {
  bikes: Bike[];
}

export default function Bikes({ bikes }: BikeProps) {
  return (
    <div>
      <h1 className="text-3xl font-extrabold tracking-tight mb-8">Bikes</h1>

      {bikes.length === 0 ? (
        <div className="text-center py-12 bg-slate-900 rounded-xl border border-slate-800">
          <p className="text-slate-400">
            Loading products or none in database...
          </p>
        </div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
          {bikes.map((bike) => (
            <div
              key={bike.id}
              className="bg-slate-900 border border-slate-800 rounded-xl overflow-hidden shadow-md hover:border-slate-700 transition flex flex-col"
            >
              jakies info o tym bike
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
