pub const Range = enum {
    narrow,
    full,
    fullprotect,

    pub const json_field_names = .{
        .narrow = "NARROW",
        .full = "FULL",
        .fullprotect = "FULLPROTECT",
    };
};
