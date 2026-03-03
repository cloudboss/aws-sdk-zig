const aws = @import("aws");
const std = @import("std");

const accept_inbound_cross_cluster_search_connection = @import("accept_inbound_cross_cluster_search_connection.zig");
const add_tags = @import("add_tags.zig");
const associate_package = @import("associate_package.zig");
const authorize_vpc_endpoint_access = @import("authorize_vpc_endpoint_access.zig");
const cancel_domain_config_change = @import("cancel_domain_config_change.zig");
const cancel_elasticsearch_service_software_update = @import("cancel_elasticsearch_service_software_update.zig");
const create_elasticsearch_domain = @import("create_elasticsearch_domain.zig");
const create_outbound_cross_cluster_search_connection = @import("create_outbound_cross_cluster_search_connection.zig");
const create_package = @import("create_package.zig");
const create_vpc_endpoint = @import("create_vpc_endpoint.zig");
const delete_elasticsearch_domain = @import("delete_elasticsearch_domain.zig");
const delete_elasticsearch_service_role = @import("delete_elasticsearch_service_role.zig");
const delete_inbound_cross_cluster_search_connection = @import("delete_inbound_cross_cluster_search_connection.zig");
const delete_outbound_cross_cluster_search_connection = @import("delete_outbound_cross_cluster_search_connection.zig");
const delete_package = @import("delete_package.zig");
const delete_vpc_endpoint = @import("delete_vpc_endpoint.zig");
const describe_domain_auto_tunes = @import("describe_domain_auto_tunes.zig");
const describe_domain_change_progress = @import("describe_domain_change_progress.zig");
const describe_elasticsearch_domain = @import("describe_elasticsearch_domain.zig");
const describe_elasticsearch_domain_config = @import("describe_elasticsearch_domain_config.zig");
const describe_elasticsearch_domains = @import("describe_elasticsearch_domains.zig");
const describe_elasticsearch_instance_type_limits = @import("describe_elasticsearch_instance_type_limits.zig");
const describe_inbound_cross_cluster_search_connections = @import("describe_inbound_cross_cluster_search_connections.zig");
const describe_outbound_cross_cluster_search_connections = @import("describe_outbound_cross_cluster_search_connections.zig");
const describe_packages = @import("describe_packages.zig");
const describe_reserved_elasticsearch_instance_offerings = @import("describe_reserved_elasticsearch_instance_offerings.zig");
const describe_reserved_elasticsearch_instances = @import("describe_reserved_elasticsearch_instances.zig");
const describe_vpc_endpoints = @import("describe_vpc_endpoints.zig");
const dissociate_package = @import("dissociate_package.zig");
const get_compatible_elasticsearch_versions = @import("get_compatible_elasticsearch_versions.zig");
const get_package_version_history = @import("get_package_version_history.zig");
const get_upgrade_history = @import("get_upgrade_history.zig");
const get_upgrade_status = @import("get_upgrade_status.zig");
const list_domain_names = @import("list_domain_names.zig");
const list_domains_for_package = @import("list_domains_for_package.zig");
const list_elasticsearch_instance_types = @import("list_elasticsearch_instance_types.zig");
const list_elasticsearch_versions = @import("list_elasticsearch_versions.zig");
const list_packages_for_domain = @import("list_packages_for_domain.zig");
const list_tags = @import("list_tags.zig");
const list_vpc_endpoint_access = @import("list_vpc_endpoint_access.zig");
const list_vpc_endpoints = @import("list_vpc_endpoints.zig");
const list_vpc_endpoints_for_domain = @import("list_vpc_endpoints_for_domain.zig");
const purchase_reserved_elasticsearch_instance_offering = @import("purchase_reserved_elasticsearch_instance_offering.zig");
const reject_inbound_cross_cluster_search_connection = @import("reject_inbound_cross_cluster_search_connection.zig");
const remove_tags = @import("remove_tags.zig");
const revoke_vpc_endpoint_access = @import("revoke_vpc_endpoint_access.zig");
const start_elasticsearch_service_software_update = @import("start_elasticsearch_service_software_update.zig");
const update_elasticsearch_domain_config = @import("update_elasticsearch_domain_config.zig");
const update_package = @import("update_package.zig");
const update_vpc_endpoint = @import("update_vpc_endpoint.zig");
const upgrade_elasticsearch_domain = @import("upgrade_elasticsearch_domain.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Elasticsearch Service";

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

    /// Allows the destination domain owner to accept an inbound cross-cluster
    /// search connection request.
    pub fn acceptInboundCrossClusterSearchConnection(self: *Self, allocator: std.mem.Allocator, input: accept_inbound_cross_cluster_search_connection.AcceptInboundCrossClusterSearchConnectionInput, options: accept_inbound_cross_cluster_search_connection.Options) !accept_inbound_cross_cluster_search_connection.AcceptInboundCrossClusterSearchConnectionOutput {
        return accept_inbound_cross_cluster_search_connection.execute(self, allocator, input, options);
    }

    /// Attaches tags to an existing Elasticsearch domain. Tags are a set of
    /// case-sensitive key value pairs. An Elasticsearch domain may have up to 10
    /// tags. See [
    /// Tagging Amazon Elasticsearch Service Domains for more
    /// information.](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-managedomains.html#es-managedomains-awsresorcetagging)
    pub fn addTags(self: *Self, allocator: std.mem.Allocator, input: add_tags.AddTagsInput, options: add_tags.Options) !add_tags.AddTagsOutput {
        return add_tags.execute(self, allocator, input, options);
    }

    /// Associates a package with an Amazon ES domain.
    pub fn associatePackage(self: *Self, allocator: std.mem.Allocator, input: associate_package.AssociatePackageInput, options: associate_package.Options) !associate_package.AssociatePackageOutput {
        return associate_package.execute(self, allocator, input, options);
    }

    /// Provides access to an Amazon OpenSearch Service domain through the use of an
    /// interface VPC endpoint.
    pub fn authorizeVpcEndpointAccess(self: *Self, allocator: std.mem.Allocator, input: authorize_vpc_endpoint_access.AuthorizeVpcEndpointAccessInput, options: authorize_vpc_endpoint_access.Options) !authorize_vpc_endpoint_access.AuthorizeVpcEndpointAccessOutput {
        return authorize_vpc_endpoint_access.execute(self, allocator, input, options);
    }

    /// Cancels a pending configuration change on an Amazon OpenSearch Service
    /// domain.
    pub fn cancelDomainConfigChange(self: *Self, allocator: std.mem.Allocator, input: cancel_domain_config_change.CancelDomainConfigChangeInput, options: cancel_domain_config_change.Options) !cancel_domain_config_change.CancelDomainConfigChangeOutput {
        return cancel_domain_config_change.execute(self, allocator, input, options);
    }

    /// Cancels a scheduled service software update for an Amazon ES domain. You can
    /// only perform this operation before the `AutomatedUpdateDate` and when the
    /// `UpdateStatus` is in the `PENDING_UPDATE` state.
    pub fn cancelElasticsearchServiceSoftwareUpdate(self: *Self, allocator: std.mem.Allocator, input: cancel_elasticsearch_service_software_update.CancelElasticsearchServiceSoftwareUpdateInput, options: cancel_elasticsearch_service_software_update.Options) !cancel_elasticsearch_service_software_update.CancelElasticsearchServiceSoftwareUpdateOutput {
        return cancel_elasticsearch_service_software_update.execute(self, allocator, input, options);
    }

    /// Creates a new Elasticsearch domain. For more information,
    /// see [Creating Elasticsearch
    /// Domains](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-createupdatedomains.html#es-createdomains) in the *Amazon Elasticsearch Service Developer Guide*.
    pub fn createElasticsearchDomain(self: *Self, allocator: std.mem.Allocator, input: create_elasticsearch_domain.CreateElasticsearchDomainInput, options: create_elasticsearch_domain.Options) !create_elasticsearch_domain.CreateElasticsearchDomainOutput {
        return create_elasticsearch_domain.execute(self, allocator, input, options);
    }

    /// Creates a new cross-cluster search connection from a source domain to a
    /// destination domain.
    pub fn createOutboundCrossClusterSearchConnection(self: *Self, allocator: std.mem.Allocator, input: create_outbound_cross_cluster_search_connection.CreateOutboundCrossClusterSearchConnectionInput, options: create_outbound_cross_cluster_search_connection.Options) !create_outbound_cross_cluster_search_connection.CreateOutboundCrossClusterSearchConnectionOutput {
        return create_outbound_cross_cluster_search_connection.execute(self, allocator, input, options);
    }

    /// Create a package for use with Amazon ES domains.
    pub fn createPackage(self: *Self, allocator: std.mem.Allocator, input: create_package.CreatePackageInput, options: create_package.Options) !create_package.CreatePackageOutput {
        return create_package.execute(self, allocator, input, options);
    }

    /// Creates an Amazon OpenSearch Service-managed VPC endpoint.
    pub fn createVpcEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_vpc_endpoint.CreateVpcEndpointInput, options: create_vpc_endpoint.Options) !create_vpc_endpoint.CreateVpcEndpointOutput {
        return create_vpc_endpoint.execute(self, allocator, input, options);
    }

    /// Permanently deletes the specified Elasticsearch domain and all of its data.
    /// Once a domain is deleted, it cannot be recovered.
    pub fn deleteElasticsearchDomain(self: *Self, allocator: std.mem.Allocator, input: delete_elasticsearch_domain.DeleteElasticsearchDomainInput, options: delete_elasticsearch_domain.Options) !delete_elasticsearch_domain.DeleteElasticsearchDomainOutput {
        return delete_elasticsearch_domain.execute(self, allocator, input, options);
    }

    /// Deletes the service-linked role that Elasticsearch Service uses to manage
    /// and maintain VPC domains. Role deletion will fail if any existing VPC
    /// domains use the role. You must delete any such Elasticsearch domains before
    /// deleting the role. See [Deleting Elasticsearch Service
    /// Role](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-vpc.html#es-enabling-slr) in *VPC Endpoints for Amazon Elasticsearch Service Domains*.
    pub fn deleteElasticsearchServiceRole(self: *Self, allocator: std.mem.Allocator, input: delete_elasticsearch_service_role.DeleteElasticsearchServiceRoleInput, options: delete_elasticsearch_service_role.Options) !delete_elasticsearch_service_role.DeleteElasticsearchServiceRoleOutput {
        return delete_elasticsearch_service_role.execute(self, allocator, input, options);
    }

    /// Allows the destination domain owner to delete an existing inbound
    /// cross-cluster search connection.
    pub fn deleteInboundCrossClusterSearchConnection(self: *Self, allocator: std.mem.Allocator, input: delete_inbound_cross_cluster_search_connection.DeleteInboundCrossClusterSearchConnectionInput, options: delete_inbound_cross_cluster_search_connection.Options) !delete_inbound_cross_cluster_search_connection.DeleteInboundCrossClusterSearchConnectionOutput {
        return delete_inbound_cross_cluster_search_connection.execute(self, allocator, input, options);
    }

    /// Allows the source domain owner to delete an existing outbound cross-cluster
    /// search connection.
    pub fn deleteOutboundCrossClusterSearchConnection(self: *Self, allocator: std.mem.Allocator, input: delete_outbound_cross_cluster_search_connection.DeleteOutboundCrossClusterSearchConnectionInput, options: delete_outbound_cross_cluster_search_connection.Options) !delete_outbound_cross_cluster_search_connection.DeleteOutboundCrossClusterSearchConnectionOutput {
        return delete_outbound_cross_cluster_search_connection.execute(self, allocator, input, options);
    }

    /// Delete the package.
    pub fn deletePackage(self: *Self, allocator: std.mem.Allocator, input: delete_package.DeletePackageInput, options: delete_package.Options) !delete_package.DeletePackageOutput {
        return delete_package.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon OpenSearch Service-managed interface VPC endpoint.
    pub fn deleteVpcEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_vpc_endpoint.DeleteVpcEndpointInput, options: delete_vpc_endpoint.Options) !delete_vpc_endpoint.DeleteVpcEndpointOutput {
        return delete_vpc_endpoint.execute(self, allocator, input, options);
    }

    /// Provides scheduled Auto-Tune action details for the Elasticsearch domain,
    /// such as Auto-Tune action type, description, severity, and scheduled date.
    pub fn describeDomainAutoTunes(self: *Self, allocator: std.mem.Allocator, input: describe_domain_auto_tunes.DescribeDomainAutoTunesInput, options: describe_domain_auto_tunes.Options) !describe_domain_auto_tunes.DescribeDomainAutoTunesOutput {
        return describe_domain_auto_tunes.execute(self, allocator, input, options);
    }

    /// Returns information about the current blue/green deployment happening on a
    /// domain, including
    /// a change ID, status, and progress stages.
    pub fn describeDomainChangeProgress(self: *Self, allocator: std.mem.Allocator, input: describe_domain_change_progress.DescribeDomainChangeProgressInput, options: describe_domain_change_progress.Options) !describe_domain_change_progress.DescribeDomainChangeProgressOutput {
        return describe_domain_change_progress.execute(self, allocator, input, options);
    }

    /// Returns domain configuration information about the specified Elasticsearch
    /// domain, including the domain ID, domain endpoint, and domain ARN.
    pub fn describeElasticsearchDomain(self: *Self, allocator: std.mem.Allocator, input: describe_elasticsearch_domain.DescribeElasticsearchDomainInput, options: describe_elasticsearch_domain.Options) !describe_elasticsearch_domain.DescribeElasticsearchDomainOutput {
        return describe_elasticsearch_domain.execute(self, allocator, input, options);
    }

    /// Provides cluster configuration information about the specified Elasticsearch
    /// domain, such as the state, creation date, update version, and update date
    /// for cluster options.
    pub fn describeElasticsearchDomainConfig(self: *Self, allocator: std.mem.Allocator, input: describe_elasticsearch_domain_config.DescribeElasticsearchDomainConfigInput, options: describe_elasticsearch_domain_config.Options) !describe_elasticsearch_domain_config.DescribeElasticsearchDomainConfigOutput {
        return describe_elasticsearch_domain_config.execute(self, allocator, input, options);
    }

    /// Returns domain configuration information about the specified Elasticsearch
    /// domains, including the domain ID, domain endpoint, and domain ARN.
    pub fn describeElasticsearchDomains(self: *Self, allocator: std.mem.Allocator, input: describe_elasticsearch_domains.DescribeElasticsearchDomainsInput, options: describe_elasticsearch_domains.Options) !describe_elasticsearch_domains.DescribeElasticsearchDomainsOutput {
        return describe_elasticsearch_domains.execute(self, allocator, input, options);
    }

    /// Describe Elasticsearch Limits for a given InstanceType and
    /// ElasticsearchVersion.
    /// When modifying existing Domain, specify the
    /// `
    /// DomainName
    /// `
    /// to know what Limits are supported for modifying.
    pub fn describeElasticsearchInstanceTypeLimits(self: *Self, allocator: std.mem.Allocator, input: describe_elasticsearch_instance_type_limits.DescribeElasticsearchInstanceTypeLimitsInput, options: describe_elasticsearch_instance_type_limits.Options) !describe_elasticsearch_instance_type_limits.DescribeElasticsearchInstanceTypeLimitsOutput {
        return describe_elasticsearch_instance_type_limits.execute(self, allocator, input, options);
    }

    /// Lists all the inbound cross-cluster search connections for a destination
    /// domain.
    pub fn describeInboundCrossClusterSearchConnections(self: *Self, allocator: std.mem.Allocator, input: describe_inbound_cross_cluster_search_connections.DescribeInboundCrossClusterSearchConnectionsInput, options: describe_inbound_cross_cluster_search_connections.Options) !describe_inbound_cross_cluster_search_connections.DescribeInboundCrossClusterSearchConnectionsOutput {
        return describe_inbound_cross_cluster_search_connections.execute(self, allocator, input, options);
    }

    /// Lists all the outbound cross-cluster search connections for a source domain.
    pub fn describeOutboundCrossClusterSearchConnections(self: *Self, allocator: std.mem.Allocator, input: describe_outbound_cross_cluster_search_connections.DescribeOutboundCrossClusterSearchConnectionsInput, options: describe_outbound_cross_cluster_search_connections.Options) !describe_outbound_cross_cluster_search_connections.DescribeOutboundCrossClusterSearchConnectionsOutput {
        return describe_outbound_cross_cluster_search_connections.execute(self, allocator, input, options);
    }

    /// Describes all packages available to Amazon ES. Includes options for
    /// filtering, limiting the number of results, and pagination.
    pub fn describePackages(self: *Self, allocator: std.mem.Allocator, input: describe_packages.DescribePackagesInput, options: describe_packages.Options) !describe_packages.DescribePackagesOutput {
        return describe_packages.execute(self, allocator, input, options);
    }

    /// Lists available reserved Elasticsearch instance offerings.
    pub fn describeReservedElasticsearchInstanceOfferings(self: *Self, allocator: std.mem.Allocator, input: describe_reserved_elasticsearch_instance_offerings.DescribeReservedElasticsearchInstanceOfferingsInput, options: describe_reserved_elasticsearch_instance_offerings.Options) !describe_reserved_elasticsearch_instance_offerings.DescribeReservedElasticsearchInstanceOfferingsOutput {
        return describe_reserved_elasticsearch_instance_offerings.execute(self, allocator, input, options);
    }

    /// Returns information about reserved Elasticsearch instances for this account.
    pub fn describeReservedElasticsearchInstances(self: *Self, allocator: std.mem.Allocator, input: describe_reserved_elasticsearch_instances.DescribeReservedElasticsearchInstancesInput, options: describe_reserved_elasticsearch_instances.Options) !describe_reserved_elasticsearch_instances.DescribeReservedElasticsearchInstancesOutput {
        return describe_reserved_elasticsearch_instances.execute(self, allocator, input, options);
    }

    /// Describes one or more Amazon OpenSearch Service-managed VPC endpoints.
    pub fn describeVpcEndpoints(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_endpoints.DescribeVpcEndpointsInput, options: describe_vpc_endpoints.Options) !describe_vpc_endpoints.DescribeVpcEndpointsOutput {
        return describe_vpc_endpoints.execute(self, allocator, input, options);
    }

    /// Dissociates a package from the Amazon ES domain.
    pub fn dissociatePackage(self: *Self, allocator: std.mem.Allocator, input: dissociate_package.DissociatePackageInput, options: dissociate_package.Options) !dissociate_package.DissociatePackageOutput {
        return dissociate_package.execute(self, allocator, input, options);
    }

    /// Returns a list of upgrade compatible Elastisearch versions.
    /// You can optionally pass a
    /// `
    /// DomainName
    /// `
    /// to get all upgrade compatible Elasticsearch versions for that specific
    /// domain.
    pub fn getCompatibleElasticsearchVersions(self: *Self, allocator: std.mem.Allocator, input: get_compatible_elasticsearch_versions.GetCompatibleElasticsearchVersionsInput, options: get_compatible_elasticsearch_versions.Options) !get_compatible_elasticsearch_versions.GetCompatibleElasticsearchVersionsOutput {
        return get_compatible_elasticsearch_versions.execute(self, allocator, input, options);
    }

    /// Returns a list of versions of the package, along with their creation time
    /// and commit message.
    pub fn getPackageVersionHistory(self: *Self, allocator: std.mem.Allocator, input: get_package_version_history.GetPackageVersionHistoryInput, options: get_package_version_history.Options) !get_package_version_history.GetPackageVersionHistoryOutput {
        return get_package_version_history.execute(self, allocator, input, options);
    }

    /// Retrieves the complete history of the last 10 upgrades that were performed
    /// on the domain.
    pub fn getUpgradeHistory(self: *Self, allocator: std.mem.Allocator, input: get_upgrade_history.GetUpgradeHistoryInput, options: get_upgrade_history.Options) !get_upgrade_history.GetUpgradeHistoryOutput {
        return get_upgrade_history.execute(self, allocator, input, options);
    }

    /// Retrieves the latest status of the last upgrade or upgrade eligibility check
    /// that was performed on the domain.
    pub fn getUpgradeStatus(self: *Self, allocator: std.mem.Allocator, input: get_upgrade_status.GetUpgradeStatusInput, options: get_upgrade_status.Options) !get_upgrade_status.GetUpgradeStatusOutput {
        return get_upgrade_status.execute(self, allocator, input, options);
    }

    /// Returns the name of all Elasticsearch domains owned by the current user's
    /// account.
    pub fn listDomainNames(self: *Self, allocator: std.mem.Allocator, input: list_domain_names.ListDomainNamesInput, options: list_domain_names.Options) !list_domain_names.ListDomainNamesOutput {
        return list_domain_names.execute(self, allocator, input, options);
    }

    /// Lists all Amazon ES domains associated with the package.
    pub fn listDomainsForPackage(self: *Self, allocator: std.mem.Allocator, input: list_domains_for_package.ListDomainsForPackageInput, options: list_domains_for_package.Options) !list_domains_for_package.ListDomainsForPackageOutput {
        return list_domains_for_package.execute(self, allocator, input, options);
    }

    /// List all Elasticsearch instance types that are supported for given
    /// ElasticsearchVersion
    pub fn listElasticsearchInstanceTypes(self: *Self, allocator: std.mem.Allocator, input: list_elasticsearch_instance_types.ListElasticsearchInstanceTypesInput, options: list_elasticsearch_instance_types.Options) !list_elasticsearch_instance_types.ListElasticsearchInstanceTypesOutput {
        return list_elasticsearch_instance_types.execute(self, allocator, input, options);
    }

    /// List all supported Elasticsearch versions
    pub fn listElasticsearchVersions(self: *Self, allocator: std.mem.Allocator, input: list_elasticsearch_versions.ListElasticsearchVersionsInput, options: list_elasticsearch_versions.Options) !list_elasticsearch_versions.ListElasticsearchVersionsOutput {
        return list_elasticsearch_versions.execute(self, allocator, input, options);
    }

    /// Lists all packages associated with the Amazon ES domain.
    pub fn listPackagesForDomain(self: *Self, allocator: std.mem.Allocator, input: list_packages_for_domain.ListPackagesForDomainInput, options: list_packages_for_domain.Options) !list_packages_for_domain.ListPackagesForDomainOutput {
        return list_packages_for_domain.execute(self, allocator, input, options);
    }

    /// Returns all tags for the given Elasticsearch domain.
    pub fn listTags(self: *Self, allocator: std.mem.Allocator, input: list_tags.ListTagsInput, options: list_tags.Options) !list_tags.ListTagsOutput {
        return list_tags.execute(self, allocator, input, options);
    }

    /// Retrieves information about each principal that is allowed to access a
    /// given Amazon OpenSearch Service domain through the use of an interface VPC
    /// endpoint.
    pub fn listVpcEndpointAccess(self: *Self, allocator: std.mem.Allocator, input: list_vpc_endpoint_access.ListVpcEndpointAccessInput, options: list_vpc_endpoint_access.Options) !list_vpc_endpoint_access.ListVpcEndpointAccessOutput {
        return list_vpc_endpoint_access.execute(self, allocator, input, options);
    }

    /// Retrieves all Amazon OpenSearch Service-managed VPC endpoints in the current
    /// account and Region.
    pub fn listVpcEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_vpc_endpoints.ListVpcEndpointsInput, options: list_vpc_endpoints.Options) !list_vpc_endpoints.ListVpcEndpointsOutput {
        return list_vpc_endpoints.execute(self, allocator, input, options);
    }

    /// Retrieves all Amazon OpenSearch Service-managed VPC endpoints associated
    /// with a particular domain.
    pub fn listVpcEndpointsForDomain(self: *Self, allocator: std.mem.Allocator, input: list_vpc_endpoints_for_domain.ListVpcEndpointsForDomainInput, options: list_vpc_endpoints_for_domain.Options) !list_vpc_endpoints_for_domain.ListVpcEndpointsForDomainOutput {
        return list_vpc_endpoints_for_domain.execute(self, allocator, input, options);
    }

    /// Allows you to purchase reserved Elasticsearch instances.
    pub fn purchaseReservedElasticsearchInstanceOffering(self: *Self, allocator: std.mem.Allocator, input: purchase_reserved_elasticsearch_instance_offering.PurchaseReservedElasticsearchInstanceOfferingInput, options: purchase_reserved_elasticsearch_instance_offering.Options) !purchase_reserved_elasticsearch_instance_offering.PurchaseReservedElasticsearchInstanceOfferingOutput {
        return purchase_reserved_elasticsearch_instance_offering.execute(self, allocator, input, options);
    }

    /// Allows the destination domain owner to reject an inbound cross-cluster
    /// search connection request.
    pub fn rejectInboundCrossClusterSearchConnection(self: *Self, allocator: std.mem.Allocator, input: reject_inbound_cross_cluster_search_connection.RejectInboundCrossClusterSearchConnectionInput, options: reject_inbound_cross_cluster_search_connection.Options) !reject_inbound_cross_cluster_search_connection.RejectInboundCrossClusterSearchConnectionOutput {
        return reject_inbound_cross_cluster_search_connection.execute(self, allocator, input, options);
    }

    /// Removes the specified set of tags from the specified Elasticsearch domain.
    pub fn removeTags(self: *Self, allocator: std.mem.Allocator, input: remove_tags.RemoveTagsInput, options: remove_tags.Options) !remove_tags.RemoveTagsOutput {
        return remove_tags.execute(self, allocator, input, options);
    }

    /// Revokes access to an Amazon OpenSearch Service domain that was provided
    /// through an interface
    /// VPC endpoint.
    pub fn revokeVpcEndpointAccess(self: *Self, allocator: std.mem.Allocator, input: revoke_vpc_endpoint_access.RevokeVpcEndpointAccessInput, options: revoke_vpc_endpoint_access.Options) !revoke_vpc_endpoint_access.RevokeVpcEndpointAccessOutput {
        return revoke_vpc_endpoint_access.execute(self, allocator, input, options);
    }

    /// Schedules a service software update for an Amazon ES domain.
    pub fn startElasticsearchServiceSoftwareUpdate(self: *Self, allocator: std.mem.Allocator, input: start_elasticsearch_service_software_update.StartElasticsearchServiceSoftwareUpdateInput, options: start_elasticsearch_service_software_update.Options) !start_elasticsearch_service_software_update.StartElasticsearchServiceSoftwareUpdateOutput {
        return start_elasticsearch_service_software_update.execute(self, allocator, input, options);
    }

    /// Modifies the cluster configuration of the specified Elasticsearch domain,
    /// setting as setting the instance type and the number of instances.
    pub fn updateElasticsearchDomainConfig(self: *Self, allocator: std.mem.Allocator, input: update_elasticsearch_domain_config.UpdateElasticsearchDomainConfigInput, options: update_elasticsearch_domain_config.Options) !update_elasticsearch_domain_config.UpdateElasticsearchDomainConfigOutput {
        return update_elasticsearch_domain_config.execute(self, allocator, input, options);
    }

    /// Updates a package for use with Amazon ES domains.
    pub fn updatePackage(self: *Self, allocator: std.mem.Allocator, input: update_package.UpdatePackageInput, options: update_package.Options) !update_package.UpdatePackageOutput {
        return update_package.execute(self, allocator, input, options);
    }

    /// Modifies an Amazon OpenSearch Service-managed interface VPC endpoint.
    pub fn updateVpcEndpoint(self: *Self, allocator: std.mem.Allocator, input: update_vpc_endpoint.UpdateVpcEndpointInput, options: update_vpc_endpoint.Options) !update_vpc_endpoint.UpdateVpcEndpointOutput {
        return update_vpc_endpoint.execute(self, allocator, input, options);
    }

    /// Allows you to either upgrade your domain or perform an Upgrade eligibility
    /// check to a compatible Elasticsearch version.
    pub fn upgradeElasticsearchDomain(self: *Self, allocator: std.mem.Allocator, input: upgrade_elasticsearch_domain.UpgradeElasticsearchDomainInput, options: upgrade_elasticsearch_domain.Options) !upgrade_elasticsearch_domain.UpgradeElasticsearchDomainOutput {
        return upgrade_elasticsearch_domain.execute(self, allocator, input, options);
    }

    pub fn describeDomainAutoTunesPaginator(self: *Self, params: describe_domain_auto_tunes.DescribeDomainAutoTunesInput) paginator.DescribeDomainAutoTunesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInboundCrossClusterSearchConnectionsPaginator(self: *Self, params: describe_inbound_cross_cluster_search_connections.DescribeInboundCrossClusterSearchConnectionsInput) paginator.DescribeInboundCrossClusterSearchConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeOutboundCrossClusterSearchConnectionsPaginator(self: *Self, params: describe_outbound_cross_cluster_search_connections.DescribeOutboundCrossClusterSearchConnectionsInput) paginator.DescribeOutboundCrossClusterSearchConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describePackagesPaginator(self: *Self, params: describe_packages.DescribePackagesInput) paginator.DescribePackagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReservedElasticsearchInstanceOfferingsPaginator(self: *Self, params: describe_reserved_elasticsearch_instance_offerings.DescribeReservedElasticsearchInstanceOfferingsInput) paginator.DescribeReservedElasticsearchInstanceOfferingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReservedElasticsearchInstancesPaginator(self: *Self, params: describe_reserved_elasticsearch_instances.DescribeReservedElasticsearchInstancesInput) paginator.DescribeReservedElasticsearchInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getPackageVersionHistoryPaginator(self: *Self, params: get_package_version_history.GetPackageVersionHistoryInput) paginator.GetPackageVersionHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getUpgradeHistoryPaginator(self: *Self, params: get_upgrade_history.GetUpgradeHistoryInput) paginator.GetUpgradeHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDomainsForPackagePaginator(self: *Self, params: list_domains_for_package.ListDomainsForPackageInput) paginator.ListDomainsForPackagePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listElasticsearchInstanceTypesPaginator(self: *Self, params: list_elasticsearch_instance_types.ListElasticsearchInstanceTypesInput) paginator.ListElasticsearchInstanceTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listElasticsearchVersionsPaginator(self: *Self, params: list_elasticsearch_versions.ListElasticsearchVersionsInput) paginator.ListElasticsearchVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPackagesForDomainPaginator(self: *Self, params: list_packages_for_domain.ListPackagesForDomainInput) paginator.ListPackagesForDomainPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
