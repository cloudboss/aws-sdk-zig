const CachePolicy = @import("cache_policy.zig").CachePolicy;
const CachePolicyType = @import("cache_policy_type.zig").CachePolicyType;

/// Contains a cache policy.
pub const CachePolicySummary = struct {
    /// The cache policy.
    cache_policy: CachePolicy,

    /// The type of cache policy, either `managed` (created by Amazon Web Services)
    /// or `custom` (created in this Amazon Web Services account).
    @"type": CachePolicyType,
};
