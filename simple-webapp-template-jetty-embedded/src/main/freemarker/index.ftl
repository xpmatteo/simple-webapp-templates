<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
    <title>Ajax Chat!</title>

    <script src="/javascripts/jquery-1.6.1.min.js"></script>
    <script src="/javascripts/chat.js"></script>
    <link rel="stylesheet" href="/stylesheets/style.css" type="text/css" media="screen" />
  </head>
  <body>
    <div id="content">
      <h1>Welcome to Ajax Chat!</h1>

      <form id="chat">
        <div id="log">
          No messages in chat
        </div>
        <input type="text" name="message" id="message" size="60" />
        <input type="submit" value="OK" />
        <img id="spinner" src="images/spinner.gif" style="display: none" />
      </form>
    </div>
  </body>
</html>
