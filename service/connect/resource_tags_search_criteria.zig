const TagSearchCondition = @import("tag_search_condition.zig").TagSearchCondition;

/// The search criteria to be used to search tags.
pub const ResourceTagsSearchCriteria = struct {
    /// The search criteria to be used to return tags.
    tag_search_condition: ?TagSearchCondition = null,

    pub const json_field_names = .{
        .tag_search_condition = "TagSearchCondition",
    };
};
