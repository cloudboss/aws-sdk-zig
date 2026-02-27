pub const UnnestSpec = enum {
    toplevel,
    full,
    nounnest,

    pub const json_field_names = .{
        .toplevel = "TOPLEVEL",
        .full = "FULL",
        .nounnest = "NOUNNEST",
    };
};
