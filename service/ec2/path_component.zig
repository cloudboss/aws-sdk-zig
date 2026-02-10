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
    acl_rule: ?AnalysisAclRule,

    /// The additional details.
    additional_details: ?[]const AdditionalDetail,

    /// The resource to which the path component is attached.
    attached_to: ?AnalysisComponent,

    /// The component.
    component: ?AnalysisComponent,

    /// The destination VPC.
    destination_vpc: ?AnalysisComponent,

    /// The load balancer listener.
    elastic_load_balancer_listener: ?AnalysisComponent,

    /// The explanation codes.
    explanations: ?[]const Explanation,

    /// The Network Firewall stateful rule.
    firewall_stateful_rule: ?FirewallStatefulRule,

    /// The Network Firewall stateless rule.
    firewall_stateless_rule: ?FirewallStatelessRule,

    /// The inbound header.
    inbound_header: ?AnalysisPacketHeader,

    /// The outbound header.
    outbound_header: ?AnalysisPacketHeader,

    /// The route table route.
    route_table_route: ?AnalysisRouteTableRoute,

    /// The security group rule.
    security_group_rule: ?AnalysisSecurityGroupRule,

    /// The sequence number.
    sequence_number: ?i32,

    /// The name of the VPC endpoint service.
    service_name: ?[]const u8,

    /// The source VPC.
    source_vpc: ?AnalysisComponent,

    /// The subnet.
    subnet: ?AnalysisComponent,

    /// The transit gateway.
    transit_gateway: ?AnalysisComponent,

    /// The route in a transit gateway route table.
    transit_gateway_route_table_route: ?TransitGatewayRouteTableRoute,

    /// The component VPC.
    vpc: ?AnalysisComponent,
};
