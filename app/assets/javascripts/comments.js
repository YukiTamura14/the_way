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
            var element ='<div class="comment_area">' + '<li>' + '<div class="comment_icon_area"' + '<p class="user_icon">' + '<img class="comment_icon" src=' + data.icon + '>' + '</p>' +
                          '<p>' + escapeHtml(data.content) + '</p>' + '</div>' +
                          '<p class="posted_by_at">' +
                          'posted by <a rel="nofollow" data-method="post" href="/conversations?recipient_id=' + data.comment_user_id + '&;sender_id=' + data.current_user_id + '">' + data.name +
                          '</a>' + '</p>' + '<p class="posted_by_at">' + data.created_at + '</p>' + '</li>' +
                          '<a href=/concerns/' + concern_id + "/comments/" + data.id + '/edit>' +
                          '<i class="fa fa-pencil-square-o" aria-hidden="true"></i>編集</a> ' +
                          '<a data-confirm="本当に削除していいですか？" rel="nofollow"' + 'href = "/concerns/"' + concern_id + '/comments/' + data.id + '/delete>' +
                          '<a href=/concerns/' + concern_id + '/comments/' + data.id + '/delete>' +
                          '<i class="fa fa-trash-o aria-hidden="true""></i>削除</a>' +
                          '<div id="like-button_' + data.id + '">' +
                          '<form class="button_to" method="post" action="/concerns/' + concern_id + '/comments/' + data.id  + '/likes" data-remote="true">' +
                          '<button id="like-button_"' + data.id  + 'type="submit">' + '<span class="fa fa-thumbs-o-up">' + '</span>' + '<span>' + displayLikesCount(data.likes_count) +'</span>' + '</button>' +
                          '<input type="hidden" name="authenticity_token" value="">' + '</form>' + '</div>' + '</div>'
            $('.comment_index').prepend(element);
            $('#comment_area').val('')
        })
 });

function displayLikesCount(likesCount) {
  return likesCount === 0 ? '' : likesCount
}

function escapeHtml(str) {
    str = str.replace(/&/g, '&amp;');
    str = str.replace(/</g, '&lt;');
    str = str.replace(/>/g, '&gt;');
    str = str.replace(/"/g, '&quot;');
    str = str.replace(/'/g, '&#39;');
    return str
}
