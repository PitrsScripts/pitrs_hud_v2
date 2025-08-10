window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.action === "update") {
        // Health
        const healthBar = document.querySelector('#health .progress-bar');
        if (healthBar && typeof data.health === 'number') {
            healthBar.style.width = `${data.health}%`;
        }

        // Armor
        const armorBar = document.querySelector('#armor .progress-bar');        
        if (armorBar && typeof data.armor === 'number') {
            armorBar.style.width = `${data.armor}%`;
        }

        // Hunger
        const hungerBar = document.querySelector('#hunger .progress-bar');
        if (hungerBar && typeof data.hunger === 'number') {
            hungerBar.style.height = `${data.hunger}%`;
        }

        // Thirst
        const thirstBar = document.querySelector('#thirst .progress-bar');
        if (thirstBar && typeof data.thirst === 'number') {
            thirstBar.style.height = `${data.thirst}%`;
        }

        // Stamina
        const staminaBar = document.querySelector('#stamina .progress-bar');
        if (staminaBar && typeof data.stamina === 'number') {
            staminaBar.style.height = `${data.stamina}%`;
        }

        // Oxygen
        const oxygenBar = document.querySelector('#oxygen .progress-bar');
        if (oxygenBar && typeof data.oxygen === 'number') {
            oxygenBar.style.height = `${data.oxygen}%`;
        }
    }

    if (data.action === "voice") {
        const micIcon = document.getElementById("voice").querySelector("i");
        const container = document.getElementById("voice");
        const progressBar = container.querySelector(".progress-bar");

        if (data.talking) {
            micIcon.style.color = "#f1c40f"; 
        } else {
            micIcon.style.color = "white";
        }

        let modeText = {
            whisper: "Šeptání",
            normal: "Normální",
            shouting: "Křik"
        };
        container.setAttribute("title", modeText[data.mode] || data.mode);

        let modeHeight = {
            whisper: "25%",
            normal: "50%",
            shouting: "100%"
        };

        if (progressBar && data.mode) {
            progressBar.style.transition = "height 0.2s ease";
            progressBar.style.height = modeHeight[data.mode] || "50%";
        }
    }

    if (data.action === "setPlayerId") {
        const idElement = document.getElementById("player-index");
        if (idElement && typeof data.id === "number") {
            idElement.textContent = data.id;
        }
    }

    if (data.action === "toggle") {
        document.getElementById("hud").style.display = data.show ? "flex" : "none";
    }

    if (data.action === "updateCompassDirection") {
        const compassDirectionElement = document.getElementById("compass-direction");
        if (compassDirectionElement && typeof data.direction === "string") {
            compassDirectionElement.textContent = data.direction;
        }
    }

    if (data.action === "updateLocation") {
        const streetEl = document.getElementById("street-name");
        const areaEl = document.getElementById("area-name");
        if (streetEl && typeof data.street === "string") {
            streetEl.textContent = data.street;
        }
        if (areaEl && typeof data.area === "string") {
            areaEl.textContent = data.area;
        }
    }

    if (data.action === "toggleVehicleHud") {
        const location = document.getElementById("location");
        const compass = document.getElementById("compass");
        const compassDirection = document.getElementById("compass-direction");

        if (location) location.style.display = data.show ? "flex" : "none";
        if (compass) compass.style.display = data.show ? "flex" : "none";
        if (compassDirection) compassDirection.style.display = data.show ? "inline" : "none";
    }
});
