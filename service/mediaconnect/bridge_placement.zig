pub const BridgePlacement = enum {
    available,
    locked,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .locked = "LOCKED",
    };
};
