const Tag = @import("tag.zig").Tag;

/// This is used in a Lifecycle Rule Filter to apply a logical AND to two or
/// more predicates. The
/// Lifecycle Rule will apply to any object matching all of the predicates
/// configured inside the And
/// operator.
pub const LifecycleRuleAndOperator = struct {
    /// Minimum object size to which the rule applies.
    object_size_greater_than: ?i64,

    /// Maximum object size to which the rule applies.
    object_size_less_than: ?i64,

    /// Prefix identifying one or more objects to which the rule applies.
    prefix: ?[]const u8,

    /// All of these tags must exist in the object's tag set in order for the rule
    /// to apply.
    tags: ?[]const Tag,
};
