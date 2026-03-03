const aws = @import("aws");

const GlueSchema = @import("glue_schema.zig").GlueSchema;

/// Specifies a connector to an Apache Spark data source.
pub const SparkConnectorSource = struct {
    /// Additional connection options for the connector.
    additional_options: ?[]const aws.map.StringMapEntry = null,

    /// The name of the connection that is associated with the connector.
    connection_name: []const u8,

    /// The type of connection, such as marketplace.spark or custom.spark,
    /// designating a connection to an Apache Spark data store.
    connection_type: []const u8,

    /// The name of a connector that assists with accessing the data store in Glue
    /// Studio.
    connector_name: []const u8,

    /// The name of the data source.
    name: []const u8,

    /// Specifies data schema for the custom spark source.
    output_schemas: ?[]const GlueSchema = null,

    pub const json_field_names = .{
        .additional_options = "AdditionalOptions",
        .connection_name = "ConnectionName",
        .connection_type = "ConnectionType",
        .connector_name = "ConnectorName",
        .name = "Name",
        .output_schemas = "OutputSchemas",
    };
};
