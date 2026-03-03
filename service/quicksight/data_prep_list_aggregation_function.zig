/// An aggregation function that concatenates values from multiple rows into a
/// single string with a specified
/// separator.
pub const DataPrepListAggregationFunction = struct {
    /// Whether to include only distinct values in the concatenated result, removing
    /// duplicates.
    distinct: bool = false,

    /// The name of the column containing values to be concatenated.
    input_column_name: ?[]const u8 = null,

    /// The string used to separate values in the concatenated result.
    separator: []const u8,

    pub const json_field_names = .{
        .distinct = "Distinct",
        .input_column_name = "InputColumnName",
        .separator = "Separator",
    };
};
