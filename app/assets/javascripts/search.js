$(document).on('turbolinks:load', function(){
  $(function(){
    function appendOption(category){
      var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
      return html;
    }
    function appendCheckbox(category){
      let html =`
                <div class="category-checkboxes">
                  <input type="checkbox" value="${category.id}" name="q[category_id_in][]" >
                    <div class="checkbox__label">
                      <label for="q_category_id_in_${category.id}">${category.name}</label>
                    </div>
                  </div>
                  `
      return html;
    }

    function appendChidrenBox(insertHTML){
      var childSelectHtml = '';
      childSelectHtml = `<div class='category-area__choose-space--added' id= 'children_wrapper'>
                          <div class='category-area__choose-space--children'>
                            <select class="category-area__choose-space--selectbox" id="child_category" name="q[category_id_in][]">
                              <option value="---" data-category="---">すべて</option>
                              ${insertHTML}
                            <select>
                          </div>
                        </div>`;
      $('.category-area__choose-space').append(childSelectHtml);
    }


    function appendGrandchidrenBox(insertHTML){
      var grandchildSelectHtml = '';
      grandchildSelectHtml = `<div class='category-area__choose-space--added' id= 'grandchildren_wrapper'>
                                <div class='category-area__choose-space--grandchildren'>
                                    ${insertHTML}
                                </div>
                              </div>`;
      $('.category-area__choose-space').append(grandchildSelectHtml);
    }

    $('#parent_category').on('change', function(){
      var parent_category_id = document.getElementById
      ('parent_category').value;
      if (parent_category_id != "---"){
        $.ajax({
          url: '/products/category/get_category_children',
          type: 'GET',
          data: { parent_id: parent_category_id },
          dataType: 'json'
        })
        .done(function(children){
          $('#children_wrapper').remove();
          $('#grandchildren_wrapper').remove();
          var insertHTML = '';
          children.forEach(function(child){
            insertHTML += appendOption(child);
          });
          appendChidrenBox(insertHTML);
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
      }
    });

    // 子カテゴリー選択後のイベント
    $('.category-area').on('change', '#child_category', function(){
      var child_category_id = $('#child_category option:selected').data('category'); //選択された子カテゴリーのidを取得
      if (child_category_id != "---"){ //子カテゴリーが初期値でないことを確認
        $.ajax({
          url: '/products/category/get_category_grandchildren',
          type: 'GET',
          data: { child_id: child_category_id },
          dataType: 'json'
        })
        .done(function(grandchildren){
          if (grandchildren.length != 0) {
            $('#grandchildren_wrapper').remove(); //子が変更された時、孫以下を削除する
            var insertHTML = '';
            grandchildren.forEach(function(grandchild){
              insertHTML += appendCheckbox(grandchild);
            });
            appendGrandchidrenBox(insertHTML);
          }
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#grandchildren_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
      }
    });

    $('[name=price_range]').change(function() {
      var minrate = $('[name=price_range]').val();
      $('#q_price_gteq').val(minrate);
      if (minrate == 300) {
        var maxrate = 1000
        $('#q_price_lteq').val(maxrate);
      }else if (minrate == 1000){
        var maxrate = 5000
        $('#q_price_lteq').val(maxrate);
      }else if (minrate == 5000){
        var maxrate = 10000
        $('#q_price_lteq').val(maxrate);
      }else if (minrate == 10000){
        var maxrate = 30000
        $('#q_price_lteq').val(maxrate);
      }else if (minrate == 30000){
        var maxrate = 50000
        $('#q_price_lteq').val(maxrate);
      }else if (minrate == 50000){
        var maxrate = "";
        $('#q_price_lteq').val(maxrate);
      }
    });

    $('#check-status').on('change', function() {
      $('.status_checkbox').prop('checked', $(this).is(':checked'));
    });
    $('.status_checkbox').on('click', function() {
      var boxCount = $('.status_checkbox').length;
      var checked = $('.status_checkbox' + ':checked').length;
      if(checked === boxCount){
        $('#check-status').prop('checked', true);
      }else{
        $('#check-status').prop('checked', false);
      }
    });

    $('#check-cost').on('change', function() {
      $('.cost_checkbox').prop('checked', $(this).is(':checked'));
    });
    $('.cost_checkbox').on('click', function() {
      var boxCount = $('.cost_checkbox').length;
      var checked = $('.cost_checkbox' + ':checked').length;
      if(checked === boxCount){
        $('#check-cost').prop('checked', true);
      }else{
        $('#check-cost').prop('checked', false);
      }
    });

    $('#check-buyer').on('change', function() {
      $('.buyer_checkbox').prop('checked', $(this).is(':checked'));
    });
    $('.buyer_checkbox').on('click', function() {
      var boxCount = $('.buyer_checkbox').length;
      var checked = $('.buyer_checkbox' + ':checked').length;
      if(checked === boxCount){
        $('#check-buyer').prop('checked', true);
      }else{
        $('#check-buyer').prop('checked', false);
      }
    });
  });

  $(function () {
    $("#clear-btn").on("click", function () {
        clearForm(this.form);
    });
  
    function clearForm (form) {
      $(form)
          .find("input, select, textarea")
          .not(":button, :submit, :reset, :hidden")
          .val("")
          .prop("checked", false)
          .prop("selected", false)
      ;
      $('select[name=sort_order]').children().first().attr('selected', true);
      $('#children_category_search').remove();
      $('#grandchildren_category_checkboxes').remove();
    }
  });
});