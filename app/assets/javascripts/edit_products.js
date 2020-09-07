window.addEventListener('DOMContentLoaded', function(){

  var dataBox = new DataTransfer();

  const inputElement = document.getElementsByClassName('image-preview')
  const previewElement = document.getElementsByClassName('qqq')

  for( var i=0; i<inputElement.length; i++) {
      inputElement[i].addEventListener("change", event => {
        event.preventDefault();     // デフォルトイベントのキャンセル
        event.stopPropagation();    // イベントのバブリングを防ぐ

        // type="file"を指定されたinput要素のchangeイベントは「ファイルのリスト」を返す
        const file = event.target.files[0];

        // FileReaderのインスタンスを生成（ローカルファイルを読み込むオブジェクト）
        const reader = new FileReader();
        const data_index = Number(event.target.getAttribute("data-index"))
        // FileReaderの読み込みが完了した結果（アップロードした画像ファイルのデータ）を、img要素のsrcにセット
        reader.addEventListener('load', event => {
          // event.target.resultは、base64エンコードされた画像データ
          previewElement[data_index].setAttribute('src', event.target.result);
        })

        // セットされたオブジェクトを読み込む
        reader.readAsDataURL(file);
      });
    };

  $('#new-file').change(function(){
    //選択したfileのオブジェクトをpropで取得
    var file = $('input[type="file"]').prop('files')[0];
    $.each(this.files, function(i, file){
    //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
    file_field = this;
    // file = this.files[0]
    // console.log(file)
    var fileReader = new FileReader();
    //読み込みが完了すると、srcにfileのURLを格納
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
      //image_box__container要素の前にhtmlを差し込む
      $('#previews').after(html);
    };
    });
  });
  
});