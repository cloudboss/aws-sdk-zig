pub const StatusReasonCode = enum {
    no_available_configuration_recorder,
    maximum_number_of_config_rules_exceeded,
    internal_error,

    pub const json_field_names = .{
        .no_available_configuration_recorder = "NO_AVAILABLE_CONFIGURATION_RECORDER",
        .maximum_number_of_config_rules_exceeded = "MAXIMUM_NUMBER_OF_CONFIG_RULES_EXCEEDED",
        .internal_error = "INTERNAL_ERROR",
    };
};
