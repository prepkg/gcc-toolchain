const tabs = document.querySelectorAll(".tab");
const panels = document.querySelectorAll(".panel");

tabs.forEach(tab => {
    tab.addEventListener("click", () => {
        tabs.forEach(t => {
            t.classList.remove("active");
            t.setAttribute("aria-selected", "false");
        });
        tab.classList.add("active");
        tab.setAttribute("aria-selected", "true");

        panels.forEach(panel => panel.classList.remove("active"));
        document.querySelector(`.panel[data-panel="${tab.dataset.os}"]`).classList.add("active");
    });
});

const linuxButtons = document.querySelectorAll("#linux-targets .arch-btn");
const linuxCmd = document.getElementById("linux-cmd");

linuxButtons.forEach(btn => {
    btn.addEventListener("click", () => {
        linuxButtons.forEach(b => b.classList.remove("active"));
        btn.classList.add("active");
        linuxCmd.textContent = `curl -sSL https://github.com/prepkg/gcc-toolchain/releases/latest/download/gcc-${btn.dataset.value}.tar.gz \\\n  | sudo tar xz -C /opt`;
    });
});

document.querySelectorAll(".copy-btn").forEach(btn => {
    btn.addEventListener("click", async () => {
        const code = document.getElementById(btn.dataset.target);
        try {
            await navigator.clipboard.writeText(code.textContent);
            const original = btn.textContent;
            btn.textContent = "Copied!";
            setTimeout(() => {
                btn.textContent = original;
            }, 1500);
        } catch (err) {
            // Clipboard API unavailable; nothing to fall back to.
        }
    });
});
