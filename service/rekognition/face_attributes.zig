pub const FaceAttributes = enum {
    default,
    all,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .all = "ALL",
    };
};
