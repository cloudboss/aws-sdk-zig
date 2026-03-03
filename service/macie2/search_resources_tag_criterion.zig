const SearchResourcesComparator = @import("search_resources_comparator.zig").SearchResourcesComparator;
const SearchResourcesTagCriterionPair = @import("search_resources_tag_criterion_pair.zig").SearchResourcesTagCriterionPair;

/// Specifies a tag-based filter condition that determines which Amazon Web
/// Services resources are included or excluded from the query results.
pub const SearchResourcesTagCriterion = struct {
    /// The operator to use in the condition. Valid values are EQ (equals) and NE
    /// (not equals).
    comparator: ?SearchResourcesComparator = null,

    /// The tag keys, tag values, or tag key and value pairs to use in the
    /// condition.
    tag_values: ?[]const SearchResourcesTagCriterionPair = null,

    pub const json_field_names = .{
        .comparator = "comparator",
        .tag_values = "tagValues",
    };
};
