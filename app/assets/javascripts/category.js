$(document).on('turbolinks:load', function(){
  $(function(){
    // カテゴリーセレクトボックスのオプションを作成
    function appendOption(category){
      var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
      return html;
    }
    // 子カテゴリーの表示作成
    function appendChidrenBox(insertAdjacentHTML){
      var childSelectHtml = '';
      childSelectHtml = `<label class='sell-collection_category__label' id= 'children_wrapper'>
                          <select class="sell-collection_input", id="child_category", name="product[category_id]">
                            <option value="---" data-category="---">選択してください</option>
                            ${insertAdjacentHTML}
                          <select>
                          <i class="fas fa-chevron-down"></i>
                        </label>`;
      $('.sell-collection_category').append(childSelectHtml);
    }

    // 孫カテゴリーの表示作成
    function appendGrandchidrenBox(insertAdjacentHTML){
      var grandchildSelectHtml = '';
      grandchildSelectHtml = ` <label class='sell-collection_category__label' id= 'grandchildren_wrapper'>
                                <select class="sell-collection_input", id="grandchild_category", name="product[category_id]">
                                  <option value="---" data-category="---">選択してください</option>
                                  ${insertAdjacentHTML}
                                </select>
                                <i class="fas fa-chevron-down"></i>
                              </label>`;
      $('.sell-collection_category').append(grandchildSelectHtml);
    }

    // 親カテゴリー選択後のイベント
    $('#category_select').on('change', function(){
      var parent_category_id = document.getElementById
      ('category_select').value; //選択された親カテゴリーの名前を取得
      if (parent_category_id != ""){ //親カテゴリーが初期値でないことを確認
        $.ajax({
          url: '/products/category/get_category_children',
          type: 'GET',
          data: { parent_id: parent_category_id },
          dataType: 'json'
        })
        .done(function(children){
          $('#children_wrapper').remove(); //親が変更された時、子以下を削除する
          $('#grandchildren_wrapper').remove();
          var insertAdjacentHTML = '';
          children.forEach(function(child){
            insertAdjacentHTML += appendOption(child);
          });
          appendChidrenBox(insertAdjacentHTML);
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#children_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除する
        $('#grandchildren_wrapper').remove();
      }
    });


    $(function(){
      $(".submit-btn__sell-btn").on("click", function(){
        
        let grandChildVal = $("#grandchild_category").val();
       
        let result = $.isNumeric(grandChildVal)
        if (result) {
          
        }
        else {
          alert("カテゴリー欄をすべて選択してください")
          return false
        }
        
      })
    })



    // 子カテゴリー選択後のイベント
    $('.sell-collection_category').on('change', '#child_category', function(){
      var child_category_id = $('#child_category option:selected').data('category'); //選択された子カテゴリーのidを取得
      if (child_category_id != "" ){ //子カテゴリーが初期値でないことを確認
        $.ajax({
          url: '/products/category/get_category_grandchildren',
          type: 'GET',
          data: { child_id: child_category_id },
          dataType: 'json'
        })
        .done(function(grandchildren){
          if (grandchildren.length != 0) {
            $('#grandchildren_wrapper').remove(); //子が変更された時、孫以下を削除する
            var insertAdjacentHTML= '';
            grandchildren.forEach(function(grandchild){
              insertAdjacentHTML += appendOption(grandchild);
            });
            appendGrandchidrenBox(insertAdjacentHTML);
          }
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#grandchildren_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
      }
    });
  });
});