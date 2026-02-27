pub const AsgType = enum {
    single_instance_type,
    mixed_instance_type,

    pub const json_field_names = .{
        .single_instance_type = "SINGLE_INSTANCE_TYPE",
        .mixed_instance_type = "MIXED_INSTANCE_TYPE",
    };
};
