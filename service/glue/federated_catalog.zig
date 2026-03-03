/// A catalog that points to an entity outside the Glue Data Catalog.
pub const FederatedCatalog = struct {
    /// The name of the connection to an external data source, for example a
    /// Redshift-federated catalog.
    connection_name: ?[]const u8 = null,

    /// The type of connection used to access the federated catalog, specifying the
    /// protocol or method for connection to the
    /// external data source.
    connection_type: ?[]const u8 = null,

    /// A unique identifier for the federated catalog.
    identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .connection_name = "ConnectionName",
        .connection_type = "ConnectionType",
        .identifier = "Identifier",
    };
};
