import { createRoot } from "react-dom/client";
import { Central } from "./Central";
import "./styles/styles.css";

const container = document.getElementById("root");
const root = createRoot(container);

root.render(<Central />);
