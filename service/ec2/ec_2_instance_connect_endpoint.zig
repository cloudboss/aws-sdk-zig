const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const InstanceConnectEndpointPublicDnsNames = @import("instance_connect_endpoint_public_dns_names.zig").InstanceConnectEndpointPublicDnsNames;
const Ec2InstanceConnectEndpointState = @import("ec_2_instance_connect_endpoint_state.zig").Ec2InstanceConnectEndpointState;
const Tag = @import("tag.zig").Tag;

/// Describes an EC2 Instance Connect Endpoint.
pub const Ec2InstanceConnectEndpoint = struct {
    /// The Availability Zone of the EC2 Instance Connect Endpoint.
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone of the EC2 Instance Connect Endpoint.
    availability_zone_id: ?[]const u8,

    /// The date and time that the EC2 Instance Connect Endpoint was created.
    created_at: ?i64,

    /// The DNS name of the EC2 Instance Connect Endpoint.
    dns_name: ?[]const u8,

    /// The Federal Information Processing Standards (FIPS) compliant DNS name of
    /// the EC2
    /// Instance Connect Endpoint.
    fips_dns_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the EC2 Instance Connect Endpoint.
    instance_connect_endpoint_arn: ?[]const u8,

    /// The ID of the EC2 Instance Connect Endpoint.
    instance_connect_endpoint_id: ?[]const u8,

    /// The IP address type of the endpoint.
    ip_address_type: ?IpAddressType,

    /// The ID of the elastic network interface that Amazon EC2 automatically
    /// created when creating the EC2
    /// Instance Connect Endpoint.
    network_interface_ids: ?[]const []const u8,

    /// The ID of the Amazon Web Services account that created the EC2 Instance
    /// Connect Endpoint.
    owner_id: ?[]const u8,

    /// Indicates whether your client's IP address is preserved as the source when
    /// you connect to a resource.
    /// The following are the possible values.
    ///
    /// * `true` - Use the IP address of the client. Your instance must have an IPv4
    ///   address.
    ///
    /// * `false` - Use the IP address of the network interface.
    ///
    /// Default: `false`
    preserve_client_ip: ?bool,

    /// The public DNS names of the endpoint.
    public_dns_names: ?InstanceConnectEndpointPublicDnsNames,

    /// The security groups associated with the endpoint. If you didn't specify a
    /// security group,
    /// the default security group for your VPC is associated with the endpoint.
    security_group_ids: ?[]const []const u8,

    /// The current state of the EC2 Instance Connect Endpoint.
    state: ?Ec2InstanceConnectEndpointState,

    /// The message for the current state of the EC2 Instance Connect Endpoint.
    /// Can include a failure message.
    state_message: ?[]const u8,

    /// The ID of the subnet in which the EC2 Instance Connect Endpoint was created.
    subnet_id: ?[]const u8,

    /// The tags assigned to the EC2 Instance Connect Endpoint.
    tags: ?[]const Tag,

    /// The ID of the VPC in which the EC2 Instance Connect Endpoint was created.
    vpc_id: ?[]const u8,
};
