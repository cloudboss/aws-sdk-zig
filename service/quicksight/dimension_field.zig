const CategoricalDimensionField = @import("categorical_dimension_field.zig").CategoricalDimensionField;
const DateDimensionField = @import("date_dimension_field.zig").DateDimensionField;
const NumericalDimensionField = @import("numerical_dimension_field.zig").NumericalDimensionField;

/// The dimension type field.
pub const DimensionField = struct {
    /// The dimension type field with categorical type columns.
    categorical_dimension_field: ?CategoricalDimensionField = null,

    /// The dimension type field with date type columns.
    date_dimension_field: ?DateDimensionField = null,

    /// The dimension type field with numerical type columns.
    numerical_dimension_field: ?NumericalDimensionField = null,

    pub const json_field_names = .{
        .categorical_dimension_field = "CategoricalDimensionField",
        .date_dimension_field = "DateDimensionField",
        .numerical_dimension_field = "NumericalDimensionField",
    };
};
