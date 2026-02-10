const LifecycleRule = @import("lifecycle_rule.zig").LifecycleRule;

/// Specifies the lifecycle configuration for objects in an Amazon S3 bucket.
/// For more information, see
/// [Object Lifecycle
/// Management](https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html) in the *Amazon S3 User Guide*.
pub const BucketLifecycleConfiguration = struct {
    /// A lifecycle rule for individual objects in an Amazon S3 bucket.
    rules: []const LifecycleRule,
};
