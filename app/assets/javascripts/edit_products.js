window.addEventListener('DOMContentLoaded', function(){

  var dataBox = new DataTransfer();

  const inputElement = document.getElementsByClassName('image-preview')
  const previewElement = document.getElementsByClassName('img-preview')

  for( var i=0; i<inputElement.length; i++) {
      inputElement[i].addEventListener("change", event => {
        event.preventDefault();
        event.stopPropagation();

        const file = event.target.files[0];
        const reader = new FileReader();
        const data_index = Number(event.target.getAttribute("data-index"))

        reader.addEventListener('load', event => {
          previewElement[data_index].setAttribute('src', event.target.result);
        })

        reader.readAsDataURL(file);
      });
    };

  $('#new-file').change(function(){

    var file = $('input[type="file"]').prop('files')[0];
    $.each(this.files, function(i, file){

      file_field = this;

      var fileReader = new FileReader();

      dataBox.items.add(file)
    
    file_field.files = dataBox.files
    
    var num = $('.item-image').length + 1 + 0
    fileReader.readAsDataURL(file);
    fileReader.onloadend = function() {
      var src = fileReader.result
      var html=  `<div class='item-image' data-image="${file.name}">
                    <div class=' item-image__content'>
                      <div class='item-image__content--icon'>
                        <img src=${src} width="114" height="80" >
                      </div>
                    </div>
                  </div>`
      $('#previews').after(html);
    };
    });
  });
  
});