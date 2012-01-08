$(function() {
	// Deck initialization
	$.deck('.slide');


  toc = $('<ul id="toc-ul"></ul>');
  $('.toc h2, .toc h1').each(function(bla) {
    id = $(this).parent().attr("id")
    a = $('<a />').attr("href", "#" + id).html($(this).text())
    li = $('<li />').html(a).attr("class", this.tagName)
    toc.append(li)
  });
  $('#toc').html(toc);

  author = $('#author').text()
  $('#author').remove();
  $('section').each(function() {
    span = $('<div class="slide-footer" />').html(author)
    $(this).append(span);
  });
});

