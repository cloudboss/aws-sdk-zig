const SyntheticDataColumnProperties = @import("synthetic_data_column_properties.zig").SyntheticDataColumnProperties;

/// Contains classification information for data columns, including mappings
/// that specify how columns should be handled during synthetic data generation
/// and privacy analysis.
pub const ColumnClassificationDetails = struct {
    /// A mapping that defines the classification of data columns for synthetic data
    /// generation and specifies how each column should be handled during the
    /// privacy-preserving data synthesis process.
    column_mapping: []const SyntheticDataColumnProperties,

    pub const json_field_names = .{
        .column_mapping = "columnMapping",
    };
};
