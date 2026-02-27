/// A table that points to an entity outside the Glue Data Catalog.
pub const FederatedTable = struct {
    /// The name of the connection to the external metastore.
    connection_name: ?[]const u8,

    /// The type of connection used to access the federated table, specifying the
    /// protocol or method for connecting to the external data source.
    connection_type: ?[]const u8,

    /// A unique identifier for the federated database.
    database_identifier: ?[]const u8,

    /// A unique identifier for the federated table.
    identifier: ?[]const u8,

    pub const json_field_names = .{
        .connection_name = "ConnectionName",
        .connection_type = "ConnectionType",
        .database_identifier = "DatabaseIdentifier",
        .identifier = "Identifier",
    };
};
