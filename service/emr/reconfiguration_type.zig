pub const ReconfigurationType = enum {
    overwrite,
    merge,

    pub const json_field_names = .{
        .overwrite = "OVERWRITE",
        .merge = "MERGE",
    };
};
