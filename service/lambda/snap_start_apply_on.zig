pub const SnapStartApplyOn = enum {
    published_versions,
    none,

    pub const json_field_names = .{
        .published_versions = "PublishedVersions",
        .none = "None",
    };
};
