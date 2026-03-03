const aws = @import("aws");

const GlueSchema = @import("glue_schema.zig").GlueSchema;

/// Specifies a target that uses an Apache Spark connector.
pub const SparkConnectorTarget = struct {
    /// Additional connection options for the connector.
    additional_options: ?[]const aws.map.StringMapEntry = null,

    /// The name of a connection for an Apache Spark connector.
    connection_name: []const u8,

    /// The type of connection, such as marketplace.spark or custom.spark,
    /// designating a connection to an Apache Spark data store.
    connection_type: []const u8,

    /// The name of an Apache Spark connector.
    connector_name: []const u8,

    /// The nodes that are inputs to the data target.
    inputs: []const []const u8,

    /// The name of the data target.
    name: []const u8,

    /// Specifies the data schema for the custom spark target.
    output_schemas: ?[]const GlueSchema = null,

    pub const json_field_names = .{
        .additional_options = "AdditionalOptions",
        .connection_name = "ConnectionName",
        .connection_type = "ConnectionType",
        .connector_name = "ConnectorName",
        .inputs = "Inputs",
        .name = "Name",
        .output_schemas = "OutputSchemas",
    };
};
