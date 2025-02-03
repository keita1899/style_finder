document.addEventListener("DOMContentLoaded", function () {
  const imageInput = document.getElementById("image-upload")
  const previewImage = document.getElementById("image-preview")
  const selectButton = document.getElementById("select-image-btn")

  if (!imageInput) {
    return false;
  }

  imageInput.addEventListener("change", function (event) {
    const file = event.target.files[0]
    const previewContainer = previewImage.parentElement
    
    if (file) {
      const reader = new FileReader()

      reader.onload = function (e) {
        previewImage.src = e.target.result
        previewImage.classList.remove("hidden")
        previewContainer.querySelector('span').classList.add("hidden")
      }

      reader.readAsDataURL(file)
    } else {
      previewImage.classList.add("hidden")
      previewContainer.querySelector('span').classList.remove("hidden")
    }
  })

  selectButton.addEventListener("click", function () {
    imageInput.click()
  })
})