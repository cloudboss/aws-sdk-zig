pub const MapMatchScope = enum {
    all,
    key,
    value,

    pub const json_field_names = .{
        .all = "ALL",
        .key = "KEY",
        .value = "VALUE",
    };
};
