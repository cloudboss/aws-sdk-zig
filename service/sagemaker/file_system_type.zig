pub const FileSystemType = enum {
    efs,
    fsxlustre,

    pub const json_field_names = .{
        .efs = "EFS",
        .fsxlustre = "FSXLUSTRE",
    };
};
