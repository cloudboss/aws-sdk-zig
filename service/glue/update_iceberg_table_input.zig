const IcebergTableUpdate = @import("iceberg_table_update.zig").IcebergTableUpdate;

/// Contains the update operations to be applied to an existing Iceberg table
/// inGlue Data Catalog, defining the new state of the table metadata.
pub const UpdateIcebergTableInput = struct {
    /// The list of table update operations that specify the changes to be made to
    /// the Iceberg table, including schema modifications, partition
    /// specifications, and table properties.
    updates: []const IcebergTableUpdate,

    pub const json_field_names = .{
        .updates = "Updates",
    };
};
