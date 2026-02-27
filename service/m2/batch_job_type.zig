pub const BatchJobType = enum {
    vse,
    jes2,
    jes3,

    pub const json_field_names = .{
        .vse = "VSE",
        .jes2 = "JES2",
        .jes3 = "JES3",
    };
};
