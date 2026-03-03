const AwsEc2InstanceViolation = @import("aws_ec_2_instance_violation.zig").AwsEc2InstanceViolation;
const AwsEc2NetworkInterfaceViolation = @import("aws_ec_2_network_interface_violation.zig").AwsEc2NetworkInterfaceViolation;
const AwsVPCSecurityGroupViolation = @import("aws_vpc_security_group_violation.zig").AwsVPCSecurityGroupViolation;
const DnsDuplicateRuleGroupViolation = @import("dns_duplicate_rule_group_violation.zig").DnsDuplicateRuleGroupViolation;
const DnsRuleGroupLimitExceededViolation = @import("dns_rule_group_limit_exceeded_violation.zig").DnsRuleGroupLimitExceededViolation;
const DnsRuleGroupPriorityConflictViolation = @import("dns_rule_group_priority_conflict_violation.zig").DnsRuleGroupPriorityConflictViolation;
const FirewallSubnetIsOutOfScopeViolation = @import("firewall_subnet_is_out_of_scope_violation.zig").FirewallSubnetIsOutOfScopeViolation;
const FirewallSubnetMissingVPCEndpointViolation = @import("firewall_subnet_missing_vpc_endpoint_violation.zig").FirewallSubnetMissingVPCEndpointViolation;
const InvalidNetworkAclEntriesViolation = @import("invalid_network_acl_entries_violation.zig").InvalidNetworkAclEntriesViolation;
const NetworkFirewallBlackHoleRouteDetectedViolation = @import("network_firewall_black_hole_route_detected_violation.zig").NetworkFirewallBlackHoleRouteDetectedViolation;
const NetworkFirewallInternetTrafficNotInspectedViolation = @import("network_firewall_internet_traffic_not_inspected_violation.zig").NetworkFirewallInternetTrafficNotInspectedViolation;
const NetworkFirewallInvalidRouteConfigurationViolation = @import("network_firewall_invalid_route_configuration_violation.zig").NetworkFirewallInvalidRouteConfigurationViolation;
const NetworkFirewallMissingExpectedRoutesViolation = @import("network_firewall_missing_expected_routes_violation.zig").NetworkFirewallMissingExpectedRoutesViolation;
const NetworkFirewallMissingExpectedRTViolation = @import("network_firewall_missing_expected_rt_violation.zig").NetworkFirewallMissingExpectedRTViolation;
const NetworkFirewallMissingFirewallViolation = @import("network_firewall_missing_firewall_violation.zig").NetworkFirewallMissingFirewallViolation;
const NetworkFirewallMissingSubnetViolation = @import("network_firewall_missing_subnet_violation.zig").NetworkFirewallMissingSubnetViolation;
const NetworkFirewallPolicyModifiedViolation = @import("network_firewall_policy_modified_violation.zig").NetworkFirewallPolicyModifiedViolation;
const NetworkFirewallUnexpectedFirewallRoutesViolation = @import("network_firewall_unexpected_firewall_routes_violation.zig").NetworkFirewallUnexpectedFirewallRoutesViolation;
const NetworkFirewallUnexpectedGatewayRoutesViolation = @import("network_firewall_unexpected_gateway_routes_violation.zig").NetworkFirewallUnexpectedGatewayRoutesViolation;
const PossibleRemediationActions = @import("possible_remediation_actions.zig").PossibleRemediationActions;
const RouteHasOutOfScopeEndpointViolation = @import("route_has_out_of_scope_endpoint_violation.zig").RouteHasOutOfScopeEndpointViolation;
const ThirdPartyFirewallMissingExpectedRouteTableViolation = @import("third_party_firewall_missing_expected_route_table_violation.zig").ThirdPartyFirewallMissingExpectedRouteTableViolation;
const ThirdPartyFirewallMissingFirewallViolation = @import("third_party_firewall_missing_firewall_violation.zig").ThirdPartyFirewallMissingFirewallViolation;
const ThirdPartyFirewallMissingSubnetViolation = @import("third_party_firewall_missing_subnet_violation.zig").ThirdPartyFirewallMissingSubnetViolation;
const WebACLHasIncompatibleConfigurationViolation = @import("web_acl_has_incompatible_configuration_violation.zig").WebACLHasIncompatibleConfigurationViolation;
const WebACLHasOutOfScopeResourcesViolation = @import("web_acl_has_out_of_scope_resources_violation.zig").WebACLHasOutOfScopeResourcesViolation;

