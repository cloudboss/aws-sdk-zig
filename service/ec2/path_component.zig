const AnalysisAclRule = @import("analysis_acl_rule.zig").AnalysisAclRule;
const AdditionalDetail = @import("additional_detail.zig").AdditionalDetail;
const AnalysisComponent = @import("analysis_component.zig").AnalysisComponent;
const Explanation = @import("explanation.zig").Explanation;
const FirewallStatefulRule = @import("firewall_stateful_rule.zig").FirewallStatefulRule;
const FirewallStatelessRule = @import("firewall_stateless_rule.zig").FirewallStatelessRule;
const AnalysisPacketHeader = @import("analysis_packet_header.zig").AnalysisPacketHeader;
const AnalysisRouteTableRoute = @import("analysis_route_table_route.zig").AnalysisRouteTableRoute;
const AnalysisSecurityGroupRule = @import("analysis_security_group_rule.zig").AnalysisSecurityGroupRule;
const TransitGatewayRouteTableRoute = @import("transit_gateway_route_table_route.zig").TransitGatewayRouteTableRoute;

/// Describes a path component.
pub const PathComponent = struct {
    /// The network ACL rule.
    acl_rule: ?AnalysisAclRule = null,

    /// The additional details.
    additional_details: ?[]const AdditionalDetail = null,

    /// The resource to which the path component is attached.
    attached_to: ?AnalysisComponent = null,

    /// The component.
    component: ?AnalysisComponent = null,

    /// The destination VPC.
    destination_vpc: ?AnalysisComponent = null,

    /// The load balancer listener.
    elastic_load_balancer_listener: ?AnalysisComponent = null,

    /// The explanation codes.
    explanations: ?[]const Explanation = null,

    /// The Network Firewall stateful rule.
    firewall_stateful_rule: ?FirewallStatefulRule = null,

    /// The Network Firewall stateless rule.
    firewall_stateless_rule: ?FirewallStatelessRule = null,

    /// The inbound header.
    inbound_header: ?AnalysisPacketHeader = null,

    /// The outbound header.
    outbound_header: ?AnalysisPacketHeader = null,

    /// The route table route.
    route_table_route: ?AnalysisRouteTableRoute = null,

    /// The security group rule.
    security_group_rule: ?AnalysisSecurityGroupRule = null,

    /// The sequence number.
    sequence_number: ?i32 = null,

    /// The name of the VPC endpoint service.
    service_name: ?[]const u8 = null,

    /// The source VPC.
    source_vpc: ?AnalysisComponent = null,

    /// The subnet.
    subnet: ?AnalysisComponent = null,

    /// The transit gateway.
    transit_gateway: ?AnalysisComponent = null,

    /// The route in a transit gateway route table.
    transit_gateway_route_table_route: ?TransitGatewayRouteTableRoute = null,

    /// The component VPC.
    vpc: ?AnalysisComponent = null,
};
