const JDBCConnectorOptions = @import("jdbc_connector_options.zig").JDBCConnectorOptions;
const GlueSchema = @import("glue_schema.zig").GlueSchema;

/// Specifies a connector to a JDBC data source.
pub const JDBCConnectorSource = struct {
    /// Additional connection options for the connector.
    additional_options: ?JDBCConnectorOptions = null,

    /// The name of the connection that is associated with the connector.
    connection_name: []const u8,

    /// The name of the table in the data source.
    connection_table: ?[]const u8 = null,

    /// The type of connection, such as marketplace.jdbc or custom.jdbc, designating
    /// a connection to a JDBC data store.
    connection_type: []const u8,

    /// The name of a connector that assists with accessing the data store in Glue
    /// Studio.
    connector_name: []const u8,

    /// The name of the data source.
    name: []const u8,

    /// Specifies the data schema for the custom JDBC source.
    output_schemas: ?[]const GlueSchema = null,

    /// The table or SQL query to get the data from. You can specify either
    /// `ConnectionTable` or `query`, but not both.
    query: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_options = "AdditionalOptions",
        .connection_name = "ConnectionName",
        .connection_table = "ConnectionTable",
        .connection_type = "ConnectionType",
        .connector_name = "ConnectorName",
        .name = "Name",
        .output_schemas = "OutputSchemas",
        .query = "Query",
    };
};
