const DnsEntry = @import("dns_entry.zig").DnsEntry;
const DnsOptions = @import("dns_options.zig").DnsOptions;
const SecurityGroupIdentifier = @import("security_group_identifier.zig").SecurityGroupIdentifier;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const SubnetIpPrefixes = @import("subnet_ip_prefixes.zig").SubnetIpPrefixes;
const LastError = @import("last_error.zig").LastError;
const State = @import("state.zig").State;
const Tag = @import("tag.zig").Tag;
const VpcEndpointType = @import("vpc_endpoint_type.zig").VpcEndpointType;

/// Describes a VPC endpoint.
pub const VpcEndpoint = struct {
    /// The date and time that the endpoint was created.
    creation_timestamp: ?i64,

    /// (Interface endpoint) The DNS entries for the endpoint.
    dns_entries: ?[]const DnsEntry,

    /// The DNS options for the endpoint.
    dns_options: ?DnsOptions,

    /// Reason for the failure.
    failure_reason: ?[]const u8,

    /// (Interface endpoint) Information about the security groups that are
    /// associated with
    /// the network interface.
    groups: ?[]const SecurityGroupIdentifier,

    /// The IP address type for the endpoint.
    ip_address_type: ?IpAddressType,

    /// Array of IPv4 prefixes.
    ipv_4_prefixes: ?[]const SubnetIpPrefixes,

    /// Array of IPv6 prefixes.
    ipv_6_prefixes: ?[]const SubnetIpPrefixes,

    /// The last error that occurred for endpoint.
    last_error: ?LastError,

    /// (Interface endpoint) The network interfaces for the endpoint.
    network_interface_ids: ?[]const []const u8,

    /// The ID of the Amazon Web Services account that owns the endpoint.
    owner_id: ?[]const u8,

    /// The policy document associated with the endpoint, if applicable.
    policy_document: ?[]const u8,

    /// (Interface endpoint) Indicates whether the VPC is associated with a private
    /// hosted zone.
    private_dns_enabled: ?bool,

    /// Indicates whether the endpoint is being managed by its service.
    requester_managed: ?bool,

    /// The Amazon Resource Name (ARN) of the resource configuration.
    resource_configuration_arn: ?[]const u8,

    /// (Gateway endpoint) The IDs of the route tables associated with the endpoint.
    route_table_ids: ?[]const []const u8,

    /// The name of the service to which the endpoint is associated.
    service_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the service network.
    service_network_arn: ?[]const u8,

    /// The Region where the service is hosted.
    service_region: ?[]const u8,

    /// The state of the endpoint.
    state: ?State,

    /// (Interface endpoint) The subnets for the endpoint.
    subnet_ids: ?[]const []const u8,

    /// The tags assigned to the endpoint.
    tags: ?[]const Tag,

    /// The ID of the endpoint.
    vpc_endpoint_id: ?[]const u8,

    /// The type of endpoint.
    vpc_endpoint_type: ?VpcEndpointType,

    /// The ID of the VPC to which the endpoint is associated.
    vpc_id: ?[]const u8,
};
