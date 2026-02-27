const UpdateIcebergInput = @import("update_iceberg_input.zig").UpdateIcebergInput;

/// Input parameters for updating open table format tables in GlueData Catalog,
/// serving as a wrapper for format-specific update operations such as Apache
/// Iceberg.
pub const UpdateOpenTableFormatInput = struct {
    /// Apache Iceberg-specific update parameters that define the table
    /// modifications to
    /// be applied, including schema changes, partition specifications, and table
    /// properties.
    update_iceberg_input: ?UpdateIcebergInput,

    pub const json_field_names = .{
        .update_iceberg_input = "UpdateIcebergInput",
    };
};
