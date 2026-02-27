pub const RenditionConfigurationRenditionSelection = enum {
    all,
    none,
    custom,

    pub const json_field_names = .{
        .all = "ALL",
        .none = "NONE",
        .custom = "CUSTOM",
    };
};
