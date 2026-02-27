pub const CacheBehavior = enum {
    cache_on_failure,
    cache_always,

    pub const json_field_names = .{
        .cache_on_failure = "CACHE_ON_FAILURE",
        .cache_always = "CACHE_ALWAYS",
    };
};
