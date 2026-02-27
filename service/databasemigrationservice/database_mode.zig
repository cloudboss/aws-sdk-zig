pub const DatabaseMode = enum {
    default,
    babelfish,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .babelfish = "BABELFISH",
    };
};
