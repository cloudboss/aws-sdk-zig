const Tag = @import("tag.zig").Tag;

/// A conjunction (logical AND) of predicates, which is used in evaluating a
/// metrics filter. The
/// operator must have at least two predicates in any combination, and an object
/// must match all of the
/// predicates for the filter to apply.
pub const AnalyticsAndOperator = struct {
    /// The prefix to use when evaluating an AND predicate: The prefix that an
    /// object must have to be
    /// included in the metrics results.
    prefix: ?[]const u8 = null,

    /// The list of tags to use when evaluating an AND predicate.
    tags: ?[]const Tag = null,
};
