**Practice Problems**
#For each of the following filetypes, indicate whether that filetype is considered server-side or client-side and why.

1. Gemfile: 
  My answer: This is a server-side file as it includes all the dependencies the server will need to use in order to run the Ruby application
  Launchschoo: Server-side. This file is used by Bundler, the Ruby dependency management system, to install libraries needed to run the program.

2. Ruby Files: 
  My answer: These are server-side files as they must be run on the application server. The clients browser does not have the ability to run Ruby 
  Launchschool: Server-side. These files are the core of a Sinatra application. The code within them runs on the server while handling incoming requests.

3. Sytlesheets: 
  Ny Answer: These are client-side files and used by the clients web browser to properly format HTML files
  Launchschool: Client-side. The code within these files is interpreted by the web browser (a client) as instructions for how to display a web page.

4. JavaScript Files: 
  My Answer: These are client-side files that can be run by the clients browser to provide addtiional functionality such as simulating statefullness
  Launchschool: Client-side. The code within these files is evaluated by the JavaScript interpreter within a web browser (a client) to add behavior to a web page.

5. View Templates: 
  My Answer: These are server-side files that the application server must process and turn into HTML before the web server can send them to the client?
  Launchschool: Server-side. The Ruby code within these files is evaluated on the server to generate a response that will then be sent to the client.

  But what about the HTML tags within a view template? Aren't those client-side code?

  This is a common point of confusion, as these files contain both client-side code (HTML tags) and server-side code (Ruby). 
  However, since they must be processed by a program on the server before being sent to the client, the ERB templates we've used in this course are considered to be server-side code.

  In fact, the templates we've been using are sometimes referred to as "server side templates" to differentiate them from "client-side templates". 
  Client-side templates are used by rich JavaScript applications to render a template directly on the client, without it needing to first be processed by a server. 
  Don't worry about those for now though, we'll have plenty of time to deal with them in the front end courses.