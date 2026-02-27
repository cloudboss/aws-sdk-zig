pub const DeletionMode = enum {
    all_configurations,
    local_configuration_only,

    pub const json_field_names = .{
        .all_configurations = "ALL_CONFIGURATIONS",
        .local_configuration_only = "LOCAL_CONFIGURATION_ONLY",
    };
};
