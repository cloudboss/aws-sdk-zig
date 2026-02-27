pub const DeviceStatus = enum {
    registered,
    deregistering,
    deregistered,
    archived,

    pub const json_field_names = .{
        .registered = "REGISTERED",
        .deregistering = "DEREGISTERING",
        .deregistered = "DEREGISTERED",
        .archived = "ARCHIVED",
    };
};
