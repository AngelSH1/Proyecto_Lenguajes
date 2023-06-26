document.addEventListener("DOMContentLoaded", function() {
    const apiKey = "TxQt69bVqHL2PdOSw27msNeKwkEI1l_X"; // Reemplaza con tu propia clave de API de Tequila by Kiwi.com
  
    const form = document.getElementById("flightForm");
    const resultsContainer = document.getElementById("results");
  
    form.addEventListener("submit", function(event) {
      event.preventDefault();
  
      const origin = document.getElementById("origin").value;
      const destination = document.getElementById("destination").value;
      const departureDate = document.getElementById("departureDate").value;
  
      // Realizar una solicitud GET a la API de Tequila by Kiwi.com
      fetch(`https://tequila-api.kiwi.com/v2/search?fly_from=${origin}&fly_to=${destination}&date_from=${departureDate}&date_to=${departureDate}&partner_market=US&limit=5&sort=price`, {
        headers: {
          "apikey": apiKey
        }
      })
        .then(response => response.json())
        .then(data => {
          // Limpiar los resultados anteriores
          resultsContainer.innerHTML = "";
  
          // Mostrar los resultados en el elemento con el id "results"
          for (const result of data.data) {
            const ticket = document.createElement("div");
            ticket.classList.add("ticket");
  
            const price = result.price;
            const airline = result.airlines[0];
            const flightNumber = result.flight_no;
            const departureTime = result.dTime;
            const arrivalTime = result.aTime;
  
            const ticketInfo = document.createElement("p");
            ticketInfo.innerHTML = `<strong>Price:</strong> $${price}<br>
                                    <strong>Airline:</strong> ${airline}<br>
                                    <strong>Flight Number:</strong> ${flightNumber}<br>
                                    <strong>Departure Time:</strong> ${formatTime(departureTime)}<br>
                                    <strong>Arrival Time:</strong> ${formatTime(arrivalTime)}`;
  
            ticket.appendChild(ticketInfo);
            resultsContainer.appendChild(ticket);
          }
        })
        .catch(error => {
          console.error("Error al realizar la solicitud a la API de Tequila by Kiwi.com:", error);
        });
    });
  
    // Función para formatear la hora en formato HH:MM
    function formatTime(timestamp) {
      const date = new Date(timestamp * 1000);
      const hours = date.getHours().toString().padStart(2, "0");
      const minutes = date.getMinutes().toString().padStart(2, "0");
      return `${hours}:${minutes}`;
    }
  });