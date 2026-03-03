const LifecycleRule = @import("lifecycle_rule.zig").LifecycleRule;

pub const GetBucketLifecycleConfigurationResult = struct {
    /// Container for the lifecycle rule of the Outposts bucket.
    rules: ?[]const LifecycleRule = null,
};
