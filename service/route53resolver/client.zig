const aws = @import("aws");
const std = @import("std");

const associate_firewall_rule_group = @import("associate_firewall_rule_group.zig");
const associate_resolver_endpoint_ip_address = @import("associate_resolver_endpoint_ip_address.zig");
const associate_resolver_query_log_config = @import("associate_resolver_query_log_config.zig");
const associate_resolver_rule = @import("associate_resolver_rule.zig");
const create_firewall_domain_list = @import("create_firewall_domain_list.zig");
const create_firewall_rule = @import("create_firewall_rule.zig");
const create_firewall_rule_group = @import("create_firewall_rule_group.zig");
const create_outpost_resolver = @import("create_outpost_resolver.zig");
const create_resolver_endpoint = @import("create_resolver_endpoint.zig");
const create_resolver_query_log_config = @import("create_resolver_query_log_config.zig");
const create_resolver_rule = @import("create_resolver_rule.zig");
const delete_firewall_domain_list = @import("delete_firewall_domain_list.zig");
const delete_firewall_rule = @import("delete_firewall_rule.zig");
const delete_firewall_rule_group = @import("delete_firewall_rule_group.zig");
const delete_outpost_resolver = @import("delete_outpost_resolver.zig");
const delete_resolver_endpoint = @import("delete_resolver_endpoint.zig");
const delete_resolver_query_log_config = @import("delete_resolver_query_log_config.zig");
const delete_resolver_rule = @import("delete_resolver_rule.zig");
const disassociate_firewall_rule_group = @import("disassociate_firewall_rule_group.zig");
const disassociate_resolver_endpoint_ip_address = @import("disassociate_resolver_endpoint_ip_address.zig");
const disassociate_resolver_query_log_config = @import("disassociate_resolver_query_log_config.zig");
const disassociate_resolver_rule = @import("disassociate_resolver_rule.zig");
const get_firewall_config = @import("get_firewall_config.zig");
const get_firewall_domain_list = @import("get_firewall_domain_list.zig");
const get_firewall_rule_group = @import("get_firewall_rule_group.zig");
const get_firewall_rule_group_association = @import("get_firewall_rule_group_association.zig");
const get_firewall_rule_group_policy = @import("get_firewall_rule_group_policy.zig");
const get_outpost_resolver = @import("get_outpost_resolver.zig");
const get_resolver_config = @import("get_resolver_config.zig");
const get_resolver_dnssec_config = @import("get_resolver_dnssec_config.zig");
const get_resolver_endpoint = @import("get_resolver_endpoint.zig");
const get_resolver_query_log_config = @import("get_resolver_query_log_config.zig");
const get_resolver_query_log_config_association = @import("get_resolver_query_log_config_association.zig");
const get_resolver_query_log_config_policy = @import("get_resolver_query_log_config_policy.zig");
const get_resolver_rule = @import("get_resolver_rule.zig");
const get_resolver_rule_association = @import("get_resolver_rule_association.zig");
const get_resolver_rule_policy = @import("get_resolver_rule_policy.zig");
const import_firewall_domains = @import("import_firewall_domains.zig");
const list_firewall_configs = @import("list_firewall_configs.zig");
const list_firewall_domain_lists = @import("list_firewall_domain_lists.zig");
const list_firewall_domains = @import("list_firewall_domains.zig");
const list_firewall_rule_group_associations = @import("list_firewall_rule_group_associations.zig");
const list_firewall_rule_groups = @import("list_firewall_rule_groups.zig");
const list_firewall_rules = @import("list_firewall_rules.zig");
const list_outpost_resolvers = @import("list_outpost_resolvers.zig");
const list_resolver_configs = @import("list_resolver_configs.zig");
const list_resolver_dnssec_configs = @import("list_resolver_dnssec_configs.zig");
const list_resolver_endpoint_ip_addresses = @import("list_resolver_endpoint_ip_addresses.zig");
const list_resolver_endpoints = @import("list_resolver_endpoints.zig");
const list_resolver_query_log_config_associations = @import("list_resolver_query_log_config_associations.zig");
const list_resolver_query_log_configs = @import("list_resolver_query_log_configs.zig");
const list_resolver_rule_associations = @import("list_resolver_rule_associations.zig");
const list_resolver_rules = @import("list_resolver_rules.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_firewall_rule_group_policy = @import("put_firewall_rule_group_policy.zig");
const put_resolver_query_log_config_policy = @import("put_resolver_query_log_config_policy.zig");
const put_resolver_rule_policy = @import("put_resolver_rule_policy.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_firewall_config = @import("update_firewall_config.zig");
const update_firewall_domains = @import("update_firewall_domains.zig");
const update_firewall_rule = @import("update_firewall_rule.zig");
const update_firewall_rule_group_association = @import("update_firewall_rule_group_association.zig");
const update_outpost_resolver = @import("update_outpost_resolver.zig");
const update_resolver_config = @import("update_resolver_config.zig");
const update_resolver_dnssec_config = @import("update_resolver_dnssec_config.zig");
const update_resolver_endpoint = @import("update_resolver_endpoint.zig");
const update_resolver_rule = @import("update_resolver_rule.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Route53Resolver";

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

    /// Associates a FirewallRuleGroup with a VPC, to provide DNS filtering for the
    /// VPC.
    pub fn associateFirewallRuleGroup(self: *Self, allocator: std.mem.Allocator, input: associate_firewall_rule_group.AssociateFirewallRuleGroupInput, options: associate_firewall_rule_group.Options) !associate_firewall_rule_group.AssociateFirewallRuleGroupOutput {
        return associate_firewall_rule_group.execute(self, allocator, input, options);
    }

    /// Adds IP addresses to an inbound or an outbound Resolver endpoint. If you
    /// want to add more than one IP address,
    /// submit one `AssociateResolverEndpointIpAddress` request for each IP address.
    ///
    /// To remove an IP address from an endpoint, see
    /// [DisassociateResolverEndpointIpAddress](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_DisassociateResolverEndpointIpAddress.html).
    pub fn associateResolverEndpointIpAddress(self: *Self, allocator: std.mem.Allocator, input: associate_resolver_endpoint_ip_address.AssociateResolverEndpointIpAddressInput, options: associate_resolver_endpoint_ip_address.Options) !associate_resolver_endpoint_ip_address.AssociateResolverEndpointIpAddressOutput {
        return associate_resolver_endpoint_ip_address.execute(self, allocator, input, options);
    }

    /// Associates an Amazon VPC with a specified query logging configuration. Route
    /// 53 Resolver logs DNS queries that originate in all of the Amazon VPCs
    /// that are associated with a specified query logging configuration. To
    /// associate more than one VPC with a configuration, submit one
    /// `AssociateResolverQueryLogConfig`
    /// request for each VPC.
    ///
    /// The VPCs that you associate with a query logging configuration must be in
    /// the same Region as the configuration.
    ///
    /// To remove a VPC from a query logging configuration, see
    /// [DisassociateResolverQueryLogConfig](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_DisassociateResolverQueryLogConfig.html).
    pub fn associateResolverQueryLogConfig(self: *Self, allocator: std.mem.Allocator, input: associate_resolver_query_log_config.AssociateResolverQueryLogConfigInput, options: associate_resolver_query_log_config.Options) !associate_resolver_query_log_config.AssociateResolverQueryLogConfigOutput {
        return associate_resolver_query_log_config.execute(self, allocator, input, options);
    }

    /// Associates a Resolver rule with a VPC. When you associate a rule with a VPC,
    /// Resolver forwards all DNS queries
    /// for the domain name that is specified in the rule and that originate in the
    /// VPC. The queries are forwarded to the
    /// IP addresses for the DNS resolvers that are specified in the rule. For more
    /// information about rules, see
    /// [CreateResolverRule](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_CreateResolverRule.html).
    pub fn associateResolverRule(self: *Self, allocator: std.mem.Allocator, input: associate_resolver_rule.AssociateResolverRuleInput, options: associate_resolver_rule.Options) !associate_resolver_rule.AssociateResolverRuleOutput {
        return associate_resolver_rule.execute(self, allocator, input, options);
    }

    /// Creates an empty firewall domain list for use in DNS Firewall rules. You can
    /// populate the domains for the new list with a file, using
    /// ImportFirewallDomains, or with domain strings, using UpdateFirewallDomains.
    pub fn createFirewallDomainList(self: *Self, allocator: std.mem.Allocator, input: create_firewall_domain_list.CreateFirewallDomainListInput, options: create_firewall_domain_list.Options) !create_firewall_domain_list.CreateFirewallDomainListOutput {
        return create_firewall_domain_list.execute(self, allocator, input, options);
    }

    /// Creates a single DNS Firewall rule in the specified rule group, using the
    /// specified domain list.
    pub fn createFirewallRule(self: *Self, allocator: std.mem.Allocator, input: create_firewall_rule.CreateFirewallRuleInput, options: create_firewall_rule.Options) !create_firewall_rule.CreateFirewallRuleOutput {
        return create_firewall_rule.execute(self, allocator, input, options);
    }

    /// Creates an empty DNS Firewall rule group for filtering DNS network traffic
    /// in a VPC. You can add rules to the new rule group
    /// by calling CreateFirewallRule.
    pub fn createFirewallRuleGroup(self: *Self, allocator: std.mem.Allocator, input: create_firewall_rule_group.CreateFirewallRuleGroupInput, options: create_firewall_rule_group.Options) !create_firewall_rule_group.CreateFirewallRuleGroupOutput {
        return create_firewall_rule_group.execute(self, allocator, input, options);
    }

    /// Creates a Route 53 Resolver on an Outpost.
    pub fn createOutpostResolver(self: *Self, allocator: std.mem.Allocator, input: create_outpost_resolver.CreateOutpostResolverInput, options: create_outpost_resolver.Options) !create_outpost_resolver.CreateOutpostResolverOutput {
        return create_outpost_resolver.execute(self, allocator, input, options);
    }

    /// Creates a Resolver endpoint. There are two types of Resolver endpoints,
    /// inbound and outbound:
    ///
    /// * An *inbound Resolver endpoint* forwards DNS queries to the DNS service for
    ///   a VPC
    /// from your network.
    ///
    /// * An *outbound Resolver endpoint* forwards DNS queries from the DNS service
    ///   for a VPC
    /// to your network.
    pub fn createResolverEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_resolver_endpoint.CreateResolverEndpointInput, options: create_resolver_endpoint.Options) !create_resolver_endpoint.CreateResolverEndpointOutput {
        return create_resolver_endpoint.execute(self, allocator, input, options);
    }

    /// Creates a Resolver query logging configuration, which defines where you want
    /// Resolver to save DNS query logs that originate in your VPCs.
    /// Resolver can log queries only for VPCs that are in the same Region as the
    /// query logging configuration.
    ///
    /// To specify which VPCs you want to log queries for, you use
    /// `AssociateResolverQueryLogConfig`. For more information, see
    /// [AssociateResolverQueryLogConfig](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_AssociateResolverQueryLogConfig.html).
    ///
    /// You can optionally use Resource Access Manager (RAM) to share a query
    /// logging configuration with other Amazon Web Services accounts. The other
    /// accounts
    /// can then associate VPCs with the configuration. The query logs that Resolver
    /// creates for a configuration include all DNS queries that originate in all
    /// VPCs that are associated with the configuration.
    pub fn createResolverQueryLogConfig(self: *Self, allocator: std.mem.Allocator, input: create_resolver_query_log_config.CreateResolverQueryLogConfigInput, options: create_resolver_query_log_config.Options) !create_resolver_query_log_config.CreateResolverQueryLogConfigOutput {
        return create_resolver_query_log_config.execute(self, allocator, input, options);
    }

    /// For DNS queries that originate in your VPCs, specifies which Resolver
    /// endpoint the queries pass through,
    /// one domain name that you want to forward to your network, and the IP
    /// addresses of the DNS resolvers in your network.
    pub fn createResolverRule(self: *Self, allocator: std.mem.Allocator, input: create_resolver_rule.CreateResolverRuleInput, options: create_resolver_rule.Options) !create_resolver_rule.CreateResolverRuleOutput {
        return create_resolver_rule.execute(self, allocator, input, options);
    }

    /// Deletes the specified domain list.
    pub fn deleteFirewallDomainList(self: *Self, allocator: std.mem.Allocator, input: delete_firewall_domain_list.DeleteFirewallDomainListInput, options: delete_firewall_domain_list.Options) !delete_firewall_domain_list.DeleteFirewallDomainListOutput {
        return delete_firewall_domain_list.execute(self, allocator, input, options);
    }

    /// Deletes the specified firewall rule.
    pub fn deleteFirewallRule(self: *Self, allocator: std.mem.Allocator, input: delete_firewall_rule.DeleteFirewallRuleInput, options: delete_firewall_rule.Options) !delete_firewall_rule.DeleteFirewallRuleOutput {
        return delete_firewall_rule.execute(self, allocator, input, options);
    }

    /// Deletes the specified firewall rule group.
    pub fn deleteFirewallRuleGroup(self: *Self, allocator: std.mem.Allocator, input: delete_firewall_rule_group.DeleteFirewallRuleGroupInput, options: delete_firewall_rule_group.Options) !delete_firewall_rule_group.DeleteFirewallRuleGroupOutput {
        return delete_firewall_rule_group.execute(self, allocator, input, options);
    }

    /// Deletes a Resolver on the Outpost.
    pub fn deleteOutpostResolver(self: *Self, allocator: std.mem.Allocator, input: delete_outpost_resolver.DeleteOutpostResolverInput, options: delete_outpost_resolver.Options) !delete_outpost_resolver.DeleteOutpostResolverOutput {
        return delete_outpost_resolver.execute(self, allocator, input, options);
    }

    /// Deletes a Resolver endpoint. The effect of deleting a Resolver endpoint
    /// depends on whether it's an inbound or an outbound
    /// Resolver endpoint:
    ///
    /// * **Inbound**: DNS queries from your network are no longer routed
    /// to the DNS service for the specified VPC.
    ///
    /// * **Outbound**: DNS queries from a VPC are no longer routed to your network.
    pub fn deleteResolverEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_resolver_endpoint.DeleteResolverEndpointInput, options: delete_resolver_endpoint.Options) !delete_resolver_endpoint.DeleteResolverEndpointOutput {
        return delete_resolver_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes a query logging configuration. When you delete a configuration,
    /// Resolver stops logging DNS queries for all of the Amazon VPCs that are
    /// associated with the configuration. This also applies if the query logging
    /// configuration is shared with other Amazon Web Services accounts, and
    /// the other accounts have associated VPCs with the shared configuration.
    ///
    /// Before you can delete a query logging configuration, you must first
    /// disassociate all VPCs from the configuration. See
    /// [DisassociateResolverQueryLogConfig](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_DisassociateResolverQueryLogConfig.html).
    ///
    /// If you used Resource Access Manager (RAM) to share a query logging
    /// configuration with other accounts, you must stop sharing
    /// the configuration before you can delete a configuration. The accounts that
    /// you shared the configuration with can first disassociate VPCs
    /// that they associated with the configuration, but that's not necessary. If
    /// you stop sharing the configuration, those VPCs are automatically
    /// disassociated from the configuration.
    pub fn deleteResolverQueryLogConfig(self: *Self, allocator: std.mem.Allocator, input: delete_resolver_query_log_config.DeleteResolverQueryLogConfigInput, options: delete_resolver_query_log_config.Options) !delete_resolver_query_log_config.DeleteResolverQueryLogConfigOutput {
        return delete_resolver_query_log_config.execute(self, allocator, input, options);
    }

    /// Deletes a Resolver rule. Before you can delete a Resolver rule, you must
    /// disassociate it from all the VPCs that you
    /// associated the Resolver rule with. For more information, see
    /// [DisassociateResolverRule](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_DisassociateResolverRule.html).
    pub fn deleteResolverRule(self: *Self, allocator: std.mem.Allocator, input: delete_resolver_rule.DeleteResolverRuleInput, options: delete_resolver_rule.Options) !delete_resolver_rule.DeleteResolverRuleOutput {
        return delete_resolver_rule.execute(self, allocator, input, options);
    }

    /// Disassociates a FirewallRuleGroup from a VPC, to remove DNS filtering from
    /// the VPC.
    pub fn disassociateFirewallRuleGroup(self: *Self, allocator: std.mem.Allocator, input: disassociate_firewall_rule_group.DisassociateFirewallRuleGroupInput, options: disassociate_firewall_rule_group.Options) !disassociate_firewall_rule_group.DisassociateFirewallRuleGroupOutput {
        return disassociate_firewall_rule_group.execute(self, allocator, input, options);
    }

    /// Removes IP addresses from an inbound or an outbound Resolver endpoint. If
    /// you want to remove more than one IP address,
    /// submit one `DisassociateResolverEndpointIpAddress` request for each IP
    /// address.
    ///
    /// To add an IP address to an endpoint, see
    /// [AssociateResolverEndpointIpAddress](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_AssociateResolverEndpointIpAddress.html).
    pub fn disassociateResolverEndpointIpAddress(self: *Self, allocator: std.mem.Allocator, input: disassociate_resolver_endpoint_ip_address.DisassociateResolverEndpointIpAddressInput, options: disassociate_resolver_endpoint_ip_address.Options) !disassociate_resolver_endpoint_ip_address.DisassociateResolverEndpointIpAddressOutput {
        return disassociate_resolver_endpoint_ip_address.execute(self, allocator, input, options);
    }

    /// Disassociates a VPC from a query logging configuration.
    ///
    /// Before you can delete a query logging configuration, you must first
    /// disassociate all VPCs
    /// from the configuration. If you used Resource Access Manager (RAM) to share a
    /// query logging configuration with other accounts, VPCs can be disassociated
    /// from the
    /// configuration in the following ways:
    ///
    /// * The accounts that you shared the configuration with can disassociate VPCs
    ///   from the configuration.
    ///
    /// * You can stop sharing the configuration.
    pub fn disassociateResolverQueryLogConfig(self: *Self, allocator: std.mem.Allocator, input: disassociate_resolver_query_log_config.DisassociateResolverQueryLogConfigInput, options: disassociate_resolver_query_log_config.Options) !disassociate_resolver_query_log_config.DisassociateResolverQueryLogConfigOutput {
        return disassociate_resolver_query_log_config.execute(self, allocator, input, options);
    }

    /// Removes the association between a specified Resolver rule and a specified
    /// VPC.
    ///
    /// If you disassociate a Resolver rule from a VPC, Resolver stops forwarding
    /// DNS queries for the
    /// domain name that you specified in the Resolver rule.
    pub fn disassociateResolverRule(self: *Self, allocator: std.mem.Allocator, input: disassociate_resolver_rule.DisassociateResolverRuleInput, options: disassociate_resolver_rule.Options) !disassociate_resolver_rule.DisassociateResolverRuleOutput {
        return disassociate_resolver_rule.execute(self, allocator, input, options);
    }

    /// Retrieves the configuration of the firewall behavior provided by DNS
    /// Firewall for a
    /// single VPC from Amazon Virtual Private Cloud (Amazon VPC).
    pub fn getFirewallConfig(self: *Self, allocator: std.mem.Allocator, input: get_firewall_config.GetFirewallConfigInput, options: get_firewall_config.Options) !get_firewall_config.GetFirewallConfigOutput {
        return get_firewall_config.execute(self, allocator, input, options);
    }

    /// Retrieves the specified firewall domain list.
    pub fn getFirewallDomainList(self: *Self, allocator: std.mem.Allocator, input: get_firewall_domain_list.GetFirewallDomainListInput, options: get_firewall_domain_list.Options) !get_firewall_domain_list.GetFirewallDomainListOutput {
        return get_firewall_domain_list.execute(self, allocator, input, options);
    }

    /// Retrieves the specified firewall rule group.
    pub fn getFirewallRuleGroup(self: *Self, allocator: std.mem.Allocator, input: get_firewall_rule_group.GetFirewallRuleGroupInput, options: get_firewall_rule_group.Options) !get_firewall_rule_group.GetFirewallRuleGroupOutput {
        return get_firewall_rule_group.execute(self, allocator, input, options);
    }

    /// Retrieves a firewall rule group association, which enables DNS filtering for
    /// a VPC with one rule group. A VPC can have more than one firewall rule group
    /// association, and a rule group can be associated with more than one VPC.
    pub fn getFirewallRuleGroupAssociation(self: *Self, allocator: std.mem.Allocator, input: get_firewall_rule_group_association.GetFirewallRuleGroupAssociationInput, options: get_firewall_rule_group_association.Options) !get_firewall_rule_group_association.GetFirewallRuleGroupAssociationOutput {
        return get_firewall_rule_group_association.execute(self, allocator, input, options);
    }

    /// Returns the Identity and Access Management (Amazon Web Services IAM) policy
    /// for sharing the
    /// specified rule group. You can use the policy to share the rule group using
    /// Resource Access Manager (RAM).
    pub fn getFirewallRuleGroupPolicy(self: *Self, allocator: std.mem.Allocator, input: get_firewall_rule_group_policy.GetFirewallRuleGroupPolicyInput, options: get_firewall_rule_group_policy.Options) !get_firewall_rule_group_policy.GetFirewallRuleGroupPolicyOutput {
        return get_firewall_rule_group_policy.execute(self, allocator, input, options);
    }

    /// Gets information about a specified Resolver on the Outpost, such as its
    /// instance count and
    /// type, name, and the current status of the Resolver.
    pub fn getOutpostResolver(self: *Self, allocator: std.mem.Allocator, input: get_outpost_resolver.GetOutpostResolverInput, options: get_outpost_resolver.Options) !get_outpost_resolver.GetOutpostResolverOutput {
        return get_outpost_resolver.execute(self, allocator, input, options);
    }

    /// Retrieves the behavior configuration of Route 53 Resolver behavior for a
    /// single VPC from
    /// Amazon Virtual Private Cloud.
    pub fn getResolverConfig(self: *Self, allocator: std.mem.Allocator, input: get_resolver_config.GetResolverConfigInput, options: get_resolver_config.Options) !get_resolver_config.GetResolverConfigOutput {
        return get_resolver_config.execute(self, allocator, input, options);
    }

    /// Gets DNSSEC validation information for a specified resource.
    pub fn getResolverDnssecConfig(self: *Self, allocator: std.mem.Allocator, input: get_resolver_dnssec_config.GetResolverDnssecConfigInput, options: get_resolver_dnssec_config.Options) !get_resolver_dnssec_config.GetResolverDnssecConfigOutput {
        return get_resolver_dnssec_config.execute(self, allocator, input, options);
    }

    /// Gets information about a specified Resolver endpoint, such as whether it's
    /// an inbound or an outbound Resolver endpoint, and the
    /// current status of the endpoint.
    pub fn getResolverEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_resolver_endpoint.GetResolverEndpointInput, options: get_resolver_endpoint.Options) !get_resolver_endpoint.GetResolverEndpointOutput {
        return get_resolver_endpoint.execute(self, allocator, input, options);
    }

    /// Gets information about a specified Resolver query logging configuration,
    /// such as the number of VPCs that the configuration
    /// is logging queries for and the location that logs are sent to.
    pub fn getResolverQueryLogConfig(self: *Self, allocator: std.mem.Allocator, input: get_resolver_query_log_config.GetResolverQueryLogConfigInput, options: get_resolver_query_log_config.Options) !get_resolver_query_log_config.GetResolverQueryLogConfigOutput {
        return get_resolver_query_log_config.execute(self, allocator, input, options);
    }

    /// Gets information about a specified association between a Resolver query
    /// logging configuration and an Amazon VPC. When you associate a VPC
    /// with a query logging configuration, Resolver logs DNS queries that originate
    /// in that VPC.
    pub fn getResolverQueryLogConfigAssociation(self: *Self, allocator: std.mem.Allocator, input: get_resolver_query_log_config_association.GetResolverQueryLogConfigAssociationInput, options: get_resolver_query_log_config_association.Options) !get_resolver_query_log_config_association.GetResolverQueryLogConfigAssociationOutput {
        return get_resolver_query_log_config_association.execute(self, allocator, input, options);
    }

    /// Gets information about a query logging policy. A query logging policy
    /// specifies the Resolver query logging
    /// operations and resources that you want to allow another Amazon Web Services
    /// account to be able to use.
    pub fn getResolverQueryLogConfigPolicy(self: *Self, allocator: std.mem.Allocator, input: get_resolver_query_log_config_policy.GetResolverQueryLogConfigPolicyInput, options: get_resolver_query_log_config_policy.Options) !get_resolver_query_log_config_policy.GetResolverQueryLogConfigPolicyOutput {
        return get_resolver_query_log_config_policy.execute(self, allocator, input, options);
    }

    /// Gets information about a specified Resolver rule, such as the domain name
    /// that the rule forwards DNS queries for and the ID of the
    /// outbound Resolver endpoint that the rule is associated with.
    pub fn getResolverRule(self: *Self, allocator: std.mem.Allocator, input: get_resolver_rule.GetResolverRuleInput, options: get_resolver_rule.Options) !get_resolver_rule.GetResolverRuleOutput {
        return get_resolver_rule.execute(self, allocator, input, options);
    }

    /// Gets information about an association between a specified Resolver rule and
    /// a VPC. You associate a Resolver rule and a VPC using
    /// [AssociateResolverRule](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_AssociateResolverRule.html).
    pub fn getResolverRuleAssociation(self: *Self, allocator: std.mem.Allocator, input: get_resolver_rule_association.GetResolverRuleAssociationInput, options: get_resolver_rule_association.Options) !get_resolver_rule_association.GetResolverRuleAssociationOutput {
        return get_resolver_rule_association.execute(self, allocator, input, options);
    }

    /// Gets information about the Resolver rule policy for a specified rule. A
    /// Resolver rule policy includes the rule that you want to share
    /// with another account, the account that you want to share the rule with, and
    /// the Resolver operations that you want to allow the account to use.
    pub fn getResolverRulePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resolver_rule_policy.GetResolverRulePolicyInput, options: get_resolver_rule_policy.Options) !get_resolver_rule_policy.GetResolverRulePolicyOutput {
        return get_resolver_rule_policy.execute(self, allocator, input, options);
    }

    /// Imports domain names from a file into a domain list, for use in a DNS
    /// firewall rule group.
    ///
    /// Each domain specification in your domain list must satisfy the following
    /// requirements:
    ///
    /// * It can optionally start with `*` (asterisk).
    ///
    /// * With the exception of the optional starting asterisk, it must only contain
    /// the following characters: `A-Z`, `a-z`,
    /// `0-9`, `-` (hyphen).
    ///
    /// * It must be from 1-255 characters in length.
    pub fn importFirewallDomains(self: *Self, allocator: std.mem.Allocator, input: import_firewall_domains.ImportFirewallDomainsInput, options: import_firewall_domains.Options) !import_firewall_domains.ImportFirewallDomainsOutput {
        return import_firewall_domains.execute(self, allocator, input, options);
    }

    /// Retrieves the firewall configurations that you have defined. DNS Firewall
    /// uses the configurations to manage firewall behavior for your VPCs.
    ///
    /// A single call might return only a partial list of the configurations. For
    /// information, see `MaxResults`.
    pub fn listFirewallConfigs(self: *Self, allocator: std.mem.Allocator, input: list_firewall_configs.ListFirewallConfigsInput, options: list_firewall_configs.Options) !list_firewall_configs.ListFirewallConfigsOutput {
        return list_firewall_configs.execute(self, allocator, input, options);
    }

    /// Retrieves the firewall domain lists that you have defined. For each firewall
    /// domain list, you can retrieve the domains that are defined for a list by
    /// calling ListFirewallDomains.
    ///
    /// A single call to this list operation might return only a partial list of the
    /// domain lists. For information, see `MaxResults`.
    pub fn listFirewallDomainLists(self: *Self, allocator: std.mem.Allocator, input: list_firewall_domain_lists.ListFirewallDomainListsInput, options: list_firewall_domain_lists.Options) !list_firewall_domain_lists.ListFirewallDomainListsOutput {
        return list_firewall_domain_lists.execute(self, allocator, input, options);
    }

    /// Retrieves the domains that you have defined for the specified firewall
    /// domain list.
    ///
    /// A single call might return only a partial list of the domains. For
    /// information, see `MaxResults`.
    pub fn listFirewallDomains(self: *Self, allocator: std.mem.Allocator, input: list_firewall_domains.ListFirewallDomainsInput, options: list_firewall_domains.Options) !list_firewall_domains.ListFirewallDomainsOutput {
        return list_firewall_domains.execute(self, allocator, input, options);
    }

    /// Retrieves the firewall rule group associations that you have defined. Each
    /// association enables DNS filtering for a VPC with one rule group.
    ///
    /// A single call might return only a partial list of the associations. For
    /// information, see `MaxResults`.
    pub fn listFirewallRuleGroupAssociations(self: *Self, allocator: std.mem.Allocator, input: list_firewall_rule_group_associations.ListFirewallRuleGroupAssociationsInput, options: list_firewall_rule_group_associations.Options) !list_firewall_rule_group_associations.ListFirewallRuleGroupAssociationsOutput {
        return list_firewall_rule_group_associations.execute(self, allocator, input, options);
    }

    /// Retrieves the minimal high-level information for the rule groups that you
    /// have defined.
    ///
    /// A single call might return only a partial list of the rule groups. For
    /// information, see `MaxResults`.
    pub fn listFirewallRuleGroups(self: *Self, allocator: std.mem.Allocator, input: list_firewall_rule_groups.ListFirewallRuleGroupsInput, options: list_firewall_rule_groups.Options) !list_firewall_rule_groups.ListFirewallRuleGroupsOutput {
        return list_firewall_rule_groups.execute(self, allocator, input, options);
    }

    /// Retrieves the firewall rules that you have defined for the specified
    /// firewall rule group. DNS Firewall uses the rules in a rule group to filter
    /// DNS network traffic for a VPC.
    ///
    /// A single call might return only a partial list of the rules. For
    /// information, see `MaxResults`.
    pub fn listFirewallRules(self: *Self, allocator: std.mem.Allocator, input: list_firewall_rules.ListFirewallRulesInput, options: list_firewall_rules.Options) !list_firewall_rules.ListFirewallRulesOutput {
        return list_firewall_rules.execute(self, allocator, input, options);
    }

    /// Lists all the Resolvers on Outposts that were created using the current
    /// Amazon Web Services account.
    pub fn listOutpostResolvers(self: *Self, allocator: std.mem.Allocator, input: list_outpost_resolvers.ListOutpostResolversInput, options: list_outpost_resolvers.Options) !list_outpost_resolvers.ListOutpostResolversOutput {
        return list_outpost_resolvers.execute(self, allocator, input, options);
    }

    /// Retrieves the Resolver configurations that you have defined.
    /// Route 53 Resolver uses the configurations to manage DNS resolution behavior
    /// for your VPCs.
    pub fn listResolverConfigs(self: *Self, allocator: std.mem.Allocator, input: list_resolver_configs.ListResolverConfigsInput, options: list_resolver_configs.Options) !list_resolver_configs.ListResolverConfigsOutput {
        return list_resolver_configs.execute(self, allocator, input, options);
    }

    /// Lists the configurations for DNSSEC validation that are associated with the
    /// current Amazon Web Services account.
    pub fn listResolverDnssecConfigs(self: *Self, allocator: std.mem.Allocator, input: list_resolver_dnssec_configs.ListResolverDnssecConfigsInput, options: list_resolver_dnssec_configs.Options) !list_resolver_dnssec_configs.ListResolverDnssecConfigsOutput {
        return list_resolver_dnssec_configs.execute(self, allocator, input, options);
    }

    /// Gets the IP addresses for a specified Resolver endpoint.
    pub fn listResolverEndpointIpAddresses(self: *Self, allocator: std.mem.Allocator, input: list_resolver_endpoint_ip_addresses.ListResolverEndpointIpAddressesInput, options: list_resolver_endpoint_ip_addresses.Options) !list_resolver_endpoint_ip_addresses.ListResolverEndpointIpAddressesOutput {
        return list_resolver_endpoint_ip_addresses.execute(self, allocator, input, options);
    }

    /// Lists all the Resolver endpoints that were created using the current Amazon
    /// Web Services account.
    pub fn listResolverEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_resolver_endpoints.ListResolverEndpointsInput, options: list_resolver_endpoints.Options) !list_resolver_endpoints.ListResolverEndpointsOutput {
        return list_resolver_endpoints.execute(self, allocator, input, options);
    }

    /// Lists information about associations between Amazon VPCs and query logging
    /// configurations.
    pub fn listResolverQueryLogConfigAssociations(self: *Self, allocator: std.mem.Allocator, input: list_resolver_query_log_config_associations.ListResolverQueryLogConfigAssociationsInput, options: list_resolver_query_log_config_associations.Options) !list_resolver_query_log_config_associations.ListResolverQueryLogConfigAssociationsOutput {
        return list_resolver_query_log_config_associations.execute(self, allocator, input, options);
    }

    /// Lists information about the specified query logging configurations. Each
    /// configuration defines where you want Resolver to save
    /// DNS query logs and specifies the VPCs that you want to log queries for.
    pub fn listResolverQueryLogConfigs(self: *Self, allocator: std.mem.Allocator, input: list_resolver_query_log_configs.ListResolverQueryLogConfigsInput, options: list_resolver_query_log_configs.Options) !list_resolver_query_log_configs.ListResolverQueryLogConfigsOutput {
        return list_resolver_query_log_configs.execute(self, allocator, input, options);
    }

    /// Lists the associations that were created between Resolver rules and VPCs
    /// using the current Amazon Web Services account.
    pub fn listResolverRuleAssociations(self: *Self, allocator: std.mem.Allocator, input: list_resolver_rule_associations.ListResolverRuleAssociationsInput, options: list_resolver_rule_associations.Options) !list_resolver_rule_associations.ListResolverRuleAssociationsOutput {
        return list_resolver_rule_associations.execute(self, allocator, input, options);
    }

    /// Lists the Resolver rules that were created using the current Amazon Web
    /// Services account.
    pub fn listResolverRules(self: *Self, allocator: std.mem.Allocator, input: list_resolver_rules.ListResolverRulesInput, options: list_resolver_rules.Options) !list_resolver_rules.ListResolverRulesOutput {
        return list_resolver_rules.execute(self, allocator, input, options);
    }

    /// Lists the tags that you associated with the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Attaches an Identity and Access Management (Amazon Web Services IAM) policy
    /// for sharing the rule
    /// group. You can use the policy to share the rule group using Resource Access
    /// Manager
    /// (RAM).
    pub fn putFirewallRuleGroupPolicy(self: *Self, allocator: std.mem.Allocator, input: put_firewall_rule_group_policy.PutFirewallRuleGroupPolicyInput, options: put_firewall_rule_group_policy.Options) !put_firewall_rule_group_policy.PutFirewallRuleGroupPolicyOutput {
        return put_firewall_rule_group_policy.execute(self, allocator, input, options);
    }

    /// Specifies an Amazon Web Services account that you want to share a query
    /// logging configuration with, the query logging configuration that you want to
    /// share,
    /// and the operations that you want the account to be able to perform on the
    /// configuration.
    pub fn putResolverQueryLogConfigPolicy(self: *Self, allocator: std.mem.Allocator, input: put_resolver_query_log_config_policy.PutResolverQueryLogConfigPolicyInput, options: put_resolver_query_log_config_policy.Options) !put_resolver_query_log_config_policy.PutResolverQueryLogConfigPolicyOutput {
        return put_resolver_query_log_config_policy.execute(self, allocator, input, options);
    }

    /// Specifies an Amazon Web Services rule that you want to share with another
    /// account, the account that you want to share the rule with,
    /// and the operations that you want the account to be able to perform on the
    /// rule.
    pub fn putResolverRulePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resolver_rule_policy.PutResolverRulePolicyInput, options: put_resolver_rule_policy.Options) !put_resolver_rule_policy.PutResolverRulePolicyOutput {
        return put_resolver_rule_policy.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to a specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from a specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the configuration of the firewall behavior provided by DNS Firewall
    /// for a single
    /// VPC from Amazon Virtual Private Cloud (Amazon VPC).
    pub fn updateFirewallConfig(self: *Self, allocator: std.mem.Allocator, input: update_firewall_config.UpdateFirewallConfigInput, options: update_firewall_config.Options) !update_firewall_config.UpdateFirewallConfigOutput {
        return update_firewall_config.execute(self, allocator, input, options);
    }

    /// Updates the firewall domain list from an array of domain specifications.
    pub fn updateFirewallDomains(self: *Self, allocator: std.mem.Allocator, input: update_firewall_domains.UpdateFirewallDomainsInput, options: update_firewall_domains.Options) !update_firewall_domains.UpdateFirewallDomainsOutput {
        return update_firewall_domains.execute(self, allocator, input, options);
    }

    /// Updates the specified firewall rule.
    pub fn updateFirewallRule(self: *Self, allocator: std.mem.Allocator, input: update_firewall_rule.UpdateFirewallRuleInput, options: update_firewall_rule.Options) !update_firewall_rule.UpdateFirewallRuleOutput {
        return update_firewall_rule.execute(self, allocator, input, options);
    }

    /// Changes the association of a FirewallRuleGroup with a VPC. The association
    /// enables DNS filtering for the VPC.
    pub fn updateFirewallRuleGroupAssociation(self: *Self, allocator: std.mem.Allocator, input: update_firewall_rule_group_association.UpdateFirewallRuleGroupAssociationInput, options: update_firewall_rule_group_association.Options) !update_firewall_rule_group_association.UpdateFirewallRuleGroupAssociationOutput {
        return update_firewall_rule_group_association.execute(self, allocator, input, options);
    }

    /// You can use `UpdateOutpostResolver` to update the instance count, type, or
    /// name of a Resolver on an Outpost.
    pub fn updateOutpostResolver(self: *Self, allocator: std.mem.Allocator, input: update_outpost_resolver.UpdateOutpostResolverInput, options: update_outpost_resolver.Options) !update_outpost_resolver.UpdateOutpostResolverOutput {
        return update_outpost_resolver.execute(self, allocator, input, options);
    }

    /// Updates the behavior configuration of Route 53 Resolver behavior for a
    /// single VPC from
    /// Amazon Virtual Private Cloud.
    pub fn updateResolverConfig(self: *Self, allocator: std.mem.Allocator, input: update_resolver_config.UpdateResolverConfigInput, options: update_resolver_config.Options) !update_resolver_config.UpdateResolverConfigOutput {
        return update_resolver_config.execute(self, allocator, input, options);
    }

    /// Updates an existing DNSSEC validation configuration. If there is no existing
    /// DNSSEC validation configuration, one is created.
    pub fn updateResolverDnssecConfig(self: *Self, allocator: std.mem.Allocator, input: update_resolver_dnssec_config.UpdateResolverDnssecConfigInput, options: update_resolver_dnssec_config.Options) !update_resolver_dnssec_config.UpdateResolverDnssecConfigOutput {
        return update_resolver_dnssec_config.execute(self, allocator, input, options);
    }

    /// Updates the name, or endpoint type for an inbound or an outbound Resolver
    /// endpoint.
    /// You can only update between IPV4 and DUALSTACK, IPV6 endpoint type can't be
    /// updated to other type.
    pub fn updateResolverEndpoint(self: *Self, allocator: std.mem.Allocator, input: update_resolver_endpoint.UpdateResolverEndpointInput, options: update_resolver_endpoint.Options) !update_resolver_endpoint.UpdateResolverEndpointOutput {
        return update_resolver_endpoint.execute(self, allocator, input, options);
    }

    /// Updates settings for a specified Resolver rule. `ResolverRuleId` is
    /// required, and all other parameters are optional.
    /// If you don't specify a parameter, it retains its current value.
    pub fn updateResolverRule(self: *Self, allocator: std.mem.Allocator, input: update_resolver_rule.UpdateResolverRuleInput, options: update_resolver_rule.Options) !update_resolver_rule.UpdateResolverRuleOutput {
        return update_resolver_rule.execute(self, allocator, input, options);
    }

    pub fn listFirewallConfigsPaginator(self: *Self, params: list_firewall_configs.ListFirewallConfigsInput) paginator.ListFirewallConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFirewallDomainListsPaginator(self: *Self, params: list_firewall_domain_lists.ListFirewallDomainListsInput) paginator.ListFirewallDomainListsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFirewallDomainsPaginator(self: *Self, params: list_firewall_domains.ListFirewallDomainsInput) paginator.ListFirewallDomainsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFirewallRuleGroupAssociationsPaginator(self: *Self, params: list_firewall_rule_group_associations.ListFirewallRuleGroupAssociationsInput) paginator.ListFirewallRuleGroupAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFirewallRuleGroupsPaginator(self: *Self, params: list_firewall_rule_groups.ListFirewallRuleGroupsInput) paginator.ListFirewallRuleGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFirewallRulesPaginator(self: *Self, params: list_firewall_rules.ListFirewallRulesInput) paginator.ListFirewallRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOutpostResolversPaginator(self: *Self, params: list_outpost_resolvers.ListOutpostResolversInput) paginator.ListOutpostResolversPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResolverConfigsPaginator(self: *Self, params: list_resolver_configs.ListResolverConfigsInput) paginator.ListResolverConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResolverDnssecConfigsPaginator(self: *Self, params: list_resolver_dnssec_configs.ListResolverDnssecConfigsInput) paginator.ListResolverDnssecConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResolverEndpointIpAddressesPaginator(self: *Self, params: list_resolver_endpoint_ip_addresses.ListResolverEndpointIpAddressesInput) paginator.ListResolverEndpointIpAddressesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResolverEndpointsPaginator(self: *Self, params: list_resolver_endpoints.ListResolverEndpointsInput) paginator.ListResolverEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResolverQueryLogConfigAssociationsPaginator(self: *Self, params: list_resolver_query_log_config_associations.ListResolverQueryLogConfigAssociationsInput) paginator.ListResolverQueryLogConfigAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResolverQueryLogConfigsPaginator(self: *Self, params: list_resolver_query_log_configs.ListResolverQueryLogConfigsInput) paginator.ListResolverQueryLogConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResolverRuleAssociationsPaginator(self: *Self, params: list_resolver_rule_associations.ListResolverRuleAssociationsInput) paginator.ListResolverRuleAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResolverRulesPaginator(self: *Self, params: list_resolver_rules.ListResolverRulesInput) paginator.ListResolverRulesPaginator {
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
};
