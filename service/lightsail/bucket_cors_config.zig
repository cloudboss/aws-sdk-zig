const BucketCorsRule = @import("bucket_cors_rule.zig").BucketCorsRule;

/// Describes the cross-origin resource sharing (CORS) configuration for a
/// Lightsail bucket. CORS defines a way for client web applications that are
/// loaded in one domain to interact with resources in a different domain.
/// For more information, see [Configuring cross-origin resource sharing
/// (CORS)](https://docs.aws.amazon.com/lightsail/latest/userguide/configure-cors.html).
pub const BucketCorsConfig = struct {
    /// A set of origins and methods (cross-origin access that you want to allow).
    /// You can add up to 20 rules to the configuration. The total size is limited
    /// to 64 KB.
    rules: ?[]const BucketCorsRule,

    pub const json_field_names = .{
        .rules = "rules",
    };
};
