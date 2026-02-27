pub const LifecyclePolicyStorageClass = enum {
    archive,
    standard,

    pub const json_field_names = .{
        .archive = "ARCHIVE",
        .standard = "STANDARD",
    };
};
