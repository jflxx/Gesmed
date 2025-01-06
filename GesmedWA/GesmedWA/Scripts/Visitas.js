function showModal(modalId) {
    var modalForm = new bootstrap.Modal(document.getElementById(modalId));
    modalForm.toggle();
}

function closeModal(modalId) {
    var modalForm = new bootstrap.Modal(document.getElementById(modalId));
    
    modalForm.closeModal();
}
function closeModal2(modalID) {
    var modalForm = bootstrap.Modal.getInstance(document.getElementById(modalId));
    if (modalForm) {
        modalForm.hide();
    }
}