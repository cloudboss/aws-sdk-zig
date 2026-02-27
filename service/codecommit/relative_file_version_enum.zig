pub const RelativeFileVersionEnum = enum {
    before,
    after,

    pub const json_field_names = .{
        .before = "BEFORE",
        .after = "AFTER",
    };
};
