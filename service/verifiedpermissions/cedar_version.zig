pub const CedarVersion = enum {
    cedar_2,
    cedar_4,

    pub const json_field_names = .{
        .cedar_2 = "CEDAR_2",
        .cedar_4 = "CEDAR_4",
    };
};
