$(document).on 'turbolinks:load', ->
  $('[data-provider="summernote"]').each ->
    $(this).summernote

      codemirror:
        lineWrapping: true
        lineNumbers: true
        tabSize: 2
        theme: 'solarized'
        #mode: "text/x-haml"
        
        
      height: 400
      width: 800
      # airMode: true
      
