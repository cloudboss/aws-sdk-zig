/// The caching configuration for a resolver that has caching activated.
pub const CachingConfig = struct {
    /// The caching keys for a resolver that has caching activated.
    ///
    /// Valid values are entries from the `$context.arguments`,
    /// `$context.source`, and `$context.identity` maps.
    caching_keys: ?[]const []const u8,

    /// The TTL in seconds for a resolver that has caching activated.
    ///
    /// Valid values are 1–3,600 seconds.
    ttl: i64 = 0,

    pub const json_field_names = .{
        .caching_keys = "cachingKeys",
        .ttl = "ttl",
    };
};
