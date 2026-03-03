const DnsEntry = @import("dns_entry.zig").DnsEntry;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const Tag = @import("tag.zig").Tag;
const State = @import("state.zig").State;

/// Describes a VPC endpoint connection to a service.
pub const VpcEndpointConnection = struct {
    /// The date and time that the VPC endpoint was created.
    creation_timestamp: ?i64 = null,

    /// The DNS entries for the VPC endpoint.
    dns_entries: ?[]const DnsEntry = null,

    /// The Amazon Resource Names (ARNs) of the Gateway Load Balancers for the
    /// service.
    gateway_load_balancer_arns: ?[]const []const u8 = null,

    /// The IP address type for the endpoint.
    ip_address_type: ?IpAddressType = null,

    /// The Amazon Resource Names (ARNs) of the network load balancers for the
    /// service.
    network_load_balancer_arns: ?[]const []const u8 = null,

    /// The ID of the service to which the endpoint is connected.
    service_id: ?[]const u8 = null,

    /// The tags.
    tags: ?[]const Tag = null,

    /// The ID of the VPC endpoint connection.
    vpc_endpoint_connection_id: ?[]const u8 = null,

    /// The ID of the VPC endpoint.
    vpc_endpoint_id: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the VPC endpoint.
    vpc_endpoint_owner: ?[]const u8 = null,

    /// The Region of the endpoint.
    vpc_endpoint_region: ?[]const u8 = null,

    /// The state of the VPC endpoint.
    vpc_endpoint_state: ?State = null,
};
