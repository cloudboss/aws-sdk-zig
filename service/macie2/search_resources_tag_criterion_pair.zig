/// Specifies a tag key, a tag value, or a tag key and value (as a pair) to use
/// in a tag-based filter condition for a query. Tag keys and values are case
/// sensitive. Also, Amazon Macie doesn't support use of partial values or
/// wildcard characters in tag-based filter conditions.
pub const SearchResourcesTagCriterionPair = struct {
    /// The value for the tag key to use in the condition.
    key: ?[]const u8 = null,

    /// The tag value to use in the condition.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
