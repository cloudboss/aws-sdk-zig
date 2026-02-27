pub const MergeStrategy = enum {
    overwrite,

    pub const json_field_names = .{
        .overwrite = "OVERWRITE",
    };
};
