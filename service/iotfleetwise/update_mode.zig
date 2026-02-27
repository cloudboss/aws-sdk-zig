pub const UpdateMode = enum {
    overwrite,
    merge,

    pub const json_field_names = .{
        .overwrite = "OVERWRITE",
        .merge = "MERGE",
    };
};
