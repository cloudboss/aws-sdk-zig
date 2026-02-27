pub const StreamGroupStatusReason = enum {
    internal_error,
    no_available_instances,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .no_available_instances = "NO_AVAILABLE_INSTANCES",
    };
};
