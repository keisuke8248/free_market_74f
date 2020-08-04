window.addEventListener('DOMContentLoaded', function(){
  
  var dataBox = new DataTransfer();

  var file_field = document.querySelector('input[type=file]')
  //fileが選択された時に発火するイベント
  $('#img-file').change(function(){
    //選択したfileのオブジェクトをpropで取得
    var file = $('input[type="file"]').prop('files')[0];
    $.each(this.files, function(i, file){
    //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
    var fileReader = new FileReader();
    //読み込みが完了すると、srcにfileのURLを格納
    dataBox.items.add(file)
    
    file_field.files = dataBox.files
    
    var num = $('.item-image').length + 1 + i
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
      //image_box__container要素の前にhtmlを差し込む
      $('#image-box__container').before(html);
    };
    });
  });
});