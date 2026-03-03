const aws = @import("aws");

/// Specifies a target generated with standard connection options.
pub const ConnectorDataTarget = struct {
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

    /// The nodes that are inputs to the data target.
    inputs: ?[]const []const u8 = null,

    /// The name of this target node.
    name: []const u8,

    pub const json_field_names = .{
        .connection_type = "ConnectionType",
        .data = "Data",
        .inputs = "Inputs",
        .name = "Name",
    };
};
