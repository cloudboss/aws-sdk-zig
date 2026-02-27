const ImportFilterName = @import("import_filter_name.zig").ImportFilterName;
const ImportFilterOperator = @import("import_filter_operator.zig").ImportFilterOperator;

/// Filters the response from the
/// [ListImports](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_ListImports.html) operation.
pub const ImportFilter = struct {
    /// The name of the field to use for filtering.
    name: ImportFilterName,

    /// The operator to use for the filter. Specify EQ when the
    /// `ListImports` operation should return only resource types
    /// that equal the specified value. Specify CO when the
    /// `ListImports` operation should return resource types that
    /// contain the specified value.
    operator: ImportFilterOperator,

    /// The values to use to filter the response. The values must be
    /// `Bot`, `BotLocale`, or
    /// `CustomVocabulary`.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .operator = "operator",
        .values = "values",
    };
};
