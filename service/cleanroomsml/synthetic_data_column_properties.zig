const SyntheticDataColumnType = @import("synthetic_data_column_type.zig").SyntheticDataColumnType;

/// Properties that define how a specific data column should be handled during
/// synthetic data generation, including its name, type, and role in predictive
/// modeling.
pub const SyntheticDataColumnProperties = struct {
    /// The name of the data column as it appears in the dataset.
    column_name: []const u8,

    /// The data type of the column, which determines how the synthetic data
    /// generation algorithm processes and synthesizes values for this column.
    column_type: SyntheticDataColumnType,

    /// Indicates if this column contains predictive values that should be treated
    /// as target variables in machine learning models. This affects how the
    /// synthetic data generation preserves statistical relationships.
    is_predictive_value: bool,

    pub const json_field_names = .{
        .column_name = "columnName",
        .column_type = "columnType",
        .is_predictive_value = "isPredictiveValue",
    };
};
