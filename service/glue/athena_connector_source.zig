const GlueSchema = @import("glue_schema.zig").GlueSchema;

/// Specifies a connector to an Amazon Athena data source.
pub const AthenaConnectorSource = struct {
    /// The name of the connection that is associated with the connector.
    connection_name: []const u8,

    /// The name of the table in the data source.
    connection_table: ?[]const u8,

    /// The type of connection, such as marketplace.athena or custom.athena,
    /// designating a connection to an Amazon Athena data store.
    connection_type: []const u8,

    /// The name of a connector that assists with accessing the data store in Glue
    /// Studio.
    connector_name: []const u8,

    /// The name of the data source.
    name: []const u8,

    /// Specifies the data schema for the custom Athena source.
    output_schemas: ?[]const GlueSchema,

    /// The name of the Cloudwatch log group to read from. For example,
    /// `/aws-glue/jobs/output`.
    schema_name: []const u8,

    pub const json_field_names = .{
        .connection_name = "ConnectionName",
        .connection_table = "ConnectionTable",
        .connection_type = "ConnectionType",
        .connector_name = "ConnectorName",
        .name = "Name",
        .output_schemas = "OutputSchemas",
        .schema_name = "SchemaName",
    };
};
