const LifecycleRuleAndOperator = @import("lifecycle_rule_and_operator.zig").LifecycleRuleAndOperator;
const Tag = @import("tag.zig").Tag;

/// The `Filter` is used to identify objects that a Lifecycle Rule applies to. A
/// `Filter` can have exactly one of `Prefix`, `Tag`,
/// `ObjectSizeGreaterThan`, `ObjectSizeLessThan`, or `And` specified. If
/// the `Filter` element is left empty, the Lifecycle Rule applies to all
/// objects in the
/// bucket.
pub const LifecycleRuleFilter = struct {
    @"and": ?LifecycleRuleAndOperator = null,

    /// Minimum object size to which the rule applies.
    object_size_greater_than: ?i64 = null,

    /// Maximum object size to which the rule applies.
    object_size_less_than: ?i64 = null,

    /// Prefix identifying one or more objects to which the rule applies.
    ///
    /// Replacement must be made for object keys containing special characters (such
    /// as carriage returns) when using
    /// XML requests. For more information, see [
    /// XML related object key
    /// constraints](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html#object-key-xml-related-constraints).
    prefix: ?[]const u8 = null,

    /// This tag must exist in the object's tag set in order for the rule to apply.
    ///
    /// This parameter applies to general purpose buckets only. It is not supported
    /// for directory bucket
    /// lifecycle configurations.
    tag: ?Tag = null,
};
