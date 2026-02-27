const DateAggregationFunction = @import("date_aggregation_function.zig").DateAggregationFunction;
const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const DateTimeFormatConfiguration = @import("date_time_format_configuration.zig").DateTimeFormatConfiguration;

/// The measure type field with date type columns.
pub const DateMeasureField = struct {
    /// The aggregation function of the measure field.
    aggregation_function: ?DateAggregationFunction,

    /// The column that is used in the `DateMeasureField`.
    column: ColumnIdentifier,

    /// The custom field ID.
    field_id: []const u8,

    /// The format configuration of the field.
    format_configuration: ?DateTimeFormatConfiguration,

    pub const json_field_names = .{
        .aggregation_function = "AggregationFunction",
        .column = "Column",
        .field_id = "FieldId",
        .format_configuration = "FormatConfiguration",
    };
};
