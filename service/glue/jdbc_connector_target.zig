const aws = @import("aws");

const GlueSchema = @import("glue_schema.zig").GlueSchema;

/// Specifies a data target that writes to Amazon S3 in Apache Parquet columnar
/// storage.
pub const JDBCConnectorTarget = struct {
    /// Additional connection options for the connector.
    additional_options: ?[]const aws.map.StringMapEntry = null,

    /// The name of the connection that is associated with the connector.
    connection_name: []const u8,

    /// The name of the table in the data target.
    connection_table: []const u8,

    /// The type of connection, such as marketplace.jdbc or custom.jdbc, designating
    /// a connection to a JDBC data target.
    connection_type: []const u8,

    /// The name of a connector that will be used.
    connector_name: []const u8,

    /// The nodes that are inputs to the data target.
    inputs: []const []const u8,

    /// The name of the data target.
    name: []const u8,

    /// Specifies the data schema for the JDBC target.
    output_schemas: ?[]const GlueSchema = null,

    pub const json_field_names = .{
        .additional_options = "AdditionalOptions",
        .connection_name = "ConnectionName",
        .connection_table = "ConnectionTable",
        .connection_type = "ConnectionType",
        .connector_name = "ConnectorName",
        .inputs = "Inputs",
        .name = "Name",
        .output_schemas = "OutputSchemas",
    };
};
