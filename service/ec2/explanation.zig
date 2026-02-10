const AnalysisComponent = @import("analysis_component.zig").AnalysisComponent;
const AnalysisAclRule = @import("analysis_acl_rule.zig").AnalysisAclRule;
const AnalysisLoadBalancerListener = @import("analysis_load_balancer_listener.zig").AnalysisLoadBalancerListener;
const FirewallStatefulRule = @import("firewall_stateful_rule.zig").FirewallStatefulRule;
const FirewallStatelessRule = @import("firewall_stateless_rule.zig").FirewallStatelessRule;
const AnalysisLoadBalancerTarget = @import("analysis_load_balancer_target.zig").AnalysisLoadBalancerTarget;
const PortRange = @import("port_range.zig").PortRange;
const AnalysisRouteTableRoute = @import("analysis_route_table_route.zig").AnalysisRouteTableRoute;
const AnalysisSecurityGroupRule = @import("analysis_security_group_rule.zig").AnalysisSecurityGroupRule;
const TransitGatewayRouteTableRoute = @import("transit_gateway_route_table_route.zig").TransitGatewayRouteTableRoute;

/// Describes an explanation code for an unreachable path. For more information,
/// see [Reachability Analyzer explanation
/// codes](https://docs.aws.amazon.com/vpc/latest/reachability/explanation-codes.html).
pub const Explanation = struct {
    /// The network ACL.
    acl: ?AnalysisComponent,

    /// The network ACL rule.
    acl_rule: ?AnalysisAclRule,

    /// The IPv4 address, in CIDR notation.
    address: ?[]const u8,

    /// The IPv4 addresses, in CIDR notation.
    addresses: ?[]const []const u8,

    /// The resource to which the component is attached.
    attached_to: ?AnalysisComponent,

    /// The IDs of the Availability Zones.
    availability_zone_ids: ?[]const []const u8,

    /// The Availability Zones.
    availability_zones: ?[]const []const u8,

    /// The CIDR ranges.
    cidrs: ?[]const []const u8,

    /// The listener for a Classic Load Balancer.
    classic_load_balancer_listener: ?AnalysisLoadBalancerListener,

    /// The component.
    component: ?AnalysisComponent,

    /// The Amazon Web Services account for the component.
    component_account: ?[]const u8,

    /// The Region for the component.
    component_region: ?[]const u8,

    /// The customer gateway.
    customer_gateway: ?AnalysisComponent,

    /// The destination.
    destination: ?AnalysisComponent,

    /// The destination VPC.
    destination_vpc: ?AnalysisComponent,

    /// The direction. The following are the possible values:
    ///
    /// * egress
    ///
    /// * ingress
    direction: ?[]const u8,

    /// The load balancer listener.
    elastic_load_balancer_listener: ?AnalysisComponent,

    /// The explanation code.
    explanation_code: ?[]const u8,

    /// The Network Firewall stateful rule.
    firewall_stateful_rule: ?FirewallStatefulRule,

    /// The Network Firewall stateless rule.
    firewall_stateless_rule: ?FirewallStatelessRule,

    /// The route table.
    ingress_route_table: ?AnalysisComponent,

    /// The internet gateway.
    internet_gateway: ?AnalysisComponent,

    /// The Amazon Resource Name (ARN) of the load balancer.
    load_balancer_arn: ?[]const u8,

    /// The listener port of the load balancer.
    load_balancer_listener_port: ?i32,

    /// The target.
    load_balancer_target: ?AnalysisLoadBalancerTarget,

    /// The target group.
    load_balancer_target_group: ?AnalysisComponent,

    /// The target groups.
    load_balancer_target_groups: ?[]const AnalysisComponent,

    /// The target port.
    load_balancer_target_port: ?i32,

    /// The missing component.
    missing_component: ?[]const u8,

    /// The NAT gateway.
    nat_gateway: ?AnalysisComponent,

    /// The network interface.
    network_interface: ?AnalysisComponent,

    /// The packet field.
    packet_field: ?[]const u8,

    /// The port.
    port: ?i32,

    /// The port ranges.
    port_ranges: ?[]const PortRange,

    /// The prefix list.
    prefix_list: ?AnalysisComponent,

    /// The protocols.
    protocols: ?[]const []const u8,

    /// The route table.
    route_table: ?AnalysisComponent,

    /// The route table route.
    route_table_route: ?AnalysisRouteTableRoute,

    /// The security group.
    security_group: ?AnalysisComponent,

    /// The security group rule.
    security_group_rule: ?AnalysisSecurityGroupRule,

    /// The security groups.
    security_groups: ?[]const AnalysisComponent,

    /// The source VPC.
    source_vpc: ?AnalysisComponent,

    /// The state.
    state: ?[]const u8,

    /// The subnet.
    subnet: ?AnalysisComponent,

    /// The route table for the subnet.
    subnet_route_table: ?AnalysisComponent,

    /// The transit gateway.
    transit_gateway: ?AnalysisComponent,

    /// The transit gateway attachment.
    transit_gateway_attachment: ?AnalysisComponent,

    /// The transit gateway route table.
    transit_gateway_route_table: ?AnalysisComponent,

    /// The transit gateway route table route.
    transit_gateway_route_table_route: ?TransitGatewayRouteTableRoute,

    /// The component VPC.
    vpc: ?AnalysisComponent,

    /// The VPC endpoint.
    vpc_endpoint: ?AnalysisComponent,

    /// The VPC peering connection.
    vpc_peering_connection: ?AnalysisComponent,

    /// The VPN connection.
    vpn_connection: ?AnalysisComponent,

    /// The VPN gateway.
    vpn_gateway: ?AnalysisComponent,
};
