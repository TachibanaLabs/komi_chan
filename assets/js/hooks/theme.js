const setTheme = (theme) => {
  if (theme === "system") {
    localStorage.removeItem("phx:theme");
    document.documentElement.removeAttribute("data-theme");
  } else {
    localStorage.setItem("phx:theme", theme);
    document.documentElement.setAttribute("data-theme", theme);
  }
};

const Theme = {
  mounted() {
    window.addEventListener("phx:set-theme", (e) => setTheme(e.target.dataset.phxTheme));

    window.addEventListener("storage", (e) => {
      if (e.key === "phx:theme") setTheme(e.newValue || "system");
    });
  },
};

export default Theme;
