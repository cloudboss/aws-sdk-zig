pub const SourceType = enum {
    owned,
    entitled,

    pub const json_field_names = .{
        .owned = "OWNED",
        .entitled = "ENTITLED",
    };
};
