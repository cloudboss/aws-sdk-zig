const ExportFilterName = @import("export_filter_name.zig").ExportFilterName;
const ExportFilterOperator = @import("export_filter_operator.zig").ExportFilterOperator;

/// Filters the response form the
/// [ListExports](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_ListExports.html) operation
pub const ExportFilter = struct {
    /// The name of the field to use for filtering.
    name: ExportFilterName,

    /// The operator to use for the filter. Specify EQ when the
    /// `ListExports` operation should return only resource types
    /// that equal the specified value. Specify CO when the
    /// `ListExports` operation should return resource types that
    /// contain the specified value.
    operator: ExportFilterOperator,

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
