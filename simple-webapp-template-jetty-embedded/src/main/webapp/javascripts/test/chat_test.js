
var chatTest = TestCase.create({
    name: 'Chat test',

    setup: function() {
      $("#log").html("");  
      
      // stub Ajax per tutti i test
      $this = this;    
      this.ajaxOptions = null;      
      $.ajax = function(options) {
        $this.ajaxOptions = options;
        if ($this.assumeAjaxReturns) {
          $this.ajaxOptions.success($this.assumeAjaxReturns);
        }
      }
      
    },

		teardown: function() {
		},
		
		"test che so parsare il risultato ottenuto da ajax": function() {
			var fromAjax = 
			'<ul>' +
	      '<li>' +
	        '<p class="message">' +
	          '<span class="message-id">13252727</a>' +
	          '<a href="/users/4444" class="author">Mario Rossi</a> ' +
	          '<span class="message">Messaggio 1</span>' +
	          '<span class="timestamp">2011-06-08 10:01:00</span>' +
	        '</p>' +
	      '</li>' +
	    '</ul>';
			var html = "";
			$(fromAjax).find("p.message").each(function() {
				var timestamp = $(this).find("span.timestamp").text();
				var author = $(this).find("a.author").text();
				var message = $(this).find("span.message").text();
				html += "<p>";
				html += "Alle " + timestamp;
				html += " " + author;
				html += " scrisse:"
				html += message;
				html += "</p>";
			});
			console.log(html);
		},
				
    
});
