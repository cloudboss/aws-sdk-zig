const LifecycleRuleAndOperator = @import("lifecycle_rule_and_operator.zig").LifecycleRuleAndOperator;
const S3Tag = @import("s3_tag.zig").S3Tag;

/// The container for the filter of the lifecycle rule.
pub const LifecycleRuleFilter = struct {
    /// The container for the `AND` condition for the lifecycle rule.
    @"and": ?LifecycleRuleAndOperator = null,

    /// Minimum object size to which the rule applies.
    object_size_greater_than: ?i64 = null,

    /// Maximum object size to which the rule applies.
    object_size_less_than: ?i64 = null,

    /// Prefix identifying one or more objects to which the rule applies.
    ///
    /// When you're using XML requests, you must
    /// replace special characters (such as carriage returns) in object keys with
    /// their equivalent XML entity codes.
    /// For more information, see [
    /// XML-related object key
    /// constraints](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html#object-key-xml-related-constraints) in the *Amazon S3 User Guide*.
    prefix: ?[]const u8 = null,

    tag: ?S3Tag = null,
};
