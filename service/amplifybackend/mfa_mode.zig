pub const MFAMode = enum {
    on,
    off,
    optional,

    pub const json_field_names = .{
        .on = "ON",
        .off = "OFF",
        .optional = "OPTIONAL",
    };
};
