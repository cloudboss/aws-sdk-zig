const aws = @import("aws");
const std = @import("std");

const accept_network_firewall_transit_gateway_attachment = @import("accept_network_firewall_transit_gateway_attachment.zig");
const associate_availability_zones = @import("associate_availability_zones.zig");
const associate_firewall_policy = @import("associate_firewall_policy.zig");
const associate_subnets = @import("associate_subnets.zig");
const attach_rule_groups_to_proxy_configuration = @import("attach_rule_groups_to_proxy_configuration.zig");
const create_firewall = @import("create_firewall.zig");
const create_firewall_policy = @import("create_firewall_policy.zig");
const create_proxy = @import("create_proxy.zig");
const create_proxy_configuration = @import("create_proxy_configuration.zig");
const create_proxy_rule_group = @import("create_proxy_rule_group.zig");
const create_proxy_rules = @import("create_proxy_rules.zig");
const create_rule_group = @import("create_rule_group.zig");
const create_tls_inspection_configuration = @import("create_tls_inspection_configuration.zig");
const create_vpc_endpoint_association = @import("create_vpc_endpoint_association.zig");
const delete_firewall = @import("delete_firewall.zig");
const delete_firewall_policy = @import("delete_firewall_policy.zig");
const delete_network_firewall_transit_gateway_attachment = @import("delete_network_firewall_transit_gateway_attachment.zig");
const delete_proxy = @import("delete_proxy.zig");
const delete_proxy_configuration = @import("delete_proxy_configuration.zig");
const delete_proxy_rule_group = @import("delete_proxy_rule_group.zig");
const delete_proxy_rules = @import("delete_proxy_rules.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_rule_group = @import("delete_rule_group.zig");
const delete_tls_inspection_configuration = @import("delete_tls_inspection_configuration.zig");
const delete_vpc_endpoint_association = @import("delete_vpc_endpoint_association.zig");
const describe_firewall = @import("describe_firewall.zig");
const describe_firewall_metadata = @import("describe_firewall_metadata.zig");
const describe_firewall_policy = @import("describe_firewall_policy.zig");
const describe_flow_operation = @import("describe_flow_operation.zig");
const describe_logging_configuration = @import("describe_logging_configuration.zig");
const describe_proxy = @import("describe_proxy.zig");
const describe_proxy_configuration = @import("describe_proxy_configuration.zig");
const describe_proxy_rule = @import("describe_proxy_rule.zig");
const describe_proxy_rule_group = @import("describe_proxy_rule_group.zig");
const describe_resource_policy = @import("describe_resource_policy.zig");
const describe_rule_group = @import("describe_rule_group.zig");
const describe_rule_group_metadata = @import("describe_rule_group_metadata.zig");
const describe_rule_group_summary = @import("describe_rule_group_summary.zig");
const describe_tls_inspection_configuration = @import("describe_tls_inspection_configuration.zig");
const describe_vpc_endpoint_association = @import("describe_vpc_endpoint_association.zig");
const detach_rule_groups_from_proxy_configuration = @import("detach_rule_groups_from_proxy_configuration.zig");
const disassociate_availability_zones = @import("disassociate_availability_zones.zig");
const disassociate_subnets = @import("disassociate_subnets.zig");
const get_analysis_report_results = @import("get_analysis_report_results.zig");
const list_analysis_reports = @import("list_analysis_reports.zig");
const list_firewall_policies = @import("list_firewall_policies.zig");
const list_firewalls = @import("list_firewalls.zig");
const list_flow_operation_results = @import("list_flow_operation_results.zig");
const list_flow_operations = @import("list_flow_operations.zig");
const list_proxies = @import("list_proxies.zig");
const list_proxy_configurations = @import("list_proxy_configurations.zig");
const list_proxy_rule_groups = @import("list_proxy_rule_groups.zig");
const list_rule_groups = @import("list_rule_groups.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_tls_inspection_configurations = @import("list_tls_inspection_configurations.zig");
const list_vpc_endpoint_associations = @import("list_vpc_endpoint_associations.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const reject_network_firewall_transit_gateway_attachment = @import("reject_network_firewall_transit_gateway_attachment.zig");
const start_analysis_report = @import("start_analysis_report.zig");
const start_flow_capture = @import("start_flow_capture.zig");
const start_flow_flush = @import("start_flow_flush.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_availability_zone_change_protection = @import("update_availability_zone_change_protection.zig");
const update_firewall_analysis_settings = @import("update_firewall_analysis_settings.zig");
const update_firewall_delete_protection = @import("update_firewall_delete_protection.zig");
const update_firewall_description = @import("update_firewall_description.zig");
const update_firewall_encryption_configuration = @import("update_firewall_encryption_configuration.zig");
const update_firewall_policy = @import("update_firewall_policy.zig");
const update_firewall_policy_change_protection = @import("update_firewall_policy_change_protection.zig");
const update_logging_configuration = @import("update_logging_configuration.zig");
const update_proxy = @import("update_proxy.zig");
const update_proxy_configuration = @import("update_proxy_configuration.zig");
const update_proxy_rule = @import("update_proxy_rule.zig");
const update_proxy_rule_group_priorities = @import("update_proxy_rule_group_priorities.zig");
const update_proxy_rule_priorities = @import("update_proxy_rule_priorities.zig");
const update_rule_group = @import("update_rule_group.zig");
const update_subnet_change_protection = @import("update_subnet_change_protection.zig");
const update_tls_inspection_configuration = @import("update_tls_inspection_configuration.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Network Firewall";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Accepts a transit gateway attachment request for Network Firewall. When you
    /// accept the attachment request, Network Firewall creates the necessary
    /// routing components to enable traffic flow between the transit gateway and
    /// firewall endpoints.
    ///
    /// You must accept a transit gateway attachment to complete the creation of a
    /// transit gateway-attached firewall, unless auto-accept is enabled on the
    /// transit gateway. After acceptance, use DescribeFirewall to verify the
    /// firewall status.
    ///
    /// To reject an attachment instead of accepting it, use
    /// RejectNetworkFirewallTransitGatewayAttachment.
    ///
    /// It can take several minutes for the attachment acceptance to complete and
    /// the firewall to become available.
    pub fn acceptNetworkFirewallTransitGatewayAttachment(self: *Self, allocator: std.mem.Allocator, input: accept_network_firewall_transit_gateway_attachment.AcceptNetworkFirewallTransitGatewayAttachmentInput, options: accept_network_firewall_transit_gateway_attachment.Options) !accept_network_firewall_transit_gateway_attachment.AcceptNetworkFirewallTransitGatewayAttachmentOutput {
        return accept_network_firewall_transit_gateway_attachment.execute(self, allocator, input, options);
    }

    /// Associates the specified Availability Zones with a transit gateway-attached
    /// firewall. For each Availability Zone, Network Firewall creates a firewall
    /// endpoint to process traffic. You can specify one or more Availability Zones
    /// where you want to deploy the firewall.
    ///
    /// After adding Availability Zones, you must update your transit gateway route
    /// tables to direct traffic through the new firewall endpoints. Use
    /// DescribeFirewall to monitor the status of the new endpoints.
    pub fn associateAvailabilityZones(self: *Self, allocator: std.mem.Allocator, input: associate_availability_zones.AssociateAvailabilityZonesInput, options: associate_availability_zones.Options) !associate_availability_zones.AssociateAvailabilityZonesOutput {
        return associate_availability_zones.execute(self, allocator, input, options);
    }

    /// Associates a FirewallPolicy to a Firewall.
    ///
    /// A firewall policy defines how to monitor and manage your VPC network
    /// traffic, using a
    /// collection of inspection rule groups and other settings. Each firewall
    /// requires one
    /// firewall policy association, and you can use the same firewall policy for
    /// multiple
    /// firewalls.
    pub fn associateFirewallPolicy(self: *Self, allocator: std.mem.Allocator, input: associate_firewall_policy.AssociateFirewallPolicyInput, options: associate_firewall_policy.Options) !associate_firewall_policy.AssociateFirewallPolicyOutput {
        return associate_firewall_policy.execute(self, allocator, input, options);
    }

    /// Associates the specified subnets in the Amazon VPC to the firewall. You can
    /// specify one
    /// subnet for each of the Availability Zones that the VPC spans.
    ///
    /// This request creates an Network Firewall firewall endpoint in each of the
    /// subnets. To
    /// enable the firewall's protections, you must also modify the VPC's route
    /// tables for each
    /// subnet's Availability Zone, to redirect the traffic that's coming into and
    /// going out of the
    /// zone through the firewall endpoint.
    pub fn associateSubnets(self: *Self, allocator: std.mem.Allocator, input: associate_subnets.AssociateSubnetsInput, options: associate_subnets.Options) !associate_subnets.AssociateSubnetsOutput {
        return associate_subnets.execute(self, allocator, input, options);
    }

    /// Attaches ProxyRuleGroup resources to a ProxyConfiguration
    ///
    /// A Proxy Configuration defines the monitoring and protection behavior for a
    /// Proxy. The details of the behavior are defined in the rule groups that you
    /// add to your configuration.
    pub fn attachRuleGroupsToProxyConfiguration(self: *Self, allocator: std.mem.Allocator, input: attach_rule_groups_to_proxy_configuration.AttachRuleGroupsToProxyConfigurationInput, options: attach_rule_groups_to_proxy_configuration.Options) !attach_rule_groups_to_proxy_configuration.AttachRuleGroupsToProxyConfigurationOutput {
        return attach_rule_groups_to_proxy_configuration.execute(self, allocator, input, options);
    }

    /// Creates an Network Firewall Firewall and accompanying FirewallStatus for a
    /// VPC.
    ///
    /// The firewall defines the configuration settings for an Network Firewall
    /// firewall. The settings that you can define at creation include the firewall
    /// policy, the subnets in your VPC to use for the firewall endpoints, and any
    /// tags that are attached to the firewall Amazon Web Services resource.
    ///
    /// After you create a firewall, you can provide additional settings, like the
    /// logging configuration.
    ///
    /// To update the settings for a firewall, you use the operations that apply to
    /// the settings
    /// themselves, for example UpdateLoggingConfiguration, AssociateSubnets, and
    /// UpdateFirewallDeleteProtection.
    ///
    /// To manage a firewall's tags, use the standard Amazon Web Services resource
    /// tagging operations, ListTagsForResource, TagResource, and UntagResource.
    ///
    /// To retrieve information about firewalls, use ListFirewalls and
    /// DescribeFirewall.
    ///
    /// To generate a report on the last 30 days of traffic monitored by a firewall,
    /// use StartAnalysisReport.
    pub fn createFirewall(self: *Self, allocator: std.mem.Allocator, input: create_firewall.CreateFirewallInput, options: create_firewall.Options) !create_firewall.CreateFirewallOutput {
        return create_firewall.execute(self, allocator, input, options);
    }

    /// Creates the firewall policy for the firewall according to the
    /// specifications.
    ///
    /// An Network Firewall firewall policy defines the behavior of a firewall, in a
    /// collection of
    /// stateless and stateful rule groups and other settings. You can use one
    /// firewall policy for
    /// multiple firewalls.
    pub fn createFirewallPolicy(self: *Self, allocator: std.mem.Allocator, input: create_firewall_policy.CreateFirewallPolicyInput, options: create_firewall_policy.Options) !create_firewall_policy.CreateFirewallPolicyOutput {
        return create_firewall_policy.execute(self, allocator, input, options);
    }

    /// Creates an Network Firewall Proxy
    ///
    /// Attaches a Proxy configuration to a NAT Gateway.
    ///
    /// To manage a proxy's tags, use the standard Amazon Web Services resource
    /// tagging operations, ListTagsForResource, TagResource, and UntagResource.
    ///
    /// To retrieve information about proxies, use ListProxies and DescribeProxy.
    pub fn createProxy(self: *Self, allocator: std.mem.Allocator, input: create_proxy.CreateProxyInput, options: create_proxy.Options) !create_proxy.CreateProxyOutput {
        return create_proxy.execute(self, allocator, input, options);
    }

    /// Creates an Network Firewall ProxyConfiguration
    ///
    /// A Proxy Configuration defines the monitoring and protection behavior for a
    /// Proxy. The details of the behavior are defined in the rule groups that you
    /// add to your configuration.
    ///
    /// To manage a proxy configuration's tags, use the standard Amazon Web Services
    /// resource tagging operations, ListTagsForResource, TagResource, and
    /// UntagResource.
    ///
    /// To retrieve information about proxies, use ListProxyConfigurations and
    /// DescribeProxyConfiguration.
    pub fn createProxyConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_proxy_configuration.CreateProxyConfigurationInput, options: create_proxy_configuration.Options) !create_proxy_configuration.CreateProxyConfigurationOutput {
        return create_proxy_configuration.execute(self, allocator, input, options);
    }

    /// Creates an Network Firewall ProxyRuleGroup
    ///
    /// Collections of related proxy filtering rules. Rule groups help you manage
    /// and reuse sets of rules across multiple proxy configurations.
    ///
    /// To manage a proxy rule group's tags, use the standard Amazon Web Services
    /// resource tagging operations, ListTagsForResource, TagResource, and
    /// UntagResource.
    ///
    /// To retrieve information about proxy rule groups, use ListProxyRuleGroups and
    /// DescribeProxyRuleGroup.
    ///
    /// To retrieve information about individual proxy rules, use
    /// DescribeProxyRuleGroup and DescribeProxyRule.
    pub fn createProxyRuleGroup(self: *Self, allocator: std.mem.Allocator, input: create_proxy_rule_group.CreateProxyRuleGroupInput, options: create_proxy_rule_group.Options) !create_proxy_rule_group.CreateProxyRuleGroupOutput {
        return create_proxy_rule_group.execute(self, allocator, input, options);
    }

    /// Creates Network Firewall ProxyRule resources.
    ///
    /// Attaches new proxy rule(s) to an existing proxy rule group.
    ///
    /// To retrieve information about individual proxy rules, use
    /// DescribeProxyRuleGroup and DescribeProxyRule.
    pub fn createProxyRules(self: *Self, allocator: std.mem.Allocator, input: create_proxy_rules.CreateProxyRulesInput, options: create_proxy_rules.Options) !create_proxy_rules.CreateProxyRulesOutput {
        return create_proxy_rules.execute(self, allocator, input, options);
    }

    /// Creates the specified stateless or stateful rule group, which includes the
    /// rules for
    /// network traffic inspection, a capacity setting, and tags.
    ///
    /// You provide your rule group specification in your request using either
    /// `RuleGroup` or `Rules`.
    pub fn createRuleGroup(self: *Self, allocator: std.mem.Allocator, input: create_rule_group.CreateRuleGroupInput, options: create_rule_group.Options) !create_rule_group.CreateRuleGroupOutput {
        return create_rule_group.execute(self, allocator, input, options);
    }

    /// Creates an Network Firewall TLS inspection configuration. Network Firewall
    /// uses TLS inspection configurations to decrypt your firewall's inbound and
    /// outbound SSL/TLS traffic. After decryption, Network Firewall inspects the
    /// traffic according to your firewall policy's stateful rules, and then
    /// re-encrypts it before sending it to its destination. You can enable
    /// inspection of your firewall's inbound traffic, outbound traffic, or both. To
    /// use TLS inspection with your firewall, you must first import or provision
    /// certificates using ACM, create a TLS inspection configuration, add that
    /// configuration to a new firewall policy, and then associate that policy with
    /// your firewall.
    ///
    /// To update the settings for a TLS inspection configuration, use
    /// UpdateTLSInspectionConfiguration.
    ///
    /// To manage a TLS inspection configuration's tags, use the standard Amazon Web
    /// Services resource tagging operations, ListTagsForResource, TagResource, and
    /// UntagResource.
    ///
    /// To retrieve information about TLS inspection configurations, use
    /// ListTLSInspectionConfigurations and DescribeTLSInspectionConfiguration.
    ///
    /// For more information about TLS inspection configurations, see [Inspecting
    /// SSL/TLS traffic with TLS
    /// inspection
    /// configurations](https://docs.aws.amazon.com/network-firewall/latest/developerguide/tls-inspection.html) in the *Network Firewall Developer Guide*.
    pub fn createTlsInspectionConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_tls_inspection_configuration.CreateTLSInspectionConfigurationInput, options: create_tls_inspection_configuration.Options) !create_tls_inspection_configuration.CreateTLSInspectionConfigurationOutput {
        return create_tls_inspection_configuration.execute(self, allocator, input, options);
    }

    /// Creates a firewall endpoint for an Network Firewall firewall. This type of
    /// firewall endpoint is independent of the firewall endpoints that you specify
    /// in the `Firewall` itself, and you define it in addition to those endpoints
    /// after the firewall has been created. You can define a VPC endpoint
    /// association using a different VPC than the one you used in the firewall
    /// specifications.
    pub fn createVpcEndpointAssociation(self: *Self, allocator: std.mem.Allocator, input: create_vpc_endpoint_association.CreateVpcEndpointAssociationInput, options: create_vpc_endpoint_association.Options) !create_vpc_endpoint_association.CreateVpcEndpointAssociationOutput {
        return create_vpc_endpoint_association.execute(self, allocator, input, options);
    }

    /// Deletes the specified Firewall and its FirewallStatus.
    /// This operation requires the firewall's `DeleteProtection` flag to be
    /// `FALSE`. You can't revert this operation.
    ///
    /// You can check whether a firewall is
    /// in use by reviewing the route tables for the Availability Zones where you
    /// have
    /// firewall subnet mappings. Retrieve the subnet mappings by calling
    /// DescribeFirewall.
    /// You define and update the route tables through Amazon VPC. As needed, update
    /// the route tables for the
    /// zones to remove the firewall endpoints. When the route tables no longer use
    /// the firewall endpoints,
    /// you can remove the firewall safely.
    ///
    /// To delete a firewall, remove the delete protection if you need to using
    /// UpdateFirewallDeleteProtection,
    /// then delete the firewall by calling DeleteFirewall.
    pub fn deleteFirewall(self: *Self, allocator: std.mem.Allocator, input: delete_firewall.DeleteFirewallInput, options: delete_firewall.Options) !delete_firewall.DeleteFirewallOutput {
        return delete_firewall.execute(self, allocator, input, options);
    }

    /// Deletes the specified FirewallPolicy.
    pub fn deleteFirewallPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_firewall_policy.DeleteFirewallPolicyInput, options: delete_firewall_policy.Options) !delete_firewall_policy.DeleteFirewallPolicyOutput {
        return delete_firewall_policy.execute(self, allocator, input, options);
    }

    /// Deletes a transit gateway attachment from a Network Firewall. Either the
    /// firewall owner or the transit gateway owner can delete the attachment.
    ///
    /// After you delete a transit gateway attachment, traffic will no longer flow
    /// through the firewall endpoints.
    ///
    /// After you initiate the delete operation, use DescribeFirewall to monitor the
    /// deletion status.
    pub fn deleteNetworkFirewallTransitGatewayAttachment(self: *Self, allocator: std.mem.Allocator, input: delete_network_firewall_transit_gateway_attachment.DeleteNetworkFirewallTransitGatewayAttachmentInput, options: delete_network_firewall_transit_gateway_attachment.Options) !delete_network_firewall_transit_gateway_attachment.DeleteNetworkFirewallTransitGatewayAttachmentOutput {
        return delete_network_firewall_transit_gateway_attachment.execute(self, allocator, input, options);
    }

    /// Deletes the specified Proxy.
    ///
    /// Detaches a Proxy configuration from a NAT Gateway.
    pub fn deleteProxy(self: *Self, allocator: std.mem.Allocator, input: delete_proxy.DeleteProxyInput, options: delete_proxy.Options) !delete_proxy.DeleteProxyOutput {
        return delete_proxy.execute(self, allocator, input, options);
    }

    /// Deletes the specified ProxyConfiguration.
    pub fn deleteProxyConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_proxy_configuration.DeleteProxyConfigurationInput, options: delete_proxy_configuration.Options) !delete_proxy_configuration.DeleteProxyConfigurationOutput {
        return delete_proxy_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the specified ProxyRuleGroup.
    pub fn deleteProxyRuleGroup(self: *Self, allocator: std.mem.Allocator, input: delete_proxy_rule_group.DeleteProxyRuleGroupInput, options: delete_proxy_rule_group.Options) !delete_proxy_rule_group.DeleteProxyRuleGroupOutput {
        return delete_proxy_rule_group.execute(self, allocator, input, options);
    }

    /// Deletes the specified ProxyRule(s). currently attached to a ProxyRuleGroup
    pub fn deleteProxyRules(self: *Self, allocator: std.mem.Allocator, input: delete_proxy_rules.DeleteProxyRulesInput, options: delete_proxy_rules.Options) !delete_proxy_rules.DeleteProxyRulesOutput {
        return delete_proxy_rules.execute(self, allocator, input, options);
    }

    /// Deletes a resource policy that you created in a PutResourcePolicy request.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: delete_resource_policy.Options) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Deletes the specified RuleGroup.
    pub fn deleteRuleGroup(self: *Self, allocator: std.mem.Allocator, input: delete_rule_group.DeleteRuleGroupInput, options: delete_rule_group.Options) !delete_rule_group.DeleteRuleGroupOutput {
        return delete_rule_group.execute(self, allocator, input, options);
    }

    /// Deletes the specified TLSInspectionConfiguration.
    pub fn deleteTlsInspectionConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_tls_inspection_configuration.DeleteTLSInspectionConfigurationInput, options: delete_tls_inspection_configuration.Options) !delete_tls_inspection_configuration.DeleteTLSInspectionConfigurationOutput {
        return delete_tls_inspection_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the specified VpcEndpointAssociation.
    ///
    /// You can check whether an endpoint association is
    /// in use by reviewing the route tables for the Availability Zones where you
    /// have the endpoint subnet mapping.
    /// You can retrieve the subnet mapping by calling
    /// DescribeVpcEndpointAssociation.
    /// You define and update the route tables through Amazon VPC. As needed, update
    /// the route tables for the
    /// Availability Zone to remove the firewall endpoint for the association. When
    /// the route tables no longer use the firewall endpoint,
    /// you can remove the endpoint association safely.
    pub fn deleteVpcEndpointAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_vpc_endpoint_association.DeleteVpcEndpointAssociationInput, options: delete_vpc_endpoint_association.Options) !delete_vpc_endpoint_association.DeleteVpcEndpointAssociationOutput {
        return delete_vpc_endpoint_association.execute(self, allocator, input, options);
    }

    /// Returns the data objects for the specified firewall.
    pub fn describeFirewall(self: *Self, allocator: std.mem.Allocator, input: describe_firewall.DescribeFirewallInput, options: describe_firewall.Options) !describe_firewall.DescribeFirewallOutput {
        return describe_firewall.execute(self, allocator, input, options);
    }

    /// Returns the high-level information about a firewall, including the
    /// Availability Zones where the Firewall is
    /// currently in use.
    pub fn describeFirewallMetadata(self: *Self, allocator: std.mem.Allocator, input: describe_firewall_metadata.DescribeFirewallMetadataInput, options: describe_firewall_metadata.Options) !describe_firewall_metadata.DescribeFirewallMetadataOutput {
        return describe_firewall_metadata.execute(self, allocator, input, options);
    }

    /// Returns the data objects for the specified firewall policy.
    pub fn describeFirewallPolicy(self: *Self, allocator: std.mem.Allocator, input: describe_firewall_policy.DescribeFirewallPolicyInput, options: describe_firewall_policy.Options) !describe_firewall_policy.DescribeFirewallPolicyOutput {
        return describe_firewall_policy.execute(self, allocator, input, options);
    }

    /// Returns key information about a specific flow operation.
    pub fn describeFlowOperation(self: *Self, allocator: std.mem.Allocator, input: describe_flow_operation.DescribeFlowOperationInput, options: describe_flow_operation.Options) !describe_flow_operation.DescribeFlowOperationOutput {
        return describe_flow_operation.execute(self, allocator, input, options);
    }

    /// Returns the logging configuration for the specified firewall.
    pub fn describeLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_logging_configuration.DescribeLoggingConfigurationInput, options: describe_logging_configuration.Options) !describe_logging_configuration.DescribeLoggingConfigurationOutput {
        return describe_logging_configuration.execute(self, allocator, input, options);
    }

    /// Returns the data objects for the specified proxy.
    pub fn describeProxy(self: *Self, allocator: std.mem.Allocator, input: describe_proxy.DescribeProxyInput, options: describe_proxy.Options) !describe_proxy.DescribeProxyOutput {
        return describe_proxy.execute(self, allocator, input, options);
    }

    /// Returns the data objects for the specified proxy configuration.
    pub fn describeProxyConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_proxy_configuration.DescribeProxyConfigurationInput, options: describe_proxy_configuration.Options) !describe_proxy_configuration.DescribeProxyConfigurationOutput {
        return describe_proxy_configuration.execute(self, allocator, input, options);
    }

    /// Returns the data objects for the specified proxy configuration for the
    /// specified proxy rule group.
    pub fn describeProxyRule(self: *Self, allocator: std.mem.Allocator, input: describe_proxy_rule.DescribeProxyRuleInput, options: describe_proxy_rule.Options) !describe_proxy_rule.DescribeProxyRuleOutput {
        return describe_proxy_rule.execute(self, allocator, input, options);
    }

    /// Returns the data objects for the specified proxy rule group.
    pub fn describeProxyRuleGroup(self: *Self, allocator: std.mem.Allocator, input: describe_proxy_rule_group.DescribeProxyRuleGroupInput, options: describe_proxy_rule_group.Options) !describe_proxy_rule_group.DescribeProxyRuleGroupOutput {
        return describe_proxy_rule_group.execute(self, allocator, input, options);
    }

    /// Retrieves a resource policy that you created in a PutResourcePolicy request.
    pub fn describeResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: describe_resource_policy.DescribeResourcePolicyInput, options: describe_resource_policy.Options) !describe_resource_policy.DescribeResourcePolicyOutput {
        return describe_resource_policy.execute(self, allocator, input, options);
    }

    /// Returns the data objects for the specified rule group.
    pub fn describeRuleGroup(self: *Self, allocator: std.mem.Allocator, input: describe_rule_group.DescribeRuleGroupInput, options: describe_rule_group.Options) !describe_rule_group.DescribeRuleGroupOutput {
        return describe_rule_group.execute(self, allocator, input, options);
    }

    /// High-level information about a rule group, returned by operations like
    /// create and describe.
    /// You can use the information provided in the metadata to retrieve and manage
    /// a rule group.
    /// You can retrieve all objects for a rule group by calling DescribeRuleGroup.
    pub fn describeRuleGroupMetadata(self: *Self, allocator: std.mem.Allocator, input: describe_rule_group_metadata.DescribeRuleGroupMetadataInput, options: describe_rule_group_metadata.Options) !describe_rule_group_metadata.DescribeRuleGroupMetadataOutput {
        return describe_rule_group_metadata.execute(self, allocator, input, options);
    }

    /// Returns detailed information for a stateful rule group.
    ///
    /// For active threat defense Amazon Web Services managed rule groups, this
    /// operation provides insight into the protections enabled by the rule group,
    /// based on Suricata rule metadata fields. Summaries are available for rule
    /// groups you manage and for active threat defense Amazon Web Services managed
    /// rule groups.
    ///
    /// To modify how threat information appears in summaries, use the
    /// `SummaryConfiguration` parameter in UpdateRuleGroup.
    pub fn describeRuleGroupSummary(self: *Self, allocator: std.mem.Allocator, input: describe_rule_group_summary.DescribeRuleGroupSummaryInput, options: describe_rule_group_summary.Options) !describe_rule_group_summary.DescribeRuleGroupSummaryOutput {
        return describe_rule_group_summary.execute(self, allocator, input, options);
    }

    /// Returns the data objects for the specified TLS inspection configuration.
    pub fn describeTlsInspectionConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_tls_inspection_configuration.DescribeTLSInspectionConfigurationInput, options: describe_tls_inspection_configuration.Options) !describe_tls_inspection_configuration.DescribeTLSInspectionConfigurationOutput {
        return describe_tls_inspection_configuration.execute(self, allocator, input, options);
    }

    /// Returns the data object for the specified VPC endpoint association.
    pub fn describeVpcEndpointAssociation(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_endpoint_association.DescribeVpcEndpointAssociationInput, options: describe_vpc_endpoint_association.Options) !describe_vpc_endpoint_association.DescribeVpcEndpointAssociationOutput {
        return describe_vpc_endpoint_association.execute(self, allocator, input, options);
    }

    /// Detaches ProxyRuleGroup resources from a ProxyConfiguration
    ///
    /// A Proxy Configuration defines the monitoring and protection behavior for a
    /// Proxy. The details of the behavior are defined in the rule groups that you
    /// add to your configuration.
    pub fn detachRuleGroupsFromProxyConfiguration(self: *Self, allocator: std.mem.Allocator, input: detach_rule_groups_from_proxy_configuration.DetachRuleGroupsFromProxyConfigurationInput, options: detach_rule_groups_from_proxy_configuration.Options) !detach_rule_groups_from_proxy_configuration.DetachRuleGroupsFromProxyConfigurationOutput {
        return detach_rule_groups_from_proxy_configuration.execute(self, allocator, input, options);
    }

    /// Removes the specified Availability Zone associations from a transit
    /// gateway-attached firewall. This removes the firewall endpoints from these
    /// Availability Zones and stops traffic filtering in those zones. Before
    /// removing an Availability Zone, ensure you've updated your transit gateway
    /// route tables to redirect traffic appropriately.
    ///
    /// If `AvailabilityZoneChangeProtection` is enabled, you must first disable it
    /// using UpdateAvailabilityZoneChangeProtection.
    ///
    /// To verify the status of your Availability Zone changes, use
    /// DescribeFirewall.
    pub fn disassociateAvailabilityZones(self: *Self, allocator: std.mem.Allocator, input: disassociate_availability_zones.DisassociateAvailabilityZonesInput, options: disassociate_availability_zones.Options) !disassociate_availability_zones.DisassociateAvailabilityZonesOutput {
        return disassociate_availability_zones.execute(self, allocator, input, options);
    }

    /// Removes the specified subnet associations from the firewall. This removes
    /// the
    /// firewall endpoints from the subnets and removes any network filtering
    /// protections that the endpoints
    /// were providing.
    pub fn disassociateSubnets(self: *Self, allocator: std.mem.Allocator, input: disassociate_subnets.DisassociateSubnetsInput, options: disassociate_subnets.Options) !disassociate_subnets.DisassociateSubnetsOutput {
        return disassociate_subnets.execute(self, allocator, input, options);
    }

    /// The results of a `COMPLETED` analysis report generated with
    /// StartAnalysisReport.
    ///
    /// For more information, see AnalysisTypeReportResult.
    pub fn getAnalysisReportResults(self: *Self, allocator: std.mem.Allocator, input: get_analysis_report_results.GetAnalysisReportResultsInput, options: get_analysis_report_results.Options) !get_analysis_report_results.GetAnalysisReportResultsOutput {
        return get_analysis_report_results.execute(self, allocator, input, options);
    }

    /// Returns a list of all traffic analysis reports generated within the last 30
    /// days.
    pub fn listAnalysisReports(self: *Self, allocator: std.mem.Allocator, input: list_analysis_reports.ListAnalysisReportsInput, options: list_analysis_reports.Options) !list_analysis_reports.ListAnalysisReportsOutput {
        return list_analysis_reports.execute(self, allocator, input, options);
    }

    /// Retrieves the metadata for the firewall policies that you have defined.
    /// Depending on
    /// your setting for max results and the number of firewall policies, a single
    /// call might not
    /// return the full list.
    pub fn listFirewallPolicies(self: *Self, allocator: std.mem.Allocator, input: list_firewall_policies.ListFirewallPoliciesInput, options: list_firewall_policies.Options) !list_firewall_policies.ListFirewallPoliciesOutput {
        return list_firewall_policies.execute(self, allocator, input, options);
    }

    /// Retrieves the metadata for the firewalls that you have defined. If you
    /// provide VPC
    /// identifiers in your request, this returns only the firewalls for those VPCs.
    ///
    /// Depending on your setting for max results and the number of firewalls, a
    /// single call
    /// might not return the full list.
    pub fn listFirewalls(self: *Self, allocator: std.mem.Allocator, input: list_firewalls.ListFirewallsInput, options: list_firewalls.Options) !list_firewalls.ListFirewallsOutput {
        return list_firewalls.execute(self, allocator, input, options);
    }

    /// Returns the results of a specific flow operation.
    ///
    /// Flow operations let you manage the flows tracked in the flow table, also
    /// known as the firewall table.
    ///
    /// A flow is network traffic that is monitored by a firewall, either by
    /// stateful or stateless rules.
    /// For traffic to be considered part of a flow, it must share Destination,
    /// DestinationPort, Direction, Protocol, Source, and SourcePort.
    pub fn listFlowOperationResults(self: *Self, allocator: std.mem.Allocator, input: list_flow_operation_results.ListFlowOperationResultsInput, options: list_flow_operation_results.Options) !list_flow_operation_results.ListFlowOperationResultsOutput {
        return list_flow_operation_results.execute(self, allocator, input, options);
    }

    /// Returns a list of all flow operations ran in a specific firewall.
    /// You can optionally narrow the request scope by specifying the operation type
    /// or Availability Zone associated with a firewall's flow operations.
    ///
    /// Flow operations let you manage the flows tracked in the flow table, also
    /// known as the firewall table.
    ///
    /// A flow is network traffic that is monitored by a firewall, either by
    /// stateful or stateless rules.
    /// For traffic to be considered part of a flow, it must share Destination,
    /// DestinationPort, Direction, Protocol, Source, and SourcePort.
    pub fn listFlowOperations(self: *Self, allocator: std.mem.Allocator, input: list_flow_operations.ListFlowOperationsInput, options: list_flow_operations.Options) !list_flow_operations.ListFlowOperationsOutput {
        return list_flow_operations.execute(self, allocator, input, options);
    }

    /// Retrieves the metadata for the proxies that you have defined. Depending on
    /// your setting for max results and the number of proxies, a single call might
    /// not
    /// return the full list.
    pub fn listProxies(self: *Self, allocator: std.mem.Allocator, input: list_proxies.ListProxiesInput, options: list_proxies.Options) !list_proxies.ListProxiesOutput {
        return list_proxies.execute(self, allocator, input, options);
    }

    /// Retrieves the metadata for the proxy configuration that you have defined.
    /// Depending on
    /// your setting for max results and the number of proxy configurations, a
    /// single call might not
    /// return the full list.
    pub fn listProxyConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_proxy_configurations.ListProxyConfigurationsInput, options: list_proxy_configurations.Options) !list_proxy_configurations.ListProxyConfigurationsOutput {
        return list_proxy_configurations.execute(self, allocator, input, options);
    }

    /// Retrieves the metadata for the proxy rule groups that you have defined.
    /// Depending on
    /// your setting for max results and the number of proxy rule groups, a single
    /// call might not
    /// return the full list.
    pub fn listProxyRuleGroups(self: *Self, allocator: std.mem.Allocator, input: list_proxy_rule_groups.ListProxyRuleGroupsInput, options: list_proxy_rule_groups.Options) !list_proxy_rule_groups.ListProxyRuleGroupsOutput {
        return list_proxy_rule_groups.execute(self, allocator, input, options);
    }

    /// Retrieves the metadata for the rule groups that you have defined. Depending
    /// on your
    /// setting for max results and the number of rule groups, a single call might
    /// not return the
    /// full list.
    pub fn listRuleGroups(self: *Self, allocator: std.mem.Allocator, input: list_rule_groups.ListRuleGroupsInput, options: list_rule_groups.Options) !list_rule_groups.ListRuleGroupsOutput {
        return list_rule_groups.execute(self, allocator, input, options);
    }

    /// Retrieves the tags associated with the specified resource. Tags are
    /// key:value pairs that
    /// you can use to categorize and manage your resources, for purposes like
    /// billing. For
    /// example, you might set the tag key to "customer" and the value to the
    /// customer name or ID.
    /// You can specify one or more tags to add to each Amazon Web Services
    /// resource, up to 50 tags for a
    /// resource.
    ///
    /// You can tag the Amazon Web Services resources that you manage through
    /// Network Firewall: firewalls, firewall
    /// policies, and rule groups.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Retrieves the metadata for the TLS inspection configurations that you have
    /// defined. Depending on your setting for max results and the number of TLS
    /// inspection configurations, a single call might not return the full list.
    pub fn listTlsInspectionConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_tls_inspection_configurations.ListTLSInspectionConfigurationsInput, options: list_tls_inspection_configurations.Options) !list_tls_inspection_configurations.ListTLSInspectionConfigurationsOutput {
        return list_tls_inspection_configurations.execute(self, allocator, input, options);
    }

    /// Retrieves the metadata for the VPC endpoint associations that you have
    /// defined. If you specify a fireawll,
    /// this returns only the endpoint associations for that firewall.
    ///
    /// Depending on your setting for max results and the number of associations, a
    /// single call
    /// might not return the full list.
    pub fn listVpcEndpointAssociations(self: *Self, allocator: std.mem.Allocator, input: list_vpc_endpoint_associations.ListVpcEndpointAssociationsInput, options: list_vpc_endpoint_associations.Options) !list_vpc_endpoint_associations.ListVpcEndpointAssociationsOutput {
        return list_vpc_endpoint_associations.execute(self, allocator, input, options);
    }

    /// Creates or updates an IAM policy for your rule group, firewall policy, or
    /// firewall. Use this to share these resources between accounts. This operation
    /// works in conjunction with the Amazon Web Services Resource Access Manager
    /// (RAM) service to manage resource sharing for Network Firewall.
    ///
    /// For information about using sharing with Network Firewall resources, see
    /// [Sharing Network Firewall
    /// resources](https://docs.aws.amazon.com/network-firewall/latest/developerguide/sharing.html) in the *Network Firewall Developer Guide*.
    ///
    /// Use this operation to create or update a resource policy for your Network
    /// Firewall rule group, firewall policy, or firewall. In the resource policy,
    /// you specify the accounts that you want to share the Network Firewall
    /// resource with and the operations that you want the accounts to be able to
    /// perform.
    ///
    /// When you add an account in the resource policy, you then run the following
    /// Resource Access Manager (RAM) operations to access and accept the shared
    /// resource.
    ///
    /// *
    ///   [GetResourceShareInvitations](https://docs.aws.amazon.com/ram/latest/APIReference/API_GetResourceShareInvitations.html) - Returns the Amazon Resource Names (ARNs) of the resource share invitations.
    ///
    /// *
    ///   [AcceptResourceShareInvitation](https://docs.aws.amazon.com/ram/latest/APIReference/API_AcceptResourceShareInvitation.html) - Accepts the share invitation for a specified resource share.
    ///
    /// For additional information about resource sharing using RAM, see [Resource
    /// Access Manager User
    /// Guide](https://docs.aws.amazon.com/ram/latest/userguide/what-is.html).
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: put_resource_policy.Options) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Rejects a transit gateway attachment request for Network Firewall. When you
    /// reject the attachment request, Network Firewall cancels the creation of
    /// routing components between the transit gateway and firewall endpoints.
    ///
    /// Only the transit gateway owner can reject the attachment. After rejection,
    /// no traffic will flow through the firewall endpoints for this attachment.
    ///
    /// Use DescribeFirewall to monitor the rejection status. To accept the
    /// attachment instead of rejecting it, use
    /// AcceptNetworkFirewallTransitGatewayAttachment.
    ///
    /// Once rejected, you cannot reverse this action. To establish connectivity,
    /// you must create a new transit gateway-attached firewall.
    pub fn rejectNetworkFirewallTransitGatewayAttachment(self: *Self, allocator: std.mem.Allocator, input: reject_network_firewall_transit_gateway_attachment.RejectNetworkFirewallTransitGatewayAttachmentInput, options: reject_network_firewall_transit_gateway_attachment.Options) !reject_network_firewall_transit_gateway_attachment.RejectNetworkFirewallTransitGatewayAttachmentOutput {
        return reject_network_firewall_transit_gateway_attachment.execute(self, allocator, input, options);
    }

    /// Generates a traffic analysis report for the timeframe and traffic type you
    /// specify.
    ///
    /// For information on the contents of a traffic analysis report, see
    /// AnalysisReport.
    pub fn startAnalysisReport(self: *Self, allocator: std.mem.Allocator, input: start_analysis_report.StartAnalysisReportInput, options: start_analysis_report.Options) !start_analysis_report.StartAnalysisReportOutput {
        return start_analysis_report.execute(self, allocator, input, options);
    }

    /// Begins capturing the flows in a firewall, according to the filters you
    /// define.
    /// Captures are similar, but not identical to snapshots. Capture operations
    /// provide visibility into flows that are not closed and are tracked by a
    /// firewall's flow table.
    /// Unlike snapshots, captures are a time-boxed view.
    ///
    /// A flow is network traffic that is monitored by a firewall, either by
    /// stateful or stateless rules.
    /// For traffic to be considered part of a flow, it must share Destination,
    /// DestinationPort, Direction, Protocol, Source, and SourcePort.
    ///
    /// To avoid encountering operation limits, you should avoid starting captures
    /// with broad filters, like wide IP ranges.
    /// Instead, we recommend you define more specific criteria with `FlowFilters`,
    /// like narrow IP ranges, ports, or protocols.
    pub fn startFlowCapture(self: *Self, allocator: std.mem.Allocator, input: start_flow_capture.StartFlowCaptureInput, options: start_flow_capture.Options) !start_flow_capture.StartFlowCaptureOutput {
        return start_flow_capture.execute(self, allocator, input, options);
    }

    /// Begins the flushing of traffic from the firewall, according to the filters
    /// you define.
    /// When the operation starts, impacted flows are temporarily marked as timed
    /// out before the Suricata engine prunes,
    /// or flushes, the flows from the firewall table.
    ///
    /// While the flush completes, impacted flows are processed as midstream
    /// traffic. This may result in a
    /// temporary increase in midstream traffic metrics. We recommend that you
    /// double check your stream exception policy
    /// before you perform a flush operation.
    pub fn startFlowFlush(self: *Self, allocator: std.mem.Allocator, input: start_flow_flush.StartFlowFlushInput, options: start_flow_flush.Options) !start_flow_flush.StartFlowFlushOutput {
        return start_flow_flush.execute(self, allocator, input, options);
    }

    /// Adds the specified tags to the specified resource. Tags are key:value pairs
    /// that you can
    /// use to categorize and manage your resources, for purposes like billing. For
    /// example, you
    /// might set the tag key to "customer" and the value to the customer name or
    /// ID. You can
    /// specify one or more tags to add to each Amazon Web Services resource, up to
    /// 50 tags for a resource.
    ///
    /// You can tag the Amazon Web Services resources that you manage through
    /// Network Firewall: firewalls, firewall
    /// policies, and rule groups.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the tags with the specified keys from the specified resource. Tags
    /// are key:value
    /// pairs that you can use to categorize and manage your resources, for purposes
    /// like billing.
    /// For example, you might set the tag key to "customer" and the value to the
    /// customer name or
    /// ID. You can specify one or more tags to add to each Amazon Web Services
    /// resource, up to 50 tags for a
    /// resource.
    ///
    /// You can manage tags for the Amazon Web Services resources that you manage
    /// through Network Firewall:
    /// firewalls, firewall policies, and rule groups.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Modifies the `AvailabilityZoneChangeProtection` setting for a transit
    /// gateway-attached firewall. When enabled, this setting prevents accidental
    /// changes to the firewall's Availability Zone configuration. This helps
    /// protect against disrupting traffic flow in production environments.
    ///
    /// When enabled, you must disable this protection before using
    /// AssociateAvailabilityZones or DisassociateAvailabilityZones to modify the
    /// firewall's Availability Zone configuration.
    pub fn updateAvailabilityZoneChangeProtection(self: *Self, allocator: std.mem.Allocator, input: update_availability_zone_change_protection.UpdateAvailabilityZoneChangeProtectionInput, options: update_availability_zone_change_protection.Options) !update_availability_zone_change_protection.UpdateAvailabilityZoneChangeProtectionOutput {
        return update_availability_zone_change_protection.execute(self, allocator, input, options);
    }

    /// Enables specific types of firewall analysis on a specific firewall you
    /// define.
    pub fn updateFirewallAnalysisSettings(self: *Self, allocator: std.mem.Allocator, input: update_firewall_analysis_settings.UpdateFirewallAnalysisSettingsInput, options: update_firewall_analysis_settings.Options) !update_firewall_analysis_settings.UpdateFirewallAnalysisSettingsOutput {
        return update_firewall_analysis_settings.execute(self, allocator, input, options);
    }

    /// Modifies the flag, `DeleteProtection`, which indicates whether it is
    /// possible
    /// to delete the firewall. If the flag is set to `TRUE`, the firewall is
    /// protected
    /// against deletion. This setting helps protect against accidentally deleting a
    /// firewall
    /// that's in use.
    pub fn updateFirewallDeleteProtection(self: *Self, allocator: std.mem.Allocator, input: update_firewall_delete_protection.UpdateFirewallDeleteProtectionInput, options: update_firewall_delete_protection.Options) !update_firewall_delete_protection.UpdateFirewallDeleteProtectionOutput {
        return update_firewall_delete_protection.execute(self, allocator, input, options);
    }

    /// Modifies the description for the specified firewall. Use the description to
    /// help you
    /// identify the firewall when you're working with it.
    pub fn updateFirewallDescription(self: *Self, allocator: std.mem.Allocator, input: update_firewall_description.UpdateFirewallDescriptionInput, options: update_firewall_description.Options) !update_firewall_description.UpdateFirewallDescriptionOutput {
        return update_firewall_description.execute(self, allocator, input, options);
    }

    /// A complex type that contains settings for encryption of your firewall
    /// resources.
    pub fn updateFirewallEncryptionConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_firewall_encryption_configuration.UpdateFirewallEncryptionConfigurationInput, options: update_firewall_encryption_configuration.Options) !update_firewall_encryption_configuration.UpdateFirewallEncryptionConfigurationOutput {
        return update_firewall_encryption_configuration.execute(self, allocator, input, options);
    }

    /// Updates the properties of the specified firewall policy.
    pub fn updateFirewallPolicy(self: *Self, allocator: std.mem.Allocator, input: update_firewall_policy.UpdateFirewallPolicyInput, options: update_firewall_policy.Options) !update_firewall_policy.UpdateFirewallPolicyOutput {
        return update_firewall_policy.execute(self, allocator, input, options);
    }

    /// Modifies the flag, `ChangeProtection`, which indicates whether it
    /// is possible to change the firewall. If the flag is set to `TRUE`, the
    /// firewall is protected
    /// from changes. This setting helps protect against accidentally changing a
    /// firewall that's in use.
    pub fn updateFirewallPolicyChangeProtection(self: *Self, allocator: std.mem.Allocator, input: update_firewall_policy_change_protection.UpdateFirewallPolicyChangeProtectionInput, options: update_firewall_policy_change_protection.Options) !update_firewall_policy_change_protection.UpdateFirewallPolicyChangeProtectionOutput {
        return update_firewall_policy_change_protection.execute(self, allocator, input, options);
    }

    /// Sets the logging configuration for the specified firewall.
    ///
    /// To change the logging configuration, retrieve the LoggingConfiguration by
    /// calling DescribeLoggingConfiguration, then change it and provide
    /// the modified object to this update call. You must change the logging
    /// configuration one
    /// LogDestinationConfig at a time inside the retrieved LoggingConfiguration
    /// object.
    ///
    /// You can perform only one of the following actions in any call to
    /// `UpdateLoggingConfiguration`:
    ///
    /// * Create a new log destination object by adding a single
    /// `LogDestinationConfig` array element to
    /// `LogDestinationConfigs`.
    ///
    /// * Delete a log destination object by removing a single
    /// `LogDestinationConfig` array element from
    /// `LogDestinationConfigs`.
    ///
    /// * Change the `LogDestination` setting in a single
    /// `LogDestinationConfig` array element.
    ///
    /// You can't change the `LogDestinationType` or `LogType` in a
    /// `LogDestinationConfig`. To change these settings, delete the existing
    /// `LogDestinationConfig` object and create a new one, using two separate calls
    /// to this update operation.
    pub fn updateLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_logging_configuration.UpdateLoggingConfigurationInput, options: update_logging_configuration.Options) !update_logging_configuration.UpdateLoggingConfigurationOutput {
        return update_logging_configuration.execute(self, allocator, input, options);
    }

    /// Updates the properties of the specified proxy.
    pub fn updateProxy(self: *Self, allocator: std.mem.Allocator, input: update_proxy.UpdateProxyInput, options: update_proxy.Options) !update_proxy.UpdateProxyOutput {
        return update_proxy.execute(self, allocator, input, options);
    }

    /// Updates the properties of the specified proxy configuration.
    pub fn updateProxyConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_proxy_configuration.UpdateProxyConfigurationInput, options: update_proxy_configuration.Options) !update_proxy_configuration.UpdateProxyConfigurationOutput {
        return update_proxy_configuration.execute(self, allocator, input, options);
    }

    /// Updates the properties of the specified proxy rule.
    pub fn updateProxyRule(self: *Self, allocator: std.mem.Allocator, input: update_proxy_rule.UpdateProxyRuleInput, options: update_proxy_rule.Options) !update_proxy_rule.UpdateProxyRuleOutput {
        return update_proxy_rule.execute(self, allocator, input, options);
    }

    /// Updates proxy rule group priorities within a proxy configuration.
    pub fn updateProxyRuleGroupPriorities(self: *Self, allocator: std.mem.Allocator, input: update_proxy_rule_group_priorities.UpdateProxyRuleGroupPrioritiesInput, options: update_proxy_rule_group_priorities.Options) !update_proxy_rule_group_priorities.UpdateProxyRuleGroupPrioritiesOutput {
        return update_proxy_rule_group_priorities.execute(self, allocator, input, options);
    }

    /// Updates proxy rule priorities within a proxy rule group.
    pub fn updateProxyRulePriorities(self: *Self, allocator: std.mem.Allocator, input: update_proxy_rule_priorities.UpdateProxyRulePrioritiesInput, options: update_proxy_rule_priorities.Options) !update_proxy_rule_priorities.UpdateProxyRulePrioritiesOutput {
        return update_proxy_rule_priorities.execute(self, allocator, input, options);
    }

    /// Updates the rule settings for the specified rule group. You use a rule group
    /// by
    /// reference in one or more firewall policies. When you modify a rule group,
    /// you modify all
    /// firewall policies that use the rule group.
    ///
    /// To update a rule group, first call DescribeRuleGroup to retrieve the
    /// current RuleGroup object, update the object as needed, and then provide
    /// the updated object to this call.
    pub fn updateRuleGroup(self: *Self, allocator: std.mem.Allocator, input: update_rule_group.UpdateRuleGroupInput, options: update_rule_group.Options) !update_rule_group.UpdateRuleGroupOutput {
        return update_rule_group.execute(self, allocator, input, options);
    }

    pub fn updateSubnetChangeProtection(self: *Self, allocator: std.mem.Allocator, input: update_subnet_change_protection.UpdateSubnetChangeProtectionInput, options: update_subnet_change_protection.Options) !update_subnet_change_protection.UpdateSubnetChangeProtectionOutput {
        return update_subnet_change_protection.execute(self, allocator, input, options);
    }

    /// Updates the TLS inspection configuration settings for the specified TLS
    /// inspection configuration. You use a TLS inspection configuration by
    /// referencing it in one or more firewall policies. When you modify a TLS
    /// inspection configuration, you modify all
    /// firewall policies that use the TLS inspection configuration.
    ///
    /// To update a TLS inspection configuration, first call
    /// DescribeTLSInspectionConfiguration to retrieve the
    /// current TLSInspectionConfiguration object, update the object as needed, and
    /// then provide
    /// the updated object to this call.
    pub fn updateTlsInspectionConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_tls_inspection_configuration.UpdateTLSInspectionConfigurationInput, options: update_tls_inspection_configuration.Options) !update_tls_inspection_configuration.UpdateTLSInspectionConfigurationOutput {
        return update_tls_inspection_configuration.execute(self, allocator, input, options);
    }

    pub fn getAnalysisReportResultsPaginator(self: *Self, params: get_analysis_report_results.GetAnalysisReportResultsInput) paginator.GetAnalysisReportResultsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAnalysisReportsPaginator(self: *Self, params: list_analysis_reports.ListAnalysisReportsInput) paginator.ListAnalysisReportsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFirewallPoliciesPaginator(self: *Self, params: list_firewall_policies.ListFirewallPoliciesInput) paginator.ListFirewallPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFirewallsPaginator(self: *Self, params: list_firewalls.ListFirewallsInput) paginator.ListFirewallsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFlowOperationResultsPaginator(self: *Self, params: list_flow_operation_results.ListFlowOperationResultsInput) paginator.ListFlowOperationResultsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFlowOperationsPaginator(self: *Self, params: list_flow_operations.ListFlowOperationsInput) paginator.ListFlowOperationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProxiesPaginator(self: *Self, params: list_proxies.ListProxiesInput) paginator.ListProxiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProxyConfigurationsPaginator(self: *Self, params: list_proxy_configurations.ListProxyConfigurationsInput) paginator.ListProxyConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProxyRuleGroupsPaginator(self: *Self, params: list_proxy_rule_groups.ListProxyRuleGroupsInput) paginator.ListProxyRuleGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRuleGroupsPaginator(self: *Self, params: list_rule_groups.ListRuleGroupsInput) paginator.ListRuleGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTlsInspectionConfigurationsPaginator(self: *Self, params: list_tls_inspection_configurations.ListTLSInspectionConfigurationsInput) paginator.ListTLSInspectionConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVpcEndpointAssociationsPaginator(self: *Self, params: list_vpc_endpoint_associations.ListVpcEndpointAssociationsInput) paginator.ListVpcEndpointAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
