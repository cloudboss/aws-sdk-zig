/// The type of event to match with the rule.
pub const EventBridgeRuleTemplateEventType = enum {
    medialive_multiplex_alert,
    medialive_multiplex_state_change,
    medialive_channel_alert,
    medialive_channel_input_change,
    medialive_channel_state_change,
    mediapackage_input_notification,
    mediapackage_key_provider_notification,
    mediapackage_harvest_job_notification,
    signal_map_active_alarm,
    mediaconnect_alert,
    mediaconnect_source_health,
    mediaconnect_output_health,
    mediaconnect_flow_status_change,

    pub const json_field_names = .{
        .medialive_multiplex_alert = "MEDIALIVE_MULTIPLEX_ALERT",
        .medialive_multiplex_state_change = "MEDIALIVE_MULTIPLEX_STATE_CHANGE",
        .medialive_channel_alert = "MEDIALIVE_CHANNEL_ALERT",
        .medialive_channel_input_change = "MEDIALIVE_CHANNEL_INPUT_CHANGE",
        .medialive_channel_state_change = "MEDIALIVE_CHANNEL_STATE_CHANGE",
        .mediapackage_input_notification = "MEDIAPACKAGE_INPUT_NOTIFICATION",
        .mediapackage_key_provider_notification = "MEDIAPACKAGE_KEY_PROVIDER_NOTIFICATION",
        .mediapackage_harvest_job_notification = "MEDIAPACKAGE_HARVEST_JOB_NOTIFICATION",
        .signal_map_active_alarm = "SIGNAL_MAP_ACTIVE_ALARM",
        .mediaconnect_alert = "MEDIACONNECT_ALERT",
        .mediaconnect_source_health = "MEDIACONNECT_SOURCE_HEALTH",
        .mediaconnect_output_health = "MEDIACONNECT_OUTPUT_HEALTH",
        .mediaconnect_flow_status_change = "MEDIACONNECT_FLOW_STATUS_CHANGE",
    };
};
