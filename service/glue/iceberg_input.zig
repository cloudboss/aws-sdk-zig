const CreateIcebergTableInput = @import("create_iceberg_table_input.zig").CreateIcebergTableInput;
const MetadataOperation = @import("metadata_operation.zig").MetadataOperation;

/// A structure that defines an Apache Iceberg metadata table to create in the
/// catalog.
pub const IcebergInput = struct {
    /// The configuration parameters required to create a new Iceberg table in the
    /// Glue Data Catalog, including table properties
    /// and metadata specifications.
    create_iceberg_table_input: ?CreateIcebergTableInput,

    /// A required metadata operation. Can only be set to `CREATE`.
    metadata_operation: MetadataOperation,

    /// The table version for the Iceberg table. Defaults to 2.
    version: ?[]const u8,

    pub const json_field_names = .{
        .create_iceberg_table_input = "CreateIcebergTableInput",
        .metadata_operation = "MetadataOperation",
        .version = "Version",
    };
};
