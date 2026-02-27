const SearchResourcesCriteriaBlock = @import("search_resources_criteria_block.zig").SearchResourcesCriteriaBlock;

/// Specifies property- and tag-based conditions that define filter criteria for
/// including or excluding S3 buckets from the query results. Exclude conditions
/// take precedence over include conditions.
pub const SearchResourcesBucketCriteria = struct {
    /// The property- and tag-based conditions that determine which buckets to
    /// exclude from the results.
    excludes: ?SearchResourcesCriteriaBlock,

    /// The property- and tag-based conditions that determine which buckets to
    /// include in the results.
    includes: ?SearchResourcesCriteriaBlock,

    pub const json_field_names = .{
        .excludes = "excludes",
        .includes = "includes",
    };
};
