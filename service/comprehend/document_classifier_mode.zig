pub const DocumentClassifierMode = enum {
    multi_class,
    multi_label,

    pub const json_field_names = .{
        .multi_class = "MULTI_CLASS",
        .multi_label = "MULTI_LABEL",
    };
};
