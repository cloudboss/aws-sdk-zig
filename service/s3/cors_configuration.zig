const CORSRule = @import("cors_rule.zig").CORSRule;

/// Describes the cross-origin access configuration for objects in an Amazon S3
/// bucket. For more information,
/// see [Enabling Cross-Origin Resource
/// Sharing](https://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html) in the
/// *Amazon S3 User Guide*.
pub const CORSConfiguration = struct {
    /// A set of origins and methods (cross-origin access that you want to allow).
    /// You can add up to 100
    /// rules to the configuration.
    cors_rules: []const CORSRule,
};
