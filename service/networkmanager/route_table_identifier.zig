const CoreNetworkNetworkFunctionGroupIdentifier = @import("core_network_network_function_group_identifier.zig").CoreNetworkNetworkFunctionGroupIdentifier;
const CoreNetworkSegmentEdgeIdentifier = @import("core_network_segment_edge_identifier.zig").CoreNetworkSegmentEdgeIdentifier;

/// Describes a route table.
pub const RouteTableIdentifier = struct {
    /// The route table identifier associated with the network function group.
    core_network_network_function_group: ?CoreNetworkNetworkFunctionGroupIdentifier = null,

    /// The segment edge in a core network.
    core_network_segment_edge: ?CoreNetworkSegmentEdgeIdentifier = null,

    /// The ARN of the transit gateway route table for the attachment request. For
    /// example, `"TransitGatewayRouteTableArn":
    /// "arn:aws:ec2:us-west-2:123456789012:transit-gateway-route-table/tgw-rtb-9876543210123456"`.
    transit_gateway_route_table_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .core_network_network_function_group = "CoreNetworkNetworkFunctionGroup",
        .core_network_segment_edge = "CoreNetworkSegmentEdge",
        .transit_gateway_route_table_arn = "TransitGatewayRouteTableArn",
    };
};
