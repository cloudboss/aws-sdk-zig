pub const ValidationMode = enum {
    off,
    strict,

    pub const json_field_names = .{
        .off = "OFF",
        .strict = "STRICT",
    };
};
