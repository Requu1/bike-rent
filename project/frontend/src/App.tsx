import { useState } from "react";
import "./App.css";

function App() {
  const [count, setCount] = useState(0);

  return (
    <>
      <section id="welcome">
        <h1>Welcome to Vite + React!</h1>
        <button
          className="m-5 p-2 bg-blue-500 text-white rounded"
          type="button"
          onClick={() => setCount((count) => count + 1)}
        >
          Count is {count}
        </button>
      </section>
    </>
  );
}

export default App;
