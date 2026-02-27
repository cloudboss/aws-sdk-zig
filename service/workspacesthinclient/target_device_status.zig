pub const TargetDeviceStatus = enum {
    deregistered,
    archived,

    pub const json_field_names = .{
        .deregistered = "DEREGISTERED",
        .archived = "ARCHIVED",
    };
};
