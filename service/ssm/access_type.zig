pub const AccessType = enum {
    standard,
    justintime,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .justintime = "JUSTINTIME",
    };
};
