const CategoricalAggregationFunction = @import("categorical_aggregation_function.zig").CategoricalAggregationFunction;
const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const StringFormatConfiguration = @import("string_format_configuration.zig").StringFormatConfiguration;

/// The measure type field with categorical type columns.
pub const CategoricalMeasureField = struct {
    /// The aggregation function of the measure field.
    aggregation_function: ?CategoricalAggregationFunction = null,

    /// The column that is used in the `CategoricalMeasureField`.
    column: ColumnIdentifier,

    /// The custom field ID.
    field_id: []const u8,

    /// The format configuration of the field.
    format_configuration: ?StringFormatConfiguration = null,

    pub const json_field_names = .{
        .aggregation_function = "AggregationFunction",
        .column = "Column",
        .field_id = "FieldId",
        .format_configuration = "FormatConfiguration",
    };
};
