function showModalFormError(modalId) {
    modalFormError = new bootstrap.Modal(document.getElementById(modalId));
    modalFormError.show();
}
function hideModalFormError(modalId) {
    modalFormError.hide();
}