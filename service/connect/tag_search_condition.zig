const StringComparisonType = @import("string_comparison_type.zig").StringComparisonType;

/// The search criteria to be used to return tags.
pub const TagSearchCondition = struct {
    /// The tag key used in the tag search condition.
    tag_key: ?[]const u8,

    /// The type of comparison to be made when evaluating the tag key in tag search
    /// condition.
    tag_key_comparison_type: ?StringComparisonType,

    /// The tag value used in the tag search condition.
    tag_value: ?[]const u8,

    /// The type of comparison to be made when evaluating the tag value in tag
    /// search condition.
    tag_value_comparison_type: ?StringComparisonType,

    pub const json_field_names = .{
        .tag_key = "tagKey",
        .tag_key_comparison_type = "tagKeyComparisonType",
        .tag_value = "tagValue",
        .tag_value_comparison_type = "tagValueComparisonType",
    };
};
