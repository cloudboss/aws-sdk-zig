const AnalyticsAndOperator = @import("analytics_and_operator.zig").AnalyticsAndOperator;
const Tag = @import("tag.zig").Tag;

/// The filter used to describe a set of objects for analyses. A filter must
/// have exactly one prefix,
/// one tag, or one conjunction (AnalyticsAndOperator). If no filter is
/// provided, all objects will be
/// considered in any analysis.
pub const AnalyticsFilter = union(enum) {
    /// A conjunction (logical AND) of predicates, which is used in evaluating an
    /// analytics filter. The
    /// operator must have at least two predicates.
    @"and": ?AnalyticsAndOperator,
    /// The prefix to use when evaluating an analytics filter.
    prefix: ?[]const u8,
    /// The tag to use when evaluating an analytics filter.
    tag: ?Tag,
};
