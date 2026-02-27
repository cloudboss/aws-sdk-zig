pub const TargetStorageClass = enum {
    standard,
    archive,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .archive = "ARCHIVE",
    };
};
