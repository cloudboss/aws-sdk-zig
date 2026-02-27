pub const ClusterField = enum {
    attachments,
    configurations,
    settings,
    statistics,
    tags,

    pub const json_field_names = .{
        .attachments = "ATTACHMENTS",
        .configurations = "CONFIGURATIONS",
        .settings = "SETTINGS",
        .statistics = "STATISTICS",
        .tags = "TAGS",
    };
};
