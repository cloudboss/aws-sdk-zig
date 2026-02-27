const CacheTTL = @import("cache_ttl.zig").CacheTTL;

/// Cache creation metrics for a specific TTL duration
pub const CacheDetail = struct {
    /// Number of tokens written to cache with this TTL (cache creation tokens)
    input_tokens: i32,

    /// TTL duration for these cached tokens
    ttl: CacheTTL,

    pub const json_field_names = .{
        .input_tokens = "inputTokens",
        .ttl = "ttl",
    };
};
