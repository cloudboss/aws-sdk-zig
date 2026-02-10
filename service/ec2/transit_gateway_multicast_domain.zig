const TransitGatewayMulticastDomainOptions = @import("transit_gateway_multicast_domain_options.zig").TransitGatewayMulticastDomainOptions;
const TransitGatewayMulticastDomainState = @import("transit_gateway_multicast_domain_state.zig").TransitGatewayMulticastDomainState;
const Tag = @import("tag.zig").Tag;

/// Describes the transit gateway multicast domain.
pub const TransitGatewayMulticastDomain = struct {
    /// The time the transit gateway multicast domain was created.
    creation_time: ?i64,

    /// The options for the transit gateway multicast domain.
    options: ?TransitGatewayMulticastDomainOptions,

    /// The ID of the Amazon Web Services account that owns the transit gateway
    /// multicast domain.
    owner_id: ?[]const u8,

    /// The state of the transit gateway multicast domain.
    state: ?TransitGatewayMulticastDomainState,

    /// The tags for the transit gateway multicast domain.
    tags: ?[]const Tag,

    /// The ID of the transit gateway.
    transit_gateway_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the transit gateway multicast domain.
    transit_gateway_multicast_domain_arn: ?[]const u8,

    /// The ID of the transit gateway multicast domain.
    transit_gateway_multicast_domain_id: ?[]const u8,
};
