const CacheBehavior = @import("cache_behavior.zig").CacheBehavior;

/// A complex type that contains zero or more `CacheBehavior` elements.
pub const CacheBehaviors = struct {
    /// Optional: A complex type that contains cache behaviors for this
    /// distribution. If `Quantity` is `0`, you can omit `Items`.
    items: ?[]const CacheBehavior = null,

    /// The number of cache behaviors for this distribution.
    quantity: i32,
};
