pub const LustreReadCacheSizingMode = enum {
    no_cache,
    user_provisioned,
    proportional_to_throughput_capacity,

    pub const json_field_names = .{
        .no_cache = "NO_CACHE",
        .user_provisioned = "USER_PROVISIONED",
        .proportional_to_throughput_capacity = "PROPORTIONAL_TO_THROUGHPUT_CAPACITY",
    };
};
