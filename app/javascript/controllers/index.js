// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from 'controllers/application'

import { Autocomplete } from 'stimulus-autocomplete'
application.register('autocomplete', Autocomplete)

import { eagerLoadControllersFrom } from '@hotwired/stimulus-loading'
eagerLoadControllersFrom('controllers', application)
