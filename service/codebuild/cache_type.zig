pub const CacheType = enum {
    no_cache,
    s3,
    local,

    pub const json_field_names = .{
        .no_cache = "NO_CACHE",
        .s3 = "S3",
        .local = "LOCAL",
    };
};
