const EndpointAccessType = @import("endpoint_access_type.zig").EndpointAccessType;
const FailedReason = @import("failed_reason.zig").FailedReason;
const NetworkInterface = @import("network_interface.zig").NetworkInterface;
const EndpointStatus = @import("endpoint_status.zig").EndpointStatus;

/// Amazon S3 on Outposts Access Points simplify managing data access at scale
/// for shared datasets in S3 on Outposts.
/// S3 on Outposts uses endpoints to connect to Outposts buckets so that you can
/// perform actions within your
/// virtual private cloud (VPC). For more information, see [
/// Accessing S3 on Outposts using VPC-only access
/// points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WorkingWithS3Outposts.html) in the *Amazon Simple Storage Service User Guide*.
pub const Endpoint = struct {
    /// The type of connectivity used to access the Amazon S3 on Outposts endpoint.
    access_type: ?EndpointAccessType,

    /// The VPC CIDR committed by this endpoint.
    cidr_block: ?[]const u8,

    /// The time the endpoint was created.
    creation_time: ?i64,

    /// The ID of the customer-owned IPv4 address pool used for the endpoint.
    customer_owned_ipv_4_pool: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the endpoint.
    endpoint_arn: ?[]const u8,

    /// The failure reason, if any, for a create or delete endpoint operation.
    failed_reason: ?FailedReason,

    /// The network interface of the endpoint.
    network_interfaces: ?[]const NetworkInterface,

    /// The ID of the Outposts.
    outposts_id: ?[]const u8,

    /// The ID of the security group used for the endpoint.
    security_group_id: ?[]const u8,

    /// The status of the endpoint.
    status: ?EndpointStatus,

    /// The ID of the subnet used for the endpoint.
    subnet_id: ?[]const u8,

    /// The ID of the VPC used for the endpoint.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .access_type = "AccessType",
        .cidr_block = "CidrBlock",
        .creation_time = "CreationTime",
        .customer_owned_ipv_4_pool = "CustomerOwnedIpv4Pool",
        .endpoint_arn = "EndpointArn",
        .failed_reason = "FailedReason",
        .network_interfaces = "NetworkInterfaces",
        .outposts_id = "OutpostsId",
        .security_group_id = "SecurityGroupId",
        .status = "Status",
        .subnet_id = "SubnetId",
        .vpc_id = "VpcId",
    };
};
