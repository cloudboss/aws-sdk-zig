const UpdateIcebergTableInput = @import("update_iceberg_table_input.zig").UpdateIcebergTableInput;

/// Input parameters specific to updating Apache Iceberg tables in Glue Data
/// Catalog, containing the update operations to be applied to an existing
/// Iceberg
/// table.
pub const UpdateIcebergInput = struct {
    /// The specific update operations to be applied to the Iceberg table,
    /// containing a
    /// list of updates that define the new state of the table including schema,
    /// partitions, and properties.
    update_iceberg_table_input: UpdateIcebergTableInput,

    pub const json_field_names = .{
        .update_iceberg_table_input = "UpdateIcebergTableInput",
    };
};
