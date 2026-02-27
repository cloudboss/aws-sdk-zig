pub const ConfigurationSetFilterName = enum {
    event_destination_name,
    matching_event_types,
    default_message_type,
    default_sender_id,
    default_message_feedback_enabled,
    protect_configuration_id,

    pub const json_field_names = .{
        .event_destination_name = "EVENT_DESTINATION_NAME",
        .matching_event_types = "MATCHING_EVENT_TYPES",
        .default_message_type = "DEFAULT_MESSAGE_TYPE",
        .default_sender_id = "DEFAULT_SENDER_ID",
        .default_message_feedback_enabled = "DEFAULT_MESSAGE_FEEDBACK_ENABLED",
        .protect_configuration_id = "PROTECT_CONFIGURATION_ID",
    };
};
