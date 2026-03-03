const aws = @import("aws");

const GlueSchema = @import("glue_schema.zig").GlueSchema;

/// Specifies a source generated with standard connection options.
pub const ConnectorDataSource = struct {
    /// The `connectionType`, as provided to the underlying Glue library. This node
    /// type supports
    /// the following connection types:
    ///
    /// * `opensearch`
    ///
    /// * `azuresql`
    ///
    /// * `azurecosmos`
    ///
    /// * `bigquery`
    ///
    /// * `saphana`
    ///
    /// * `teradata`
    ///
    /// * `vertica`
    connection_type: []const u8,

    /// A map specifying connection options for the node. You can find standard
    /// connection options for the
    /// corresponding connection type in the
    /// [
    /// Connection
    /// parameters](https://docs.aws.amazon.com/glue/latest/dg/aws-glue-programming-etl-connect.html) section of the Glue documentation.
    data: []const aws.map.StringMapEntry,

    /// The name of this source node.
    name: []const u8,

    /// Specifies the data schema for this source.
    output_schemas: ?[]const GlueSchema = null,

    pub const json_field_names = .{
        .connection_type = "ConnectionType",
        .data = "Data",
        .name = "Name",
        .output_schemas = "OutputSchemas",
    };
};
