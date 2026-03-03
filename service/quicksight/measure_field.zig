const CalculatedMeasureField = @import("calculated_measure_field.zig").CalculatedMeasureField;
const CategoricalMeasureField = @import("categorical_measure_field.zig").CategoricalMeasureField;
const DateMeasureField = @import("date_measure_field.zig").DateMeasureField;
const NumericalMeasureField = @import("numerical_measure_field.zig").NumericalMeasureField;

/// The measure (metric) type field.
pub const MeasureField = struct {
    /// The calculated measure field only used in pivot tables.
    calculated_measure_field: ?CalculatedMeasureField = null,

    /// The measure type field with categorical type columns.
    categorical_measure_field: ?CategoricalMeasureField = null,

    /// The measure type field with date type columns.
    date_measure_field: ?DateMeasureField = null,

    /// The measure type field with numerical type columns.
    numerical_measure_field: ?NumericalMeasureField = null,

    pub const json_field_names = .{
        .calculated_measure_field = "CalculatedMeasureField",
        .categorical_measure_field = "CategoricalMeasureField",
        .date_measure_field = "DateMeasureField",
        .numerical_measure_field = "NumericalMeasureField",
    };
};
