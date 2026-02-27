const NodeStatus = @import("node_status.zig").NodeStatus;

/// A summary of configuration properties for a node.
pub const NodeSummary = struct {
    /// The Amazon Resource Name (ARN) of the node. For more information about ARNs
    /// and their format, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    arn: ?[]const u8,

    /// The Availability Zone in which the node exists.
    availability_zone: ?[]const u8,

    /// The date and time that the node was created.
    creation_date: ?i64,

    /// The unique identifier of the node.
    id: ?[]const u8,

    /// The EC2 instance type for the node.
    instance_type: ?[]const u8,

    /// The status of the node.
    status: ?NodeStatus,

    pub const json_field_names = .{
        .arn = "Arn",
        .availability_zone = "AvailabilityZone",
        .creation_date = "CreationDate",
        .id = "Id",
        .instance_type = "InstanceType",
        .status = "Status",
    };
};
