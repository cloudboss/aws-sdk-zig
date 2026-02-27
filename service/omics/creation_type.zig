pub const CreationType = enum {
    import,
    upload,

    pub const json_field_names = .{
        .import = "IMPORT",
        .upload = "UPLOAD",
    };
};
