pub const ModelMetadataFilterType = enum {
    domain,
    framework,
    task,
    frameworkversion,

    pub const json_field_names = .{
        .domain = "DOMAIN",
        .framework = "FRAMEWORK",
        .task = "TASK",
        .frameworkversion = "FRAMEWORKVERSION",
    };
};
