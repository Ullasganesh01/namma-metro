const amountMap = {
    'Kengeri_Gnana Bharathi': 10,
    'Kengeri_RR Nagar': 10,
    'Kengeri_Mysore Road': 15,
    'Kengeri_Vijaynagar': 15,
    'Kengeri_Magadi Road': 20,
    'Kengeri_Majestic': 20,
    'Kengeri_Cubbon Park': 25,
    'Kengeri_MG Road': 25,
    'Kengeri_Indiranagar': 30,
    'Kengeri_Baiyappanahalli': 30,

    'Gnana Bharathi_RR Nagar': 10,
    'Gnana Bharathi_Mysore Road': 10,
    'Gnana Bharathi_Vijaynagar': 15,
    'Gnana Bharathi_Magadi Road': 15,
    'Gnana Bharathi_Majestic': 20,
    'Gnana Bharathi_Cubbon Park': 20,
    'Gnana Bharathi_MG Road': 25,
    'Gnana Bharathi_Indiranagar': 25,
    'Gnana Bharathi_Baiyappanahalli': 30,

    'RR Nagar_Mysore Road': 10,
    'RR Nagar_Vijaynagar': 10,
    'RR Nagar_Magadi Road': 15,
    'RR Nagar_Majestic': 15,
    'RR Nagar_Cubbon Park': 20,
    'RR Nagar_MG Road': 20,
    'RR Nagar_Indiranagar': 25,
    'RR Nagar_Baiyappanahalli': 25,

    'Mysore Road_Vijaynagar': 10,
    'Mysore Road_Magadi Road': 10,
    'Mysore Road_Majestic': 15,
    'Mysore Road_Cubbon Park': 15,
    'Mysore Road_MG Road': 20,
    'Mysore Road_Indiranagar': 20,
    'Mysore Road_Baiyappanahalli': 25,

    'Vijaynagar_Magadi Road': 10,
    'Vijaynagar_Majestic': 10,
    'Vijaynagar_Cubbon Park': 15,
    'Vijaynagar_MG Road': 15,
    'Vijaynagar_Indiranagar': 20,
    'Vijaynagar_Baiyappanahalli': 20,

    'Magadi Road_Majestic': 10,
    'Magadi Road_Cubbon Park': 10,
    'Magadi Road_MG Road': 15,
    'Magadi Road_Indiranagar': 15,
    'Magadi Road_Baiyappanahalli': 20,

    'Majestic_Cubbon Park': 10,
    'Majestic_MG Road': 10,
    'Majestic_Indiranagar': 15,
    'Majestic_Baiyappanahalli': 15,

    'Cubbon Park_MG Road': 10,
    'Cubbon Park_Indiranagar': 10,
    'Cubbon Park_Baiyappanahalli': 15,

    'MG Road_Indiranagar': 10,
    'MG Road_Baiyappanahalli': 10,

    'Indiranagar_Baiyappanahalli': 10

};

function updateAmount() {
    const from = document.getElementById('source').value;
    const to = document.getElementById('destination').value;
    const noOfTickets = document.getElementById('noOfTickets').value;

    // Create a key for the amountMap
    const key = `${from}_${to}`;
    const amountInput = document.getElementById('amount');

    let fromEle = document.getElementById('source');
    let toEle = document.getElementById('destination');
    let fromErr = document.getElementById('from-error');
    let toErr = document.getElementById('to-error');

    if (amountMap.hasOwnProperty(key) && !isNaN(noOfTickets) && noOfTickets >= 1) {
        const amount = amountMap[key] * noOfTickets;
        amountInput.value = amount;

        fromErr.style.display = "none";
        toErr.style.display = "none";

        fromEle.style.border = "2px solid green";
        toEle.style.border = "2px solid green";
        return true;
    } else if (noOfTickets < 1) {
        validateNoOfTickets();
    } else {
        amountInput.value = ''; // Set to empty if combination not found or invalid noOfTickets

        fromErr.innerHTML = "Please select valid source and destination";
        toErr.innerHTML = "Please select valid source and destination";
        fromErr.style.display = "inline";
        toErr.style.display = "inline";

        fromEle.style.border = "2px solid red";
        toEle.style.border = "2px solid red";
        return false;
    }
}

function validateNoOfTickets() {
    const noOfTicketsInput = document.getElementById('noOfTickets');
    const noOfTicketsError = document.getElementById('noOfTickets-error');

    if (noOfTicketsInput.value.trim() === '' || isNaN(noOfTicketsInput.value) || noOfTicketsInput.value < 1) {
        noOfTicketsError.textContent = 'Enter a valid number of tickets (min 1)';
        return false;
    } else {
        noOfTicketsError.textContent = '';
        return true;
    }
}

function validateForm() {
    return validateNoOfTickets() && updateAmount();
}