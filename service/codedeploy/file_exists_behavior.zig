pub const FileExistsBehavior = enum {
    disallow,
    overwrite,
    retain,

    pub const json_field_names = .{
        .disallow = "DISALLOW",
        .overwrite = "OVERWRITE",
        .retain = "RETAIN",
    };
};
