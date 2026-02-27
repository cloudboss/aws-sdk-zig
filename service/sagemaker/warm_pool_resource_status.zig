pub const WarmPoolResourceStatus = enum {
    available,
    terminated,
    reused,
    inuse,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .terminated = "TERMINATED",
        .reused = "REUSED",
        .inuse = "INUSE",
    };
};