/// Violation detail based on resource type.
pub const ResourceViolation = struct {
    /// Violation detail for an EC2 instance.
    aws_ec_2_instance_violation: ?AwsEc2InstanceViolation = null,

    /// Violation detail for a network interface.
    aws_ec_2_network_interface_violation: ?AwsEc2NetworkInterfaceViolation = null,

    /// Violation detail for security groups.
    aws_vpc_security_group_violation: ?AwsVPCSecurityGroupViolation = null,

    /// Violation detail for a DNS Firewall policy that indicates that a rule group
    /// that Firewall Manager
    /// tried to associate with a VPC is already associated with the VPC and can't
    /// be associated again.
    dns_duplicate_rule_group_violation: ?DnsDuplicateRuleGroupViolation = null,

    /// Violation detail for a DNS Firewall policy that indicates that the VPC
    /// reached the limit for associated DNS Firewall rule groups. Firewall Manager
    /// tried to associate another rule group with the VPC and failed.
    dns_rule_group_limit_exceeded_violation: ?DnsRuleGroupLimitExceededViolation = null,

    /// Violation detail for a DNS Firewall policy that indicates that a rule group
    /// that Firewall Manager
    /// tried to associate with a VPC has the same priority as a rule group that's
    /// already associated.
    dns_rule_group_priority_conflict_violation: ?DnsRuleGroupPriorityConflictViolation = null,

    /// Contains details about the firewall subnet that violates the policy scope.
    firewall_subnet_is_out_of_scope_violation: ?FirewallSubnetIsOutOfScopeViolation = null,

    /// The violation details for a third-party firewall's VPC endpoint subnet that
    /// was deleted.
    firewall_subnet_missing_vpc_endpoint_violation: ?FirewallSubnetMissingVPCEndpointViolation = null,

    /// Violation detail for the entries in a network ACL resource.
    invalid_network_acl_entries_violation: ?InvalidNetworkAclEntriesViolation = null,

    network_firewall_black_hole_route_detected_violation: ?NetworkFirewallBlackHoleRouteDetectedViolation = null,

    /// Violation detail for the subnet for which internet traffic hasn't been
    /// inspected.
    network_firewall_internet_traffic_not_inspected_violation: ?NetworkFirewallInternetTrafficNotInspectedViolation = null,

    /// The route configuration is invalid.
    network_firewall_invalid_route_configuration_violation: ?NetworkFirewallInvalidRouteConfigurationViolation = null,

    /// Expected routes are missing from Network Firewall.
    network_firewall_missing_expected_routes_violation: ?NetworkFirewallMissingExpectedRoutesViolation = null,

    /// Violation detail for an Network Firewall policy that indicates that a subnet
    /// is not associated with the expected Firewall Manager managed route table.
    network_firewall_missing_expected_rt_violation: ?NetworkFirewallMissingExpectedRTViolation = null,

    /// Violation detail for an Network Firewall policy that indicates that a subnet
    /// has no Firewall Manager
    /// managed firewall in its VPC.
    network_firewall_missing_firewall_violation: ?NetworkFirewallMissingFirewallViolation = null,

    /// Violation detail for an Network Firewall policy that indicates that an
    /// Availability Zone is
    /// missing the expected Firewall Manager managed subnet.
    network_firewall_missing_subnet_violation: ?NetworkFirewallMissingSubnetViolation = null,

    /// Violation detail for an Network Firewall policy that indicates that a
    /// firewall policy
    /// in an individual account has been modified in a way that makes it
    /// noncompliant.
    /// For example, the individual account owner might have deleted a rule group,
    /// changed the priority of a stateless rule group, or changed a policy default
    /// action.
    network_firewall_policy_modified_violation: ?NetworkFirewallPolicyModifiedViolation = null,

    /// There's an unexpected firewall route.
    network_firewall_unexpected_firewall_routes_violation: ?NetworkFirewallUnexpectedFirewallRoutesViolation = null,

    /// There's an unexpected gateway route.
    network_firewall_unexpected_gateway_routes_violation: ?NetworkFirewallUnexpectedGatewayRoutesViolation = null,

    /// A list of possible remediation action lists. Each individual possible
    /// remediation action is a list of individual remediation actions.
    possible_remediation_actions: ?PossibleRemediationActions = null,

    /// Contains details about the route endpoint that violates the policy scope.
    route_has_out_of_scope_endpoint_violation: ?RouteHasOutOfScopeEndpointViolation = null,

    /// The violation details for a third-party firewall that has the Firewall
    /// Manager managed route table that was associated with the third-party
    /// firewall has been deleted.
    third_party_firewall_missing_expected_route_table_violation: ?ThirdPartyFirewallMissingExpectedRouteTableViolation = null,

    /// The violation details for a third-party firewall that's been deleted.
    third_party_firewall_missing_firewall_violation: ?ThirdPartyFirewallMissingFirewallViolation = null,

    /// The violation details for a third-party firewall's subnet that's been
    /// deleted.
    third_party_firewall_missing_subnet_violation: ?ThirdPartyFirewallMissingSubnetViolation = null,

    /// The violation details for a web ACL whose configuration is incompatible with
    /// the Firewall Manager policy.
    web_acl_has_incompatible_configuration_violation: ?WebACLHasIncompatibleConfigurationViolation = null,

    /// The violation details for a web ACL that's associated with at least one
    /// resource that's out of scope of the Firewall Manager policy.
    web_acl_has_out_of_scope_resources_violation: ?WebACLHasOutOfScopeResourcesViolation = null,

    pub const json_field_names = .{
        .aws_ec_2_instance_violation = "AwsEc2InstanceViolation",
        .aws_ec_2_network_interface_violation = "AwsEc2NetworkInterfaceViolation",
        .aws_vpc_security_group_violation = "AwsVPCSecurityGroupViolation",
        .dns_duplicate_rule_group_violation = "DnsDuplicateRuleGroupViolation",
        .dns_rule_group_limit_exceeded_violation = "DnsRuleGroupLimitExceededViolation",
        .dns_rule_group_priority_conflict_violation = "DnsRuleGroupPriorityConflictViolation",
        .firewall_subnet_is_out_of_scope_violation = "FirewallSubnetIsOutOfScopeViolation",
        .firewall_subnet_missing_vpc_endpoint_violation = "FirewallSubnetMissingVPCEndpointViolation",
        .invalid_network_acl_entries_violation = "InvalidNetworkAclEntriesViolation",
        .network_firewall_black_hole_route_detected_violation = "NetworkFirewallBlackHoleRouteDetectedViolation",
        .network_firewall_internet_traffic_not_inspected_violation = "NetworkFirewallInternetTrafficNotInspectedViolation",
        .network_firewall_invalid_route_configuration_violation = "NetworkFirewallInvalidRouteConfigurationViolation",
        .network_firewall_missing_expected_routes_violation = "NetworkFirewallMissingExpectedRoutesViolation",
        .network_firewall_missing_expected_rt_violation = "NetworkFirewallMissingExpectedRTViolation",
        .network_firewall_missing_firewall_violation = "NetworkFirewallMissingFirewallViolation",
        .network_firewall_missing_subnet_violation = "NetworkFirewallMissingSubnetViolation",
        .network_firewall_policy_modified_violation = "NetworkFirewallPolicyModifiedViolation",
        .network_firewall_unexpected_firewall_routes_violation = "NetworkFirewallUnexpectedFirewallRoutesViolation",
        .network_firewall_unexpected_gateway_routes_violation = "NetworkFirewallUnexpectedGatewayRoutesViolation",
        .possible_remediation_actions = "PossibleRemediationActions",
        .route_has_out_of_scope_endpoint_violation = "RouteHasOutOfScopeEndpointViolation",
        .third_party_firewall_missing_expected_route_table_violation = "ThirdPartyFirewallMissingExpectedRouteTableViolation",
        .third_party_firewall_missing_firewall_violation = "ThirdPartyFirewallMissingFirewallViolation",
        .third_party_firewall_missing_subnet_violation = "ThirdPartyFirewallMissingSubnetViolation",
        .web_acl_has_incompatible_configuration_violation = "WebACLHasIncompatibleConfigurationViolation",
        .web_acl_has_out_of_scope_resources_violation = "WebACLHasOutOfScopeResourcesViolation",
    };
};
