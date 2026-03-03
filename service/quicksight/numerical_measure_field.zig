const NumericalAggregationFunction = @import("numerical_aggregation_function.zig").NumericalAggregationFunction;
const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const NumberFormatConfiguration = @import("number_format_configuration.zig").NumberFormatConfiguration;

/// The measure type field with numerical type columns.
pub const NumericalMeasureField = struct {
    /// The aggregation function of the measure field.
    aggregation_function: ?NumericalAggregationFunction = null,

    /// The column that is used in the `NumericalMeasureField`.
    column: ColumnIdentifier,

    /// The custom field ID.
    field_id: []const u8,

    /// The format configuration of the field.
    format_configuration: ?NumberFormatConfiguration = null,

    pub const json_field_names = .{
        .aggregation_function = "AggregationFunction",
        .column = "Column",
        .field_id = "FieldId",
        .format_configuration = "FormatConfiguration",
    };
};
