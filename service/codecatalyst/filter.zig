/// Information about a filter used to limit results of a query.
pub const Filter = struct {
    /// The operator used to compare the fields.
    comparison_operator: ?[]const u8 = null,

    /// A key that can be used to sort results.
    key: []const u8,

    /// The values of the key.
    values: []const []const u8,

    pub const json_field_names = .{
        .comparison_operator = "comparisonOperator",
        .key = "key",
        .values = "values",
    };
};
