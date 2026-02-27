pub const FlexCacheEndpointType = enum {
    none,
    origin,
    cache,

    pub const json_field_names = .{
        .none = "NONE",
        .origin = "ORIGIN",
        .cache = "CACHE",
    };
};
