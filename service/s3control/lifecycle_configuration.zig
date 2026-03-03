const LifecycleRule = @import("lifecycle_rule.zig").LifecycleRule;

/// The container for the Outposts bucket lifecycle configuration.
pub const LifecycleConfiguration = struct {
    /// A lifecycle rule for individual objects in an Outposts bucket.
    rules: ?[]const LifecycleRule = null,
};
