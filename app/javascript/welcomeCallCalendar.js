function expandConfirm() {
  const availableTimeButtons = document.querySelectorAll('.time-button');
  if (availableTimeButtons) {
    availableTimeButtons.forEach((button) => {
      button.addEventListener('click', function(){
        event.currentTarget.classList.toggle('expanded');
        event.currentTarget.nextElementSibling.classList.toggle('not-expanded');
      })
    })
  }
}

export { expandConfirm }
