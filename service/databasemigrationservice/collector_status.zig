pub const CollectorStatus = enum {
    unregistered,
    active,

    pub const json_field_names = .{
        .unregistered = "UNREGISTERED",
        .active = "ACTIVE",
    };
};
