pub const ApiCachingBehavior = enum {
    full_request_caching,
    per_resolver_caching,
    operation_level_caching,

    pub const json_field_names = .{
        .full_request_caching = "FULL_REQUEST_CACHING",
        .per_resolver_caching = "PER_RESOLVER_CACHING",
        .operation_level_caching = "OPERATION_LEVEL_CACHING",
    };
};
