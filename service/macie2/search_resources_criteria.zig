const SearchResourcesSimpleCriterion = @import("search_resources_simple_criterion.zig").SearchResourcesSimpleCriterion;
const SearchResourcesTagCriterion = @import("search_resources_tag_criterion.zig").SearchResourcesTagCriterion;

/// Specifies a property- or tag-based filter condition for including or
/// excluding Amazon Web Services resources from the query results.
pub const SearchResourcesCriteria = struct {
    /// A property-based condition that defines a property, operator, and one or
    /// more values for including or excluding resources from the results.
    simple_criterion: ?SearchResourcesSimpleCriterion,

    /// A tag-based condition that defines an operator and tag keys, tag values, or
    /// tag key and value pairs for including or excluding resources from the
    /// results.
    tag_criterion: ?SearchResourcesTagCriterion,

    pub const json_field_names = .{
        .simple_criterion = "simpleCriterion",
        .tag_criterion = "tagCriterion",
    };
};
