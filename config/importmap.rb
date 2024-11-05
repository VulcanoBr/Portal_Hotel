# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.3.3/dist/js/bootstrap.esm.js"
pin "sweetalert2" # @11.14.0
pin "@popperjs/core", to: "https://unpkg.com/@popperjs/core@2.11.8/dist/esm/index.js" # @2.11.8
pin "stimulus-autocomplete" # @3.1.0
#pin "stimulus-autocomplete", to: "stimulus-autocomplete.min.js"
