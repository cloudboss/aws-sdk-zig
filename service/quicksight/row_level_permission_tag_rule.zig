/// A set of rules associated with a tag.
pub const RowLevelPermissionTagRule = struct {
    /// The column name that a tag key is assigned to.
    column_name: []const u8,

    /// A string that you want to use to filter by all the values in a column in the
    /// dataset and don’t want to list the values one by one. For example, you can
    /// use an asterisk as your match all value.
    match_all_value: ?[]const u8,

    /// The unique key for a tag.
    tag_key: []const u8,

    /// A string that you want to use to delimit the values when you pass the values
    /// at run time. For example, you can delimit the values with a comma.
    tag_multi_value_delimiter: ?[]const u8,

    pub const json_field_names = .{
        .column_name = "ColumnName",
        .match_all_value = "MatchAllValue",
        .tag_key = "TagKey",
        .tag_multi_value_delimiter = "TagMultiValueDelimiter",
    };
};
