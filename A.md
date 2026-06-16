A great teaching project is a Student Directory App that demonstrates:

✅ React Router

✅ useMemo

✅ useCallback

✅ API Fetching

✅ Component Re-render Optimization


Project Structure

src/
├── App.jsx
├── main.jsx
├── pages/
│   ├── Home.jsx
│   └── Students.jsx
├── components/
│   ├── SearchBar.jsx
│   └── StudentCard.jsx
└── api/
    └── studentApi.js


---

1. Install Router

npm create vite@latest student-app -- --template react
cd student-app

npm install react-router-dom
npm install
npm run dev


---

2. studentApi.js

Using a free API:

// src/api/studentApi.js

export const getStudents = async () => {
  const response = await fetch(
    "https://jsonplaceholder.typicode.com/users"
  );

  return response.json();
};


---

3. StudentCard.jsx

import React from "react";

const StudentCard = React.memo(({ student }) => {
  console.log("Rendering:", student.name);

  return (
    <div
      style={{
        border: "1px solid gray",
        padding: "10px",
        margin: "10px"
      }}
    >
      <h3>{student.name}</h3>
      <p>{student.email}</p>
      <p>{student.company.name}</p>
    </div>
  );
});

export default StudentCard;

Teaching Point

React.memo() prevents unnecessary re-renders.


---

4. SearchBar.jsx

import React from "react";

const SearchBar = ({ search, onSearch }) => {
  console.log("SearchBar Rendered");

  return (
    <input
      type="text"
      placeholder="Search student..."
      value={search}
      onChange={(e) => onSearch(e.target.value)}
      style={{
        padding: "10px",
        width: "300px"
      }}
    />
  );
};

export default React.memo(SearchBar);


---

5. Home.jsx

export default function Home() {
  return (
    <div>
      <h1>React Optimization Demo</h1>
      <p>Learn Router, API, useMemo and useCallback</p>
    </div>
  );
}


---

6. Students.jsx

import { useEffect, useState, useMemo, useCallback } from "react";
import { getStudents } from "../api/studentApi";
import StudentCard from "../components/StudentCard";
import SearchBar from "../components/SearchBar";

export default function Students() {
  const [students, setStudents] = useState([]);
  const [search, setSearch] = useState("");
  const [counter, setCounter] = useState(0);

  useEffect(() => {
    loadStudents();
  }, []);

  const loadStudents = async () => {
    const data = await getStudents();
    setStudents(data);
  };

  // useCallback
  const handleSearch = useCallback((value) => {
    setSearch(value);
  }, []);

  // useMemo
  const filteredStudents = useMemo(() => {
    console.log("Filtering...");

    return students.filter((student) =>
      student.name
        .toLowerCase()
        .includes(search.toLowerCase())
    );
  }, [students, search]);

  return (
    <div>
      <h2>Students Page</h2>

      <button
        onClick={() => setCounter(counter + 1)}
      >
        Counter: {counter}
      </button>

      <br /><br />

      <SearchBar
        search={search}
        onSearch={handleSearch}
      />

      {filteredStudents.map((student) => (
        <StudentCard
          key={student.id}
          student={student}
        />
      ))}
    </div>
  );
}


---

7. App.jsx (Router)

import { BrowserRouter, Routes, Route, Link } from "react-router-dom";
import Home from "./pages/Home";
import Students from "./pages/Students";

function App() {
  return (
    <BrowserRouter>
      <nav>
        <Link to="/">Home</Link>
        {" | "}
        <Link to="/students">Students</Link>
      </nav>

      <hr />

      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/students" element={<Students />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;


---

Concepts to Demonstrate in Class

Router

<Link to="/students">

Navigates without page reload.


---

API Call

useEffect(() => {
  loadStudents();
}, []);

Fetches data when component mounts.


---

useMemo

const filteredStudents = useMemo(() => {
  return students.filter(...);
}, [students, search]);

Avoids recalculating filtering on every render.


---

useCallback

const handleSearch = useCallback((value) => {
  setSearch(value);
}, []);

Prevents function recreation on every render.


---

React.memo

export default React.memo(SearchBar);

Prevents child component re-render when props haven't changed.


---

Classroom Experiment

Add this button:

<button onClick={() => setCounter(counter + 1)}>
  Counter
</button>

Ask students:

> Why does clicking Counter not run filtering again?



Answer:

Because useMemo caches the filtered result until students or search changes.

This makes a compact but realistic project that demonstrates all four concepts in under 100 lines of core React code.
