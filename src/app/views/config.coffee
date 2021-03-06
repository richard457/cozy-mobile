BaseView = require '../lib/base_view'
Config = require '../lib/config'
logSender = require '../lib/log_sender'

log = require('../lib/persistent_log')
    prefix: "config view"
    date: true

module.exports = class ConfigView extends BaseView

    template: require '../templates/config'

    menuEnabled: true

    events: ->
        'tap #configDone': 'configDone'
        'tap #synchrobtn': 'synchroBtn'
        'tap #sendlogbtn': -> logSender.send()

        'change #contactSyncCheck': 'saveChanges'
        'change #calendarSyncCheck': 'saveChanges'
        'change #imageSyncCheck': 'saveChanges'
        'change #wifiSyncCheck': 'saveChanges'
        'change #cozyNotificationsCheck' : 'saveChanges'

    getRenderData: ->
        log.debug "getRenderData"

        config = window.app.init.config

        cozyURL: config.get 'cozyURL'
        syncContacts: config.get 'syncContacts'
        syncCalendars: config.get 'syncCalendars'
        syncImages: config.get 'syncImages'
        syncOnWifi: config.get 'syncOnWifi'
        cozyNotifications: config.get 'cozyNotifications'
        deviceName: config.get 'deviceName'
        lastSync: @formatDate config.get 'lastSync'
        lastBackup: @formatDate config.get 'lastBackup'
        initState: app.init.currentState
        locale: app.locale
        appVersion: config.get 'appVersion'

    # format a object as a readable date string
    # return t('never') if undefined
    formatDate: (date) ->
        log.debug "formatDate #{date}"

        return t 'never' if not date or date is ''

        date = moment(date)
        return date.format 'YYYY-MM-DD HH:mm:ss'

    # only happens after the first config (post install)
    configDone: ->
        app.init.trigger 'configDone'


    # confirm, launch initial replication, navigate to first sync UI.
    synchroBtn: ->
        if confirm t 'confirm message'
            app.init.replicator.stopRealtime()
            app.init.toState 'fFirstSyncView'


    # save config changes in local pouchdb
    # prevent simultaneous changes by disabling checkboxes
    saveChanges: ->
        # disabl UI
        # put changes in replicatorConfig object
        # perform sync /init required
        # rollback on error
        # save in config on success.

        log.info "Save changes"
        checkboxes = @$ '#contactSyncCheck, #imageSyncCheck,' +
                        '#wifiSyncCheck, #cozyNotificationsCheck' +
                        '#configDone, #calendarSyncCheck'
        checkboxes.prop 'disabled', true

        @listenToOnce app.init, 'importDone error', =>
            checkboxes.prop 'disabled', false
            @render()

        app.init.updateConfig @_updateAndGetInitNeeds
            syncContacts: @$('#contactSyncCheck').is ':checked'
            syncCalendars: @$('#calendarSyncCheck').is ':checked'
            syncImages: @$('#imageSyncCheck').is ':checked'
            syncOnWifi: @$('#wifiSyncCheck').is ':checked'
            cozyNotifications: @$('#cozyNotificationsCheck').is ':checked'

    _updateAndGetInitNeeds: (changes) ->
        config = window.app.init.config
        needInit =
            cozyNotifications: changes.cozyNotifications and \
                (changes.cozyNotifications isnt config.get 'cozyNotifications')
            syncCalendars: changes.syncCalendars and \
                (changes.syncCalendars isnt config.get 'syncCalendars')
            syncContacts: changes.syncContacts and \
                (changes.syncContacts isnt config.get 'syncContacts')

        for key, value of changes
            config.set key, value

        return needInit
