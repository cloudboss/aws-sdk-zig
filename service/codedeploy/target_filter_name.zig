pub const TargetFilterName = enum {
    target_status,
    server_instance_label,

    pub const json_field_names = .{
        .target_status = "TARGET_STATUS",
        .server_instance_label = "SERVER_INSTANCE_LABEL",
    };
};
