const AwsEc2VpcPeeringConnectionVpcInfoDetails = @import("aws_ec_2_vpc_peering_connection_vpc_info_details.zig").AwsEc2VpcPeeringConnectionVpcInfoDetails;
const AwsEc2VpcPeeringConnectionStatusDetails = @import("aws_ec_2_vpc_peering_connection_status_details.zig").AwsEc2VpcPeeringConnectionStatusDetails;

/// Provides information about a VPC peering connection between two VPCs: a
/// requester VPC that you own and an
/// accepter VPC with which to create the connection.
pub const AwsEc2VpcPeeringConnectionDetails = struct {
    /// Information about the accepter VPC.
    accepter_vpc_info: ?AwsEc2VpcPeeringConnectionVpcInfoDetails,

    /// The time at which an unaccepted VPC peering connection will expire.
    expiration_time: ?[]const u8,

    /// Information about the requester VPC.
    requester_vpc_info: ?AwsEc2VpcPeeringConnectionVpcInfoDetails,

    /// The status of the VPC peering connection.
    status: ?AwsEc2VpcPeeringConnectionStatusDetails,

    /// The ID of the VPC peering connection.
    vpc_peering_connection_id: ?[]const u8,

    pub const json_field_names = .{
        .accepter_vpc_info = "AccepterVpcInfo",
        .expiration_time = "ExpirationTime",
        .requester_vpc_info = "RequesterVpcInfo",
        .status = "Status",
        .vpc_peering_connection_id = "VpcPeeringConnectionId",
    };
};
