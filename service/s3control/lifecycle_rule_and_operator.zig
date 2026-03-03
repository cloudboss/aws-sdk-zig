const S3Tag = @import("s3_tag.zig").S3Tag;

/// The container for the Outposts bucket lifecycle rule and operator.
pub const LifecycleRuleAndOperator = struct {
    /// The non-inclusive minimum object size for the lifecycle rule. Setting this
    /// property to 7 means the rule applies to objects with a size that is greater
    /// than 7.
    object_size_greater_than: ?i64 = null,

    /// The non-inclusive maximum object size for the lifecycle rule. Setting this
    /// property to 77 means the rule applies to objects with a size that is less
    /// than 77.
    object_size_less_than: ?i64 = null,

    /// Prefix identifying one or more objects to which the rule applies.
    prefix: ?[]const u8 = null,

    /// All of these tags must exist in the object's tag set in order for the rule
    /// to
    /// apply.
    tags: ?[]const S3Tag = null,
};
