pub const OriginTypeValue = enum {
    source,
    target,

    pub const json_field_names = .{
        .source = "SOURCE",
        .target = "TARGET",
    };
};
