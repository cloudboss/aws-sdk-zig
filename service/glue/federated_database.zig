/// A database that points to an entity outside the Glue Data Catalog.
pub const FederatedDatabase = struct {
    /// The name of the connection to the external metastore.
    connection_name: ?[]const u8,

    /// The type of connection used to access the federated database, such as JDBC,
    /// ODBC, or other supported connection protocols.
    connection_type: ?[]const u8,

    /// A unique identifier for the federated database.
    identifier: ?[]const u8,

    pub const json_field_names = .{
        .connection_name = "ConnectionName",
        .connection_type = "ConnectionType",
        .identifier = "Identifier",
    };
};
