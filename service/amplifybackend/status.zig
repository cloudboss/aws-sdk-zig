pub const Status = enum {
    latest,
    stale,

    pub const json_field_names = .{
        .latest = "LATEST",
        .stale = "STALE",
    };
};
