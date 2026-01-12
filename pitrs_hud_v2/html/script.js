let isInVehicle = false;

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
            const newHeight = modeHeight[data.mode] || "50%";
            progressBar.style.height = newHeight;
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
        const location = document.getElementById("location");
        const compass = document.getElementById("compass");
        const compassDirection = document.getElementById("compass-direction");
        if (data.show) {
            if (isInVehicle) {
                if (location) {
                    location.style.opacity = "1";
                    location.style.display = "flex";
                }
                if (compass) {
                    compass.style.opacity = "1";
                    compass.style.display = "flex";
                }
                if (compassDirection) {
                    compassDirection.style.opacity = "1";
                    compassDirection.style.display = "inline";
                }
            }
        } else {
            if (location) {
                location.style.opacity = "0";
                setTimeout(() => location.style.display = "none", 300);
            }
            if (compass) {
                compass.style.opacity = "0";
                setTimeout(() => compass.style.display = "none", 300);
            }
            if (compassDirection) {
                compassDirection.style.opacity = "0";
                setTimeout(() => compassDirection.style.display = "none", 300);
            }
        }
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
        isInVehicle = data.show;
        const location = document.getElementById("location");
        const compass = document.getElementById("compass");
        const compassDirection = document.getElementById("compass-direction");

        if (data.show) {
            if (location) {
                location.style.opacity = "1";
                location.style.display = "flex";
            }
            if (compass) {
                compass.style.opacity = "1";
                compass.style.display = "flex";
            }
            if (compassDirection) {
                compassDirection.style.opacity = "1";
                compassDirection.style.display = "inline";
            }
        } else {
            if (location) location.style.opacity = "0";
            if (compass) compass.style.opacity = "0";
            if (compassDirection) compassDirection.style.opacity = "0";
            setTimeout(() => {
                if (location) location.style.display = "none";
                if (compass) compass.style.display = "none";
                if (compassDirection) compassDirection.style.display = "none";
            }, 300);
        }
    }
});
