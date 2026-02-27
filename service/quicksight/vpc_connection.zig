const VPCConnectionAvailabilityStatus = @import("vpc_connection_availability_status.zig").VPCConnectionAvailabilityStatus;
const NetworkInterface = @import("network_interface.zig").NetworkInterface;
const VPCConnectionResourceStatus = @import("vpc_connection_resource_status.zig").VPCConnectionResourceStatus;

/// The structure of a VPC connection.
pub const VPCConnection = struct {
    /// The Amazon Resource Name (ARN) of the VPC connection.
    arn: ?[]const u8,

    /// The availability status of the VPC connection.
    availability_status: ?VPCConnectionAvailabilityStatus,

    /// The time that the VPC connection was created.
    created_time: ?i64,

    /// A list of IP addresses of DNS resolver endpoints for the VPC connection.
    dns_resolvers: ?[]const []const u8,

    /// The time that the VPC connection was last updated.
    last_updated_time: ?i64,

    /// The display name for the VPC connection.
    name: ?[]const u8,

    /// A list of network interfaces.
    network_interfaces: ?[]const NetworkInterface,

    /// The ARN of the
    /// IAM role associated with the VPC
    /// connection.
    role_arn: ?[]const u8,

    /// The Amazon EC2 security group IDs associated with the VPC connection.
    security_group_ids: ?[]const []const u8,

    /// The status of the VPC connection.
    status: ?VPCConnectionResourceStatus,

    /// The ID of the VPC connection that you're creating. This ID is a unique
    /// identifier for each Amazon Web Services Region in an
    /// Amazon Web Services account.
    vpc_connection_id: ?[]const u8,

    /// The Amazon EC2 VPC ID associated with the VPC connection.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .availability_status = "AvailabilityStatus",
        .created_time = "CreatedTime",
        .dns_resolvers = "DnsResolvers",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .network_interfaces = "NetworkInterfaces",
        .role_arn = "RoleArn",
        .security_group_ids = "SecurityGroupIds",
        .status = "Status",
        .vpc_connection_id = "VPCConnectionId",
        .vpc_id = "VPCId",
    };
};
