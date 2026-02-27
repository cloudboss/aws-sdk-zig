pub const IdNamespaceType = enum {
    source,
    target,

    pub const json_field_names = .{
        .source = "SOURCE",
        .target = "TARGET",
    };
};
