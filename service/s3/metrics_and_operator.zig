const Tag = @import("tag.zig").Tag;

/// A conjunction (logical AND) of predicates, which is used in evaluating a
/// metrics filter. The
/// operator must have at least two predicates, and an object must match all of
/// the predicates in order for
/// the filter to apply.
pub const MetricsAndOperator = struct {
    /// The access point ARN used when evaluating an `AND` predicate.
    access_point_arn: ?[]const u8,

    /// The prefix used when evaluating an AND predicate.
    prefix: ?[]const u8,

    /// The list of tags used when evaluating an AND predicate.
    tags: ?[]const Tag,
};
