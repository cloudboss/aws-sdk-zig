const aws = @import("aws");
const std = @import("std");

const associate_hosted_zone = @import("associate_hosted_zone.zig");
const batch_create_firewall_rule = @import("batch_create_firewall_rule.zig");
const batch_delete_firewall_rule = @import("batch_delete_firewall_rule.zig");
const batch_update_firewall_rule = @import("batch_update_firewall_rule.zig");
const create_access_source = @import("create_access_source.zig");
const create_access_token = @import("create_access_token.zig");
const create_dns_view = @import("create_dns_view.zig");
const create_firewall_domain_list = @import("create_firewall_domain_list.zig");
const create_firewall_rule = @import("create_firewall_rule.zig");
const create_global_resolver = @import("create_global_resolver.zig");
const delete_access_source = @import("delete_access_source.zig");
const delete_access_token = @import("delete_access_token.zig");
const delete_dns_view = @import("delete_dns_view.zig");
const delete_firewall_domain_list = @import("delete_firewall_domain_list.zig");
const delete_firewall_rule = @import("delete_firewall_rule.zig");
const delete_global_resolver = @import("delete_global_resolver.zig");
const disable_dns_view = @import("disable_dns_view.zig");
const disassociate_hosted_zone = @import("disassociate_hosted_zone.zig");
const enable_dns_view = @import("enable_dns_view.zig");
const get_access_source = @import("get_access_source.zig");
const get_access_token = @import("get_access_token.zig");
const get_dns_view = @import("get_dns_view.zig");
const get_firewall_domain_list = @import("get_firewall_domain_list.zig");
const get_firewall_rule = @import("get_firewall_rule.zig");
const get_global_resolver = @import("get_global_resolver.zig");
const get_hosted_zone_association = @import("get_hosted_zone_association.zig");
const get_managed_firewall_domain_list = @import("get_managed_firewall_domain_list.zig");
const import_firewall_domains = @import("import_firewall_domains.zig");
const list_access_sources = @import("list_access_sources.zig");
const list_access_tokens = @import("list_access_tokens.zig");
const list_dns_views = @import("list_dns_views.zig");
const list_firewall_domain_lists = @import("list_firewall_domain_lists.zig");
const list_firewall_domains = @import("list_firewall_domains.zig");
const list_firewall_rules = @import("list_firewall_rules.zig");
const list_global_resolvers = @import("list_global_resolvers.zig");
const list_hosted_zone_associations = @import("list_hosted_zone_associations.zig");
const list_managed_firewall_domain_lists = @import("list_managed_firewall_domain_lists.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_access_source = @import("update_access_source.zig");
const update_access_token = @import("update_access_token.zig");
const update_dns_view = @import("update_dns_view.zig");
const update_firewall_domains = @import("update_firewall_domains.zig");
const update_firewall_rule = @import("update_firewall_rule.zig");
const update_global_resolver = @import("update_global_resolver.zig");
const update_hosted_zone_association = @import("update_hosted_zone_association.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Route53GlobalResolver";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Associates a Route 53 private hosted zone with a Route 53 Global Resolver
    /// resource. This allows the resolver to resolve DNS queries for the private
    /// hosted zone from anywhere globally.
    pub fn associateHostedZone(self: *Self, allocator: std.mem.Allocator, input: associate_hosted_zone.AssociateHostedZoneInput, options: associate_hosted_zone.Options) !associate_hosted_zone.AssociateHostedZoneOutput {
        return associate_hosted_zone.execute(self, allocator, input, options);
    }

    /// Creates multiple DNS firewall rules in a single operation. This is more
    /// efficient than creating rules individually when you need to set up multiple
    /// rules at once.
    pub fn batchCreateFirewallRule(self: *Self, allocator: std.mem.Allocator, input: batch_create_firewall_rule.BatchCreateFirewallRuleInput, options: batch_create_firewall_rule.Options) !batch_create_firewall_rule.BatchCreateFirewallRuleOutput {
        return batch_create_firewall_rule.execute(self, allocator, input, options);
    }

    /// Deletes multiple DNS firewall rules in a single operation. This is more
    /// efficient than deleting rules individually.
    pub fn batchDeleteFirewallRule(self: *Self, allocator: std.mem.Allocator, input: batch_delete_firewall_rule.BatchDeleteFirewallRuleInput, options: batch_delete_firewall_rule.Options) !batch_delete_firewall_rule.BatchDeleteFirewallRuleOutput {
        return batch_delete_firewall_rule.execute(self, allocator, input, options);
    }

    /// Updates multiple DNS firewall rules in a single operation. This is more
    /// efficient than updating rules individually.
    pub fn batchUpdateFirewallRule(self: *Self, allocator: std.mem.Allocator, input: batch_update_firewall_rule.BatchUpdateFirewallRuleInput, options: batch_update_firewall_rule.Options) !batch_update_firewall_rule.BatchUpdateFirewallRuleOutput {
        return batch_update_firewall_rule.execute(self, allocator, input, options);
    }

    /// Creates an access source for a DNS view. Access sources define IP addresses
    /// or CIDR ranges that are allowed to send DNS queries to the Route 53 Global
    /// Resolver, along with the permitted DNS protocols.
    pub fn createAccessSource(self: *Self, allocator: std.mem.Allocator, input: create_access_source.CreateAccessSourceInput, options: create_access_source.Options) !create_access_source.CreateAccessSourceOutput {
        return create_access_source.execute(self, allocator, input, options);
    }

    /// Creates an access token for a DNS view. Access tokens provide token-based
    /// authentication for DNS-over-HTTPS (DoH) and DNS-over-TLS (DoT) connections
    /// to the Route 53 Global Resolver.
    pub fn createAccessToken(self: *Self, allocator: std.mem.Allocator, input: create_access_token.CreateAccessTokenInput, options: create_access_token.Options) !create_access_token.CreateAccessTokenOutput {
        return create_access_token.execute(self, allocator, input, options);
    }

    /// Creates a DNS view within a Route 53 Global Resolver. A DNS view models end
    /// users, user groups, networks, and devices, and serves as a parent resource
    /// that holds configurations controlling access, authorization, DNS firewall
    /// rules, and forwarding rules.
    pub fn createDnsView(self: *Self, allocator: std.mem.Allocator, input: create_dns_view.CreateDNSViewInput, options: create_dns_view.Options) !create_dns_view.CreateDNSViewOutput {
        return create_dns_view.execute(self, allocator, input, options);
    }

    /// Creates a firewall domain list. Domain lists are reusable sets of domain
    /// specifications that you use in DNS firewall rules to allow, block, or alert
    /// on DNS queries to specific domains.
    pub fn createFirewallDomainList(self: *Self, allocator: std.mem.Allocator, input: create_firewall_domain_list.CreateFirewallDomainListInput, options: create_firewall_domain_list.Options) !create_firewall_domain_list.CreateFirewallDomainListOutput {
        return create_firewall_domain_list.execute(self, allocator, input, options);
    }

    /// Creates a DNS firewall rule. Firewall rules define actions (ALLOW, BLOCK, or
    /// ALERT) to take on DNS queries that match specified domain lists, managed
    /// domain lists, or advanced threat protections.
    pub fn createFirewallRule(self: *Self, allocator: std.mem.Allocator, input: create_firewall_rule.CreateFirewallRuleInput, options: create_firewall_rule.Options) !create_firewall_rule.CreateFirewallRuleOutput {
        return create_firewall_rule.execute(self, allocator, input, options);
    }

    /// Creates a new Route 53 Global Resolver instance. A Route 53 Global Resolver
    /// is a global, internet-accessible DNS resolver that provides secure DNS
    /// resolution for both public and private domains through global anycast IP
    /// addresses.
    pub fn createGlobalResolver(self: *Self, allocator: std.mem.Allocator, input: create_global_resolver.CreateGlobalResolverInput, options: create_global_resolver.Options) !create_global_resolver.CreateGlobalResolverOutput {
        return create_global_resolver.execute(self, allocator, input, options);
    }

    /// Deletes an access source. This operation cannot be undone.
    pub fn deleteAccessSource(self: *Self, allocator: std.mem.Allocator, input: delete_access_source.DeleteAccessSourceInput, options: delete_access_source.Options) !delete_access_source.DeleteAccessSourceOutput {
        return delete_access_source.execute(self, allocator, input, options);
    }

    /// Deletes an access token. This operation cannot be undone.
    pub fn deleteAccessToken(self: *Self, allocator: std.mem.Allocator, input: delete_access_token.DeleteAccessTokenInput, options: delete_access_token.Options) !delete_access_token.DeleteAccessTokenOutput {
        return delete_access_token.execute(self, allocator, input, options);
    }

    /// Deletes a DNS view. This operation cannot be undone.
    pub fn deleteDnsView(self: *Self, allocator: std.mem.Allocator, input: delete_dns_view.DeleteDNSViewInput, options: delete_dns_view.Options) !delete_dns_view.DeleteDNSViewOutput {
        return delete_dns_view.execute(self, allocator, input, options);
    }

    /// Deletes a firewall domain list. This operation cannot be undone.
    pub fn deleteFirewallDomainList(self: *Self, allocator: std.mem.Allocator, input: delete_firewall_domain_list.DeleteFirewallDomainListInput, options: delete_firewall_domain_list.Options) !delete_firewall_domain_list.DeleteFirewallDomainListOutput {
        return delete_firewall_domain_list.execute(self, allocator, input, options);
    }

    /// Deletes a DNS firewall rule. This operation cannot be undone.
    pub fn deleteFirewallRule(self: *Self, allocator: std.mem.Allocator, input: delete_firewall_rule.DeleteFirewallRuleInput, options: delete_firewall_rule.Options) !delete_firewall_rule.DeleteFirewallRuleOutput {
        return delete_firewall_rule.execute(self, allocator, input, options);
    }

    /// Deletes a Route 53 Global Resolver instance. This operation cannot be
    /// undone. All associated DNS views, access sources, tokens, and firewall rules
    /// are also deleted.
    pub fn deleteGlobalResolver(self: *Self, allocator: std.mem.Allocator, input: delete_global_resolver.DeleteGlobalResolverInput, options: delete_global_resolver.Options) !delete_global_resolver.DeleteGlobalResolverOutput {
        return delete_global_resolver.execute(self, allocator, input, options);
    }

    /// Disables a DNS view, preventing it from serving DNS queries.
    pub fn disableDnsView(self: *Self, allocator: std.mem.Allocator, input: disable_dns_view.DisableDNSViewInput, options: disable_dns_view.Options) !disable_dns_view.DisableDNSViewOutput {
        return disable_dns_view.execute(self, allocator, input, options);
    }

    /// Disassociates a Route 53 private hosted zone from a Route 53 Global Resolver
    /// resource.
    pub fn disassociateHostedZone(self: *Self, allocator: std.mem.Allocator, input: disassociate_hosted_zone.DisassociateHostedZoneInput, options: disassociate_hosted_zone.Options) !disassociate_hosted_zone.DisassociateHostedZoneOutput {
        return disassociate_hosted_zone.execute(self, allocator, input, options);
    }

    /// Enables a disabled DNS view, allowing it to serve DNS queries again.
    pub fn enableDnsView(self: *Self, allocator: std.mem.Allocator, input: enable_dns_view.EnableDNSViewInput, options: enable_dns_view.Options) !enable_dns_view.EnableDNSViewOutput {
        return enable_dns_view.execute(self, allocator, input, options);
    }

    /// Retrieves information about an access source.
    pub fn getAccessSource(self: *Self, allocator: std.mem.Allocator, input: get_access_source.GetAccessSourceInput, options: get_access_source.Options) !get_access_source.GetAccessSourceOutput {
        return get_access_source.execute(self, allocator, input, options);
    }

    /// Retrieves information about an access token.
    pub fn getAccessToken(self: *Self, allocator: std.mem.Allocator, input: get_access_token.GetAccessTokenInput, options: get_access_token.Options) !get_access_token.GetAccessTokenOutput {
        return get_access_token.execute(self, allocator, input, options);
    }

    /// Retrieves information about a DNS view.
    pub fn getDnsView(self: *Self, allocator: std.mem.Allocator, input: get_dns_view.GetDNSViewInput, options: get_dns_view.Options) !get_dns_view.GetDNSViewOutput {
        return get_dns_view.execute(self, allocator, input, options);
    }

    /// Retrieves information about a firewall domain list.
    pub fn getFirewallDomainList(self: *Self, allocator: std.mem.Allocator, input: get_firewall_domain_list.GetFirewallDomainListInput, options: get_firewall_domain_list.Options) !get_firewall_domain_list.GetFirewallDomainListOutput {
        return get_firewall_domain_list.execute(self, allocator, input, options);
    }

    /// Retrieves information about a DNS firewall rule.
    pub fn getFirewallRule(self: *Self, allocator: std.mem.Allocator, input: get_firewall_rule.GetFirewallRuleInput, options: get_firewall_rule.Options) !get_firewall_rule.GetFirewallRuleOutput {
        return get_firewall_rule.execute(self, allocator, input, options);
    }

    /// Retrieves information about a Route 53 Global Resolver instance.
    pub fn getGlobalResolver(self: *Self, allocator: std.mem.Allocator, input: get_global_resolver.GetGlobalResolverInput, options: get_global_resolver.Options) !get_global_resolver.GetGlobalResolverOutput {
        return get_global_resolver.execute(self, allocator, input, options);
    }

    /// Retrieves information about a hosted zone association.
    pub fn getHostedZoneAssociation(self: *Self, allocator: std.mem.Allocator, input: get_hosted_zone_association.GetHostedZoneAssociationInput, options: get_hosted_zone_association.Options) !get_hosted_zone_association.GetHostedZoneAssociationOutput {
        return get_hosted_zone_association.execute(self, allocator, input, options);
    }

    /// Retrieves information about an AWS-managed firewall domain list. Managed
    /// domain lists contain domains associated with malicious activity, content
    /// categories, or specific threats.
    pub fn getManagedFirewallDomainList(self: *Self, allocator: std.mem.Allocator, input: get_managed_firewall_domain_list.GetManagedFirewallDomainListInput, options: get_managed_firewall_domain_list.Options) !get_managed_firewall_domain_list.GetManagedFirewallDomainListOutput {
        return get_managed_firewall_domain_list.execute(self, allocator, input, options);
    }

    /// Imports a list of domains from an Amazon S3 file into a firewall domain
    /// list. The file should contain one domain per line.
    pub fn importFirewallDomains(self: *Self, allocator: std.mem.Allocator, input: import_firewall_domains.ImportFirewallDomainsInput, options: import_firewall_domains.Options) !import_firewall_domains.ImportFirewallDomainsOutput {
        return import_firewall_domains.execute(self, allocator, input, options);
    }

    /// Lists all access sources with pagination support.
    pub fn listAccessSources(self: *Self, allocator: std.mem.Allocator, input: list_access_sources.ListAccessSourcesInput, options: list_access_sources.Options) !list_access_sources.ListAccessSourcesOutput {
        return list_access_sources.execute(self, allocator, input, options);
    }

    /// Lists all access tokens for a DNS view with pagination support.
    pub fn listAccessTokens(self: *Self, allocator: std.mem.Allocator, input: list_access_tokens.ListAccessTokensInput, options: list_access_tokens.Options) !list_access_tokens.ListAccessTokensOutput {
        return list_access_tokens.execute(self, allocator, input, options);
    }

    /// Lists all DNS views for a Route 53 Global Resolver with pagination support.
    pub fn listDnsViews(self: *Self, allocator: std.mem.Allocator, input: list_dns_views.ListDNSViewsInput, options: list_dns_views.Options) !list_dns_views.ListDNSViewsOutput {
        return list_dns_views.execute(self, allocator, input, options);
    }

    /// Lists all firewall domain lists for a Route 53 Global Resolver with
    /// pagination support.
    pub fn listFirewallDomainLists(self: *Self, allocator: std.mem.Allocator, input: list_firewall_domain_lists.ListFirewallDomainListsInput, options: list_firewall_domain_lists.Options) !list_firewall_domain_lists.ListFirewallDomainListsOutput {
        return list_firewall_domain_lists.execute(self, allocator, input, options);
    }

    /// Lists all the domains in DNS Firewall domain list you have created.
    pub fn listFirewallDomains(self: *Self, allocator: std.mem.Allocator, input: list_firewall_domains.ListFirewallDomainsInput, options: list_firewall_domains.Options) !list_firewall_domains.ListFirewallDomainsOutput {
        return list_firewall_domains.execute(self, allocator, input, options);
    }

    /// Lists all DNS firewall rules for a DNS view with pagination support.
    pub fn listFirewallRules(self: *Self, allocator: std.mem.Allocator, input: list_firewall_rules.ListFirewallRulesInput, options: list_firewall_rules.Options) !list_firewall_rules.ListFirewallRulesOutput {
        return list_firewall_rules.execute(self, allocator, input, options);
    }

    /// Lists all Route 53 Global Resolver instances in your account with pagination
    /// support.
    pub fn listGlobalResolvers(self: *Self, allocator: std.mem.Allocator, input: list_global_resolvers.ListGlobalResolversInput, options: list_global_resolvers.Options) !list_global_resolvers.ListGlobalResolversOutput {
        return list_global_resolvers.execute(self, allocator, input, options);
    }

    /// Lists all hosted zone associations for a Route 53 Global Resolver resource
    /// with pagination support.
    pub fn listHostedZoneAssociations(self: *Self, allocator: std.mem.Allocator, input: list_hosted_zone_associations.ListHostedZoneAssociationsInput, options: list_hosted_zone_associations.Options) !list_hosted_zone_associations.ListHostedZoneAssociationsOutput {
        return list_hosted_zone_associations.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of the AWS Managed DNS Lists and the categories for
    /// DNS Firewall. The categories are either `THREAT` or `CONTENT`.
    pub fn listManagedFirewallDomainLists(self: *Self, allocator: std.mem.Allocator, input: list_managed_firewall_domain_lists.ListManagedFirewallDomainListsInput, options: list_managed_firewall_domain_lists.Options) !list_managed_firewall_domain_lists.ListManagedFirewallDomainListsOutput {
        return list_managed_firewall_domain_lists.execute(self, allocator, input, options);
    }

    /// Lists the tags associated with a Route 53 Global Resolver resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds or updates tags for a Route 53 Global Resolver resource. Tags are
    /// key-value pairs that help you organize and identify your resources.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a Route 53 Global Resolver resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an access source.
    pub fn updateAccessSource(self: *Self, allocator: std.mem.Allocator, input: update_access_source.UpdateAccessSourceInput, options: update_access_source.Options) !update_access_source.UpdateAccessSourceOutput {
        return update_access_source.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an access token.
    pub fn updateAccessToken(self: *Self, allocator: std.mem.Allocator, input: update_access_token.UpdateAccessTokenInput, options: update_access_token.Options) !update_access_token.UpdateAccessTokenOutput {
        return update_access_token.execute(self, allocator, input, options);
    }

    /// Updates the configuration of a DNS view.
    pub fn updateDnsView(self: *Self, allocator: std.mem.Allocator, input: update_dns_view.UpdateDNSViewInput, options: update_dns_view.Options) !update_dns_view.UpdateDNSViewOutput {
        return update_dns_view.execute(self, allocator, input, options);
    }

    /// Updates a DNS Firewall domain list from an array of specified domains.
    pub fn updateFirewallDomains(self: *Self, allocator: std.mem.Allocator, input: update_firewall_domains.UpdateFirewallDomainsInput, options: update_firewall_domains.Options) !update_firewall_domains.UpdateFirewallDomainsOutput {
        return update_firewall_domains.execute(self, allocator, input, options);
    }

    /// Updates the configuration of a DNS firewall rule.
    pub fn updateFirewallRule(self: *Self, allocator: std.mem.Allocator, input: update_firewall_rule.UpdateFirewallRuleInput, options: update_firewall_rule.Options) !update_firewall_rule.UpdateFirewallRuleOutput {
        return update_firewall_rule.execute(self, allocator, input, options);
    }

    /// Updates the configuration of a Route 53 Global Resolver instance. You can
    /// modify the name, description, and observability region.
    pub fn updateGlobalResolver(self: *Self, allocator: std.mem.Allocator, input: update_global_resolver.UpdateGlobalResolverInput, options: update_global_resolver.Options) !update_global_resolver.UpdateGlobalResolverOutput {
        return update_global_resolver.execute(self, allocator, input, options);
    }

    /// Updates the configuration of a hosted zone association.
    pub fn updateHostedZoneAssociation(self: *Self, allocator: std.mem.Allocator, input: update_hosted_zone_association.UpdateHostedZoneAssociationInput, options: update_hosted_zone_association.Options) !update_hosted_zone_association.UpdateHostedZoneAssociationOutput {
        return update_hosted_zone_association.execute(self, allocator, input, options);
    }

    pub fn listAccessSourcesPaginator(self: *Self, params: list_access_sources.ListAccessSourcesInput) paginator.ListAccessSourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAccessTokensPaginator(self: *Self, params: list_access_tokens.ListAccessTokensInput) paginator.ListAccessTokensPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDnsViewsPaginator(self: *Self, params: list_dns_views.ListDNSViewsInput) paginator.ListDNSViewsPaginator {
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

    pub fn listFirewallRulesPaginator(self: *Self, params: list_firewall_rules.ListFirewallRulesInput) paginator.ListFirewallRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGlobalResolversPaginator(self: *Self, params: list_global_resolvers.ListGlobalResolversInput) paginator.ListGlobalResolversPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listHostedZoneAssociationsPaginator(self: *Self, params: list_hosted_zone_associations.ListHostedZoneAssociationsInput) paginator.ListHostedZoneAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listManagedFirewallDomainListsPaginator(self: *Self, params: list_managed_firewall_domain_lists.ListManagedFirewallDomainListsInput) paginator.ListManagedFirewallDomainListsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
