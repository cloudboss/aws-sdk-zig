pub const AutoScalingConfigurationStatus = enum {
    active,
    inactive,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .inactive = "INACTIVE",
    };
};
