pub const UserPoolMfaType = enum {
    off,
    on,
    optional,

    pub const json_field_names = .{
        .off = "OFF",
        .on = "ON",
        .optional = "OPTIONAL",
    };
};
