const AmazonRedshiftNodeData = @import("amazon_redshift_node_data.zig").AmazonRedshiftNodeData;

/// Specifies an Amazon Redshift target.
pub const AmazonRedshiftTarget = struct {
    /// Specifies the data of the Amazon Redshift target node.
    data: ?AmazonRedshiftNodeData = null,

    /// The nodes that are inputs to the data target.
    inputs: ?[]const []const u8 = null,

    /// The name of the Amazon Redshift target.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .data = "Data",
        .inputs = "Inputs",
        .name = "Name",
    };
};
