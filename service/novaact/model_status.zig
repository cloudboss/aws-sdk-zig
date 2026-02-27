pub const ModelStatus = enum {
    active,
    legacy,
    deprecated,
    preview,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .legacy = "LEGACY",
        .deprecated = "DEPRECATED",
        .preview = "PREVIEW",
    };
};
