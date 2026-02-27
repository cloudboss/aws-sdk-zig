pub const PutMode = enum {
    merge,
    overwrite,

    pub const json_field_names = .{
        .merge = "Merge",
        .overwrite = "Overwrite",
    };
};
