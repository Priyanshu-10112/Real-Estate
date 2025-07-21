// Utility functions
function showAlert(message, type = 'success') {
    // SweetAlert2 type mapping
    let icon = 'success';
    if (type === 'error') icon = 'error';
    else if (type === 'warning') icon = 'warning';
    else if (type === 'info') icon = 'info';
    
    Swal.fire({
        title: type.charAt(0).toUpperCase() + type.slice(1),
        text: message,
        icon: icon,
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        position: 'top',
        background: '#fff',
        customClass: {
            popup: 'swal2-popup-custom',
            title: 'swal2-title-custom',
            content: 'swal2-content-custom'
        }
    });
}

function validatePhoneNumber(phoneNumber) {
    const phoneRegex = /^\d{10}$/;
    return phoneRegex.test(phoneNumber);
}

function validateOTP(otp) {
    const otpRegex = /^\d{6}$/;
    return otpRegex.test(otp);
}

// Form validation
function validateForm(formId) {
    const form = document.getElementById(formId);
    if (!form) return true;

    const requiredFields = form.querySelectorAll('[required]');
    let isValid = true;

    requiredFields.forEach(field => {
        if (!field.value.trim()) {
            isValid = false;
            field.classList.add('is-invalid');
        } else {
            field.classList.remove('is-invalid');
        }
    });

    return isValid;
}

// API calls
async function makeApiCall(url, method = 'GET', data = null) {
    try {
        const options = {
            method,
            headers: {
                'Content-Type': 'application/json'
            }
        };

        if (data) {
            options.body = JSON.stringify(data);
        }

        const response = await fetch(url, options);
        const responseData = await response.json();

        if (!response.ok) {
            throw new Error(responseData.message || 'Something went wrong');
        }

        return responseData;
    } catch (error) {
        console.error('API call failed:', error);
        throw error;
    }
} 

async function showConfirmAlert(message) {
    const result = await Swal.fire({
        title: 'Are you sure?',
        text: message,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes',
        cancelButtonText: 'No',
        reverseButtons: true,
        customClass: {
            popup: 'swal2-popup-custom',
            title: 'swal2-title-custom',
            content: 'swal2-content-custom'
        }
    });
    return result.isConfirmed;
} 
window.showAlert = showAlert;
window.showConfirmAlert = showConfirmAlert; 