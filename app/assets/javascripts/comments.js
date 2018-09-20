$('#comment_submit').on('click',function(e){
  var path = location.pathname;
  var concern_id = path.split('/')
  concern_id = concern_id[2]
  e.preventDefault()
  $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
});
  $.ajax({
           url:`/concerns/${concern_id}/comments`,
           type:'POST',
           data:{
               'comment':$('#comment_area').val(),
           }
       })

       .done(function(data) {
           $('.comment_index').append(`<li>${data.content}</li>`);
           $('#comment_area').val('')
       })
});
