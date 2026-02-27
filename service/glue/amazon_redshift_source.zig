const AmazonRedshiftNodeData = @import("amazon_redshift_node_data.zig").AmazonRedshiftNodeData;

/// Specifies an Amazon Redshift source.
pub const AmazonRedshiftSource = struct {
    /// Specifies the data of the Amazon Reshift source node.
    data: ?AmazonRedshiftNodeData,

    /// The name of the Amazon Redshift source.
    name: ?[]const u8,

    pub const json_field_names = .{
        .data = "Data",
        .name = "Name",
    };
};
