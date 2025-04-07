// Add this to your script.js or create a new dashboard.js file
document.addEventListener("DOMContentLoaded", function() {
    // Check if we're on the dashboard page
    if (document.getElementById("business-name")) {
        // Fetch dashboard data
        fetch("/dashboard-data")
            .then(response => {
                if (!response.ok) {
                    throw new Error("Not authorized or server error");
                }
                return response.json();
            })
            .then(data => {
                // Update the dashboard with business information
                document.getElementById("business-name").textContent = data.business_name;
                document.getElementById("business-id").textContent = data.business_id;
                document.getElementById("business-category").textContent = data.category;
                document.getElementById("business-location").textContent = data.location;
                document.getElementById("business-address").textContent = data.address;
                
                // Display offers
                const offersList = document.getElementById("offers-list");
                offersList.innerHTML = ""; // Clear existing content
                
                if (data.offers && data.offers.length > 0) {
                    data.offers.forEach(offer => {
                        const li = document.createElement("li");
                        li.textContent = `${offer.offer_text} (${offer.created_at})`;
                        
                        // Add delete button
                        const deleteBtn = document.createElement("button");
                        deleteBtn.textContent = "Delete";
                        deleteBtn.onclick = function() {
                            deleteOffer(offer.id);
                        };
                        
                        li.appendChild(deleteBtn);
                        offersList.appendChild(li);
                    });
                } else {
                    offersList.innerHTML = "<li>No offers yet</li>";
                }
            })
            .catch(error => {
                console.error("Error fetching dashboard data:", error);
                // Redirect to login if not authorized
                window.location.href = "/";
            });
    }
});

// Function to delete an offer
function deleteOffer(offerId) {
    fetch(`/delete_offer/${offerId}`, {
        method: "POST"
    })
    .then(response => response.json())
    .then(data => {
        alert(data.message);
        // Reload dashboard data to update the list
        window.location.reload();
    })
    .catch(error => console.error("Error:", error));
}

document.addEventListener("DOMContentLoaded", function () {
    console.log("DOM Content Loaded");  // Debug log
    const loginForm = document.getElementById("loginForm");
    console.log("Login form found:", loginForm);  // Debug log

    if (loginForm) {
        loginForm.addEventListener("submit", function (event) {
            console.log("Form submitted");  // Debug log
            event.preventDefault();

            const businessID = document.getElementById("business_id").value;
            const password = document.getElementById("password").value;
            console.log("Form values:", { businessID, password });  // Debug log

            // Add validation
            if (!businessID || !password) {
                alert("Please enter both Business ID and Password");
                return;
            }

            // Clear any previous error messages
            const errorElement = document.getElementById("login-error");
            if (errorElement) errorElement.textContent = "";

            // Show loading indicator
            const submitButton = loginForm.querySelector("button[type=submit]");
            const originalButtonText = submitButton.textContent;
            submitButton.textContent = "Logging in...";
            submitButton.disabled = true;

            console.log("Sending login request...");  // Debug log
            fetch("/login", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ business_id: businessID, password: password })
            })
            .then(response => {
                console.log("Response status:", response.status);  // Debug log
                return response.json();
            })
            .then(data => {
                console.log("Response data:", data);  // Debug log
                if (data.message === "Login successful") {
                    console.log("Login successful, redirecting to:", data.redirect);
                    window.location.href = data.redirect;
                } else {
                    throw new Error(data.message || "Login failed. Please try again.");
                }
            })
            .catch(error => {
                console.error("Error:", error);
                
                // Display error message
                const errorElement = document.getElementById("login-error");
                errorElement.textContent = error.message || "Login failed. Please check your credentials.";
                
                // Reset button
                submitButton.textContent = originalButtonText;
                submitButton.disabled = false;
            });
        });
    } else {
        console.error("Login form not found!");  // Debug log
    }
});