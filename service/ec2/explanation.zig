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
    acl: ?AnalysisComponent = null,

    /// The network ACL rule.
    acl_rule: ?AnalysisAclRule = null,

    /// The IPv4 address, in CIDR notation.
    address: ?[]const u8 = null,

    /// The IPv4 addresses, in CIDR notation.
    addresses: ?[]const []const u8 = null,

    /// The resource to which the component is attached.
    attached_to: ?AnalysisComponent = null,

    /// The IDs of the Availability Zones.
    availability_zone_ids: ?[]const []const u8 = null,

    /// The Availability Zones.
    availability_zones: ?[]const []const u8 = null,

    /// The CIDR ranges.
    cidrs: ?[]const []const u8 = null,

    /// The listener for a Classic Load Balancer.
    classic_load_balancer_listener: ?AnalysisLoadBalancerListener = null,

    /// The component.
    component: ?AnalysisComponent = null,

    /// The Amazon Web Services account for the component.
    component_account: ?[]const u8 = null,

    /// The Region for the component.
    component_region: ?[]const u8 = null,

    /// The customer gateway.
    customer_gateway: ?AnalysisComponent = null,

    /// The destination.
    destination: ?AnalysisComponent = null,

    /// The destination VPC.
    destination_vpc: ?AnalysisComponent = null,

    /// The direction. The following are the possible values:
    ///
    /// * egress
    ///
    /// * ingress
    direction: ?[]const u8 = null,

    /// The load balancer listener.
    elastic_load_balancer_listener: ?AnalysisComponent = null,

    /// The explanation code.
    explanation_code: ?[]const u8 = null,

    /// The Network Firewall stateful rule.
    firewall_stateful_rule: ?FirewallStatefulRule = null,

    /// The Network Firewall stateless rule.
    firewall_stateless_rule: ?FirewallStatelessRule = null,

    /// The route table.
    ingress_route_table: ?AnalysisComponent = null,

    /// The internet gateway.
    internet_gateway: ?AnalysisComponent = null,

    /// The Amazon Resource Name (ARN) of the load balancer.
    load_balancer_arn: ?[]const u8 = null,

    /// The listener port of the load balancer.
    load_balancer_listener_port: ?i32 = null,

    /// The target.
    load_balancer_target: ?AnalysisLoadBalancerTarget = null,

    /// The target group.
    load_balancer_target_group: ?AnalysisComponent = null,

    /// The target groups.
    load_balancer_target_groups: ?[]const AnalysisComponent = null,

    /// The target port.
    load_balancer_target_port: ?i32 = null,

    /// The missing component.
    missing_component: ?[]const u8 = null,

    /// The NAT gateway.
    nat_gateway: ?AnalysisComponent = null,

    /// The network interface.
    network_interface: ?AnalysisComponent = null,

    /// The packet field.
    packet_field: ?[]const u8 = null,

    /// The port.
    port: ?i32 = null,

    /// The port ranges.
    port_ranges: ?[]const PortRange = null,

    /// The prefix list.
    prefix_list: ?AnalysisComponent = null,

    /// The protocols.
    protocols: ?[]const []const u8 = null,

    /// The route table.
    route_table: ?AnalysisComponent = null,

    /// The route table route.
    route_table_route: ?AnalysisRouteTableRoute = null,

    /// The security group.
    security_group: ?AnalysisComponent = null,

    /// The security group rule.
    security_group_rule: ?AnalysisSecurityGroupRule = null,

    /// The security groups.
    security_groups: ?[]const AnalysisComponent = null,

    /// The source VPC.
    source_vpc: ?AnalysisComponent = null,

    /// The state.
    state: ?[]const u8 = null,

    /// The subnet.
    subnet: ?AnalysisComponent = null,

    /// The route table for the subnet.
    subnet_route_table: ?AnalysisComponent = null,

    /// The transit gateway.
    transit_gateway: ?AnalysisComponent = null,

    /// The transit gateway attachment.
    transit_gateway_attachment: ?AnalysisComponent = null,

    /// The transit gateway route table.
    transit_gateway_route_table: ?AnalysisComponent = null,

    /// The transit gateway route table route.
    transit_gateway_route_table_route: ?TransitGatewayRouteTableRoute = null,

    /// The component VPC.
    vpc: ?AnalysisComponent = null,

    /// The VPC endpoint.
    vpc_endpoint: ?AnalysisComponent = null,

    /// The VPC peering connection.
    vpc_peering_connection: ?AnalysisComponent = null,

    /// The VPN connection.
    vpn_connection: ?AnalysisComponent = null,

    /// The VPN gateway.
    vpn_gateway: ?AnalysisComponent = null,
};
