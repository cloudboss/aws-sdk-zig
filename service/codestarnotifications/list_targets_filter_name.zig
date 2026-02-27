pub const ListTargetsFilterName = enum {
    target_type,
    target_address,
    target_status,

    pub const json_field_names = .{
        .target_type = "TARGET_TYPE",
        .target_address = "TARGET_ADDRESS",
        .target_status = "TARGET_STATUS",
    };
};
