const SearchResourcesCriteria = @import("search_resources_criteria.zig").SearchResourcesCriteria;

/// Specifies property- and tag-based conditions that define filter criteria for
/// including or excluding Amazon Web Services resources from the query results.
pub const SearchResourcesCriteriaBlock = struct {
    /// An array of objects, one for each property- or tag-based condition that
    /// includes or excludes resources from the query results. If you specify more
    /// than one condition, Amazon Macie uses AND logic to join the conditions.
    @"and": ?[]const SearchResourcesCriteria = null,

    pub const json_field_names = .{
        .@"and" = "and",
    };
};
