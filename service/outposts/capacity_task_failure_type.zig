pub const CapacityTaskFailureType = enum {
    unsupported_capacity_configuration,
    unexpected_asset_state,
    blocking_instances_not_evacuated,
    internal_server_error,
    resource_not_found,

    pub const json_field_names = .{
        .unsupported_capacity_configuration = "UNSUPPORTED_CAPACITY_CONFIGURATION",
        .unexpected_asset_state = "UNEXPECTED_ASSET_STATE",
        .blocking_instances_not_evacuated = "BLOCKING_INSTANCES_NOT_EVACUATED",
        .internal_server_error = "INTERNAL_SERVER_ERROR",
        .resource_not_found = "RESOURCE_NOT_FOUND",
    };
};
