pub const LayerAvailability = enum {
    available,
    unavailable,
    archived,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .unavailable = "UNAVAILABLE",
        .archived = "ARCHIVED",
    };
};
