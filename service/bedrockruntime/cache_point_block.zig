const CacheTTL = @import("cache_ttl.zig").CacheTTL;
const CachePointType = @import("cache_point_type.zig").CachePointType;

/// Defines a section of content to be cached for reuse in subsequent API calls.
pub const CachePointBlock = struct {
    /// Optional TTL duration for cache entries. When specified, enables extended
    /// TTL caching with the specified duration. When omitted, uses `type` value for
    /// caching behavior.
    ttl: ?CacheTTL,

    /// Specifies the type of cache point within the CachePointBlock.
    @"type": CachePointType,

    pub const json_field_names = .{
        .ttl = "ttl",
        .@"type" = "type",
    };
};
