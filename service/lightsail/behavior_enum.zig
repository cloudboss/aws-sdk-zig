pub const BehaviorEnum = enum {
    dont_cache_setting,
    cache_setting,

    pub const json_field_names = .{
        .dont_cache_setting = "DontCacheSetting",
        .cache_setting = "CacheSetting",
    };
};
