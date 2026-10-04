const ConnectionStatus = @import("connection_status.zig").ConnectionStatus;

/// The VPC connection properties returned in responses.
pub const VpcPropertiesOutput = struct {
    /// The Amazon Web Services Glue connection names associated with the VPC
    /// connection.
    glue_connection_names: ?[]const []const u8 = null,

    /// The security group ID of the VPC connection.
    security_group_id: ?[]const u8 = null,

    /// The status of the VPC connection.
    status: ConnectionStatus,

    /// The subnet IDs of the VPC connection.
    subnet_ids: []const []const u8,

    /// The identifier of the VPC.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .glue_connection_names = "glueConnectionNames",
        .security_group_id = "securityGroupId",
        .status = "status",
        .subnet_ids = "subnetIds",
        .vpc_id = "vpcId",
    };
};
