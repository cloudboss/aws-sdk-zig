const VpcEndpoint = @import("vpc_endpoint.zig").VpcEndpoint;
const VpcSecurityGroupMembership = @import("vpc_security_group_membership.zig").VpcSecurityGroupMembership;

/// Information about an Amazon Redshift Serverless VPC endpoint.
pub const EndpointAccess = struct {
    /// The DNS address of the endpoint.
    address: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the VPC endpoint.
    endpoint_arn: ?[]const u8 = null,

    /// The time that the endpoint was created.
    endpoint_create_time: ?i64 = null,

    /// The name of the VPC endpoint.
    endpoint_name: ?[]const u8 = null,

    /// The status of the VPC endpoint.
    endpoint_status: ?[]const u8 = null,

    /// The port number on which Amazon Redshift Serverless accepts incoming
    /// connections.
    port: ?i32 = null,

    /// The unique identifier of subnets where Amazon Redshift Serverless choose to
    /// deploy the VPC endpoint.
    subnet_ids: ?[]const []const u8 = null,

    /// The connection endpoint for connecting to Amazon Redshift Serverless.
    vpc_endpoint: ?VpcEndpoint = null,

    /// The security groups associated with the endpoint.
    vpc_security_groups: ?[]const VpcSecurityGroupMembership = null,

    /// The name of the workgroup associated with the endpoint.
    workgroup_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .address = "address",
        .endpoint_arn = "endpointArn",
        .endpoint_create_time = "endpointCreateTime",
        .endpoint_name = "endpointName",
        .endpoint_status = "endpointStatus",
        .port = "port",
        .subnet_ids = "subnetIds",
        .vpc_endpoint = "vpcEndpoint",
        .vpc_security_groups = "vpcSecurityGroups",
        .workgroup_name = "workgroupName",
    };
};
