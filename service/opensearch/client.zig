const aws = @import("aws");
const std = @import("std");

const accept_inbound_connection = @import("accept_inbound_connection.zig");
const add_data_source = @import("add_data_source.zig");
const add_direct_query_data_source = @import("add_direct_query_data_source.zig");
const add_tags = @import("add_tags.zig");
const associate_package = @import("associate_package.zig");
const associate_packages = @import("associate_packages.zig");
const authorize_vpc_endpoint_access = @import("authorize_vpc_endpoint_access.zig");
const cancel_domain_config_change = @import("cancel_domain_config_change.zig");
const cancel_service_software_update = @import("cancel_service_software_update.zig");
const create_application = @import("create_application.zig");
const create_domain = @import("create_domain.zig");
const create_index = @import("create_index.zig");
const create_outbound_connection = @import("create_outbound_connection.zig");
const create_package = @import("create_package.zig");
const create_vpc_endpoint = @import("create_vpc_endpoint.zig");
const delete_application = @import("delete_application.zig");
const delete_data_source = @import("delete_data_source.zig");
const delete_direct_query_data_source = @import("delete_direct_query_data_source.zig");
const delete_domain = @import("delete_domain.zig");
const delete_inbound_connection = @import("delete_inbound_connection.zig");
const delete_index = @import("delete_index.zig");
const delete_outbound_connection = @import("delete_outbound_connection.zig");
const delete_package = @import("delete_package.zig");
const delete_vpc_endpoint = @import("delete_vpc_endpoint.zig");
const describe_domain = @import("describe_domain.zig");
const describe_domain_auto_tunes = @import("describe_domain_auto_tunes.zig");
const describe_domain_change_progress = @import("describe_domain_change_progress.zig");
const describe_domain_config = @import("describe_domain_config.zig");
const describe_domain_health = @import("describe_domain_health.zig");
const describe_domain_nodes = @import("describe_domain_nodes.zig");
const describe_domains = @import("describe_domains.zig");
const describe_dry_run_progress = @import("describe_dry_run_progress.zig");
const describe_inbound_connections = @import("describe_inbound_connections.zig");
const describe_instance_type_limits = @import("describe_instance_type_limits.zig");
const describe_outbound_connections = @import("describe_outbound_connections.zig");
const describe_packages = @import("describe_packages.zig");
const describe_reserved_instance_offerings = @import("describe_reserved_instance_offerings.zig");
const describe_reserved_instances = @import("describe_reserved_instances.zig");
const describe_vpc_endpoints = @import("describe_vpc_endpoints.zig");
const dissociate_package = @import("dissociate_package.zig");
const dissociate_packages = @import("dissociate_packages.zig");
const get_application = @import("get_application.zig");
const get_compatible_versions = @import("get_compatible_versions.zig");
const get_data_source = @import("get_data_source.zig");
const get_default_application_setting = @import("get_default_application_setting.zig");
const get_direct_query_data_source = @import("get_direct_query_data_source.zig");
const get_domain_maintenance_status = @import("get_domain_maintenance_status.zig");
const get_index = @import("get_index.zig");
const get_package_version_history = @import("get_package_version_history.zig");
const get_upgrade_history = @import("get_upgrade_history.zig");
const get_upgrade_status = @import("get_upgrade_status.zig");
const list_applications = @import("list_applications.zig");
const list_data_sources = @import("list_data_sources.zig");
const list_direct_query_data_sources = @import("list_direct_query_data_sources.zig");
const list_domain_maintenances = @import("list_domain_maintenances.zig");
const list_domain_names = @import("list_domain_names.zig");
const list_domains_for_package = @import("list_domains_for_package.zig");
const list_instance_type_details = @import("list_instance_type_details.zig");
const list_packages_for_domain = @import("list_packages_for_domain.zig");
const list_scheduled_actions = @import("list_scheduled_actions.zig");
const list_tags = @import("list_tags.zig");
const list_versions = @import("list_versions.zig");
const list_vpc_endpoint_access = @import("list_vpc_endpoint_access.zig");
const list_vpc_endpoints = @import("list_vpc_endpoints.zig");
const list_vpc_endpoints_for_domain = @import("list_vpc_endpoints_for_domain.zig");
const purchase_reserved_instance_offering = @import("purchase_reserved_instance_offering.zig");
const put_default_application_setting = @import("put_default_application_setting.zig");
const reject_inbound_connection = @import("reject_inbound_connection.zig");
const remove_tags = @import("remove_tags.zig");
const revoke_vpc_endpoint_access = @import("revoke_vpc_endpoint_access.zig");
const start_domain_maintenance = @import("start_domain_maintenance.zig");
const start_service_software_update = @import("start_service_software_update.zig");
const update_application = @import("update_application.zig");
const update_data_source = @import("update_data_source.zig");
const update_direct_query_data_source = @import("update_direct_query_data_source.zig");
const update_domain_config = @import("update_domain_config.zig");
const update_index = @import("update_index.zig");
const update_package = @import("update_package.zig");
const update_package_scope = @import("update_package_scope.zig");
const update_scheduled_action = @import("update_scheduled_action.zig");
const update_vpc_endpoint = @import("update_vpc_endpoint.zig");
const upgrade_domain = @import("upgrade_domain.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "OpenSearch";

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

    /// Allows the destination Amazon OpenSearch Service domain owner to accept an
    /// inbound
    /// cross-cluster search connection request. For more information, see
    /// [Cross-cluster search for Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/cross-cluster-search.html).
    pub fn acceptInboundConnection(self: *Self, allocator: std.mem.Allocator, input: accept_inbound_connection.AcceptInboundConnectionInput, options: accept_inbound_connection.Options) !accept_inbound_connection.AcceptInboundConnectionOutput {
        return accept_inbound_connection.execute(self, allocator, input, options);
    }

    /// Creates a new direct-query data source to the specified domain. For more
    /// information,
    /// see [Creating Amazon OpenSearch Service data source integrations with Amazon
    /// S3](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/direct-query-s3-creating.html).
    pub fn addDataSource(self: *Self, allocator: std.mem.Allocator, input: add_data_source.AddDataSourceInput, options: add_data_source.Options) !add_data_source.AddDataSourceOutput {
        return add_data_source.execute(self, allocator, input, options);
    }

    /// Adds a new data source in Amazon OpenSearch Service so that you can perform
    /// direct
    /// queries on external data.
    pub fn addDirectQueryDataSource(self: *Self, allocator: std.mem.Allocator, input: add_direct_query_data_source.AddDirectQueryDataSourceInput, options: add_direct_query_data_source.Options) !add_direct_query_data_source.AddDirectQueryDataSourceOutput {
        return add_direct_query_data_source.execute(self, allocator, input, options);
    }

    /// Attaches tags to an existing Amazon OpenSearch Service domain, data source,
    /// or
    /// application.
    ///
    /// Tags are a set of case-sensitive key-value pairs. A domain, data source, or
    /// application can have up to 10 tags. For more information, see [Tagging
    /// Amazon OpenSearch Service
    /// resources](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-awsresourcetagging.html).
    pub fn addTags(self: *Self, allocator: std.mem.Allocator, input: add_tags.AddTagsInput, options: add_tags.Options) !add_tags.AddTagsOutput {
        return add_tags.execute(self, allocator, input, options);
    }

    /// Associates a package with an Amazon OpenSearch Service domain. For more
    /// information,
    /// see [Custom packages
    /// for Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/custom-packages.html).
    pub fn associatePackage(self: *Self, allocator: std.mem.Allocator, input: associate_package.AssociatePackageInput, options: associate_package.Options) !associate_package.AssociatePackageOutput {
        return associate_package.execute(self, allocator, input, options);
    }

    /// Operation in the Amazon OpenSearch Service API for associating multiple
    /// packages with
    /// a domain simultaneously.
    pub fn associatePackages(self: *Self, allocator: std.mem.Allocator, input: associate_packages.AssociatePackagesInput, options: associate_packages.Options) !associate_packages.AssociatePackagesOutput {
        return associate_packages.execute(self, allocator, input, options);
    }

    /// Provides access to an Amazon OpenSearch Service domain through the use of an
    /// interface
    /// VPC endpoint.
    pub fn authorizeVpcEndpointAccess(self: *Self, allocator: std.mem.Allocator, input: authorize_vpc_endpoint_access.AuthorizeVpcEndpointAccessInput, options: authorize_vpc_endpoint_access.Options) !authorize_vpc_endpoint_access.AuthorizeVpcEndpointAccessOutput {
        return authorize_vpc_endpoint_access.execute(self, allocator, input, options);
    }

    /// Cancels a pending configuration change on an Amazon OpenSearch Service
    /// domain.
    pub fn cancelDomainConfigChange(self: *Self, allocator: std.mem.Allocator, input: cancel_domain_config_change.CancelDomainConfigChangeInput, options: cancel_domain_config_change.Options) !cancel_domain_config_change.CancelDomainConfigChangeOutput {
        return cancel_domain_config_change.execute(self, allocator, input, options);
    }

    /// Cancels a scheduled service software update for an Amazon OpenSearch Service
    /// domain.
    /// You can only perform this operation before the `AutomatedUpdateDate` and
    /// when
    /// the domain's `UpdateStatus` is `PENDING_UPDATE`. For more
    /// information, see [Service
    /// software updates in Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/service-software.html).
    pub fn cancelServiceSoftwareUpdate(self: *Self, allocator: std.mem.Allocator, input: cancel_service_software_update.CancelServiceSoftwareUpdateInput, options: cancel_service_software_update.Options) !cancel_service_software_update.CancelServiceSoftwareUpdateOutput {
        return cancel_service_software_update.execute(self, allocator, input, options);
    }

    /// Creates an OpenSearch UI application. For more information, see [Using the
    /// OpenSearch user interface in Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/application.html).
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: create_application.Options) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Creates an Amazon OpenSearch Service domain. For more information, see
    /// [Creating and
    /// managing Amazon OpenSearch Service
    /// domains](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/createupdatedomains.html).
    pub fn createDomain(self: *Self, allocator: std.mem.Allocator, input: create_domain.CreateDomainInput, options: create_domain.Options) !create_domain.CreateDomainOutput {
        return create_domain.execute(self, allocator, input, options);
    }

    /// Creates an OpenSearch index with optional automatic semantic enrichment for
    /// specified text fields. Automatic semantic enrichment enables semantic search
    /// capabilities without requiring machine learning expertise, improving search
    /// relevance by up to 20% by understanding search intent and contextual meaning
    /// beyond keyword matching. The semantic enrichment process has zero impact on
    /// search latency as sparse encodings are stored directly within the index
    /// during indexing. For more information, see [Automatic semantic
    /// enrichment](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/opensearch-semantic-enrichment.html).
    pub fn createIndex(self: *Self, allocator: std.mem.Allocator, input: create_index.CreateIndexInput, options: create_index.Options) !create_index.CreateIndexOutput {
        return create_index.execute(self, allocator, input, options);
    }

    /// Creates a new cross-cluster search connection from a source Amazon
    /// OpenSearch Service domain
    /// to a destination domain. For more information, see [Cross-cluster search
    /// for Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/cross-cluster-search.html).
    pub fn createOutboundConnection(self: *Self, allocator: std.mem.Allocator, input: create_outbound_connection.CreateOutboundConnectionInput, options: create_outbound_connection.Options) !create_outbound_connection.CreateOutboundConnectionOutput {
        return create_outbound_connection.execute(self, allocator, input, options);
    }

    /// Creates a package for use with Amazon OpenSearch Service domains. For more
    /// information, see [Custom packages
    /// for Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/custom-packages.html).
    pub fn createPackage(self: *Self, allocator: std.mem.Allocator, input: create_package.CreatePackageInput, options: create_package.Options) !create_package.CreatePackageOutput {
        return create_package.execute(self, allocator, input, options);
    }

    /// Creates an Amazon OpenSearch Service-managed VPC endpoint.
    pub fn createVpcEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_vpc_endpoint.CreateVpcEndpointInput, options: create_vpc_endpoint.Options) !create_vpc_endpoint.CreateVpcEndpointOutput {
        return create_vpc_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes a specified OpenSearch application.
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: delete_application.Options) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Deletes a direct-query data source. For more information, see [Deleting
    /// an Amazon OpenSearch Service data source with Amazon
    /// S3](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/direct-query-s3-delete.html).
    pub fn deleteDataSource(self: *Self, allocator: std.mem.Allocator, input: delete_data_source.DeleteDataSourceInput, options: delete_data_source.Options) !delete_data_source.DeleteDataSourceOutput {
        return delete_data_source.execute(self, allocator, input, options);
    }

    /// Deletes a previously configured direct query data source from Amazon
    /// OpenSearch
    /// Service.
    pub fn deleteDirectQueryDataSource(self: *Self, allocator: std.mem.Allocator, input: delete_direct_query_data_source.DeleteDirectQueryDataSourceInput, options: delete_direct_query_data_source.Options) !delete_direct_query_data_source.DeleteDirectQueryDataSourceOutput {
        return delete_direct_query_data_source.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon OpenSearch Service domain and all of its data. You can't
    /// recover a
    /// domain after you delete it.
    pub fn deleteDomain(self: *Self, allocator: std.mem.Allocator, input: delete_domain.DeleteDomainInput, options: delete_domain.Options) !delete_domain.DeleteDomainOutput {
        return delete_domain.execute(self, allocator, input, options);
    }

    /// Allows the destination Amazon OpenSearch Service domain owner to delete an
    /// existing
    /// inbound cross-cluster search connection. For more information, see
    /// [Cross-cluster search for Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/cross-cluster-search.html).
    pub fn deleteInboundConnection(self: *Self, allocator: std.mem.Allocator, input: delete_inbound_connection.DeleteInboundConnectionInput, options: delete_inbound_connection.Options) !delete_inbound_connection.DeleteInboundConnectionOutput {
        return delete_inbound_connection.execute(self, allocator, input, options);
    }

    /// Deletes an OpenSearch index. This operation permanently removes the index
    /// and cannot be undone.
    pub fn deleteIndex(self: *Self, allocator: std.mem.Allocator, input: delete_index.DeleteIndexInput, options: delete_index.Options) !delete_index.DeleteIndexOutput {
        return delete_index.execute(self, allocator, input, options);
    }

    /// Allows the source Amazon OpenSearch Service domain owner to delete an
    /// existing
    /// outbound cross-cluster search connection. For more information, see
    /// [Cross-cluster search for Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/cross-cluster-search.html).
    pub fn deleteOutboundConnection(self: *Self, allocator: std.mem.Allocator, input: delete_outbound_connection.DeleteOutboundConnectionInput, options: delete_outbound_connection.Options) !delete_outbound_connection.DeleteOutboundConnectionOutput {
        return delete_outbound_connection.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon OpenSearch Service package. For more information, see
    /// [Custom packages
    /// for Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/custom-packages.html).
    pub fn deletePackage(self: *Self, allocator: std.mem.Allocator, input: delete_package.DeletePackageInput, options: delete_package.Options) !delete_package.DeletePackageOutput {
        return delete_package.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon OpenSearch Service-managed interface VPC endpoint.
    pub fn deleteVpcEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_vpc_endpoint.DeleteVpcEndpointInput, options: delete_vpc_endpoint.Options) !delete_vpc_endpoint.DeleteVpcEndpointOutput {
        return delete_vpc_endpoint.execute(self, allocator, input, options);
    }

    /// Describes the domain configuration for the specified Amazon OpenSearch
    /// Service domain,
    /// including the domain ID, domain service endpoint, and domain ARN.
    pub fn describeDomain(self: *Self, allocator: std.mem.Allocator, input: describe_domain.DescribeDomainInput, options: describe_domain.Options) !describe_domain.DescribeDomainOutput {
        return describe_domain.execute(self, allocator, input, options);
    }

    /// Returns the list of optimizations that Auto-Tune has made to an Amazon
    /// OpenSearch
    /// Service domain. For more information, see [Auto-Tune for Amazon
    /// OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/auto-tune.html).
    pub fn describeDomainAutoTunes(self: *Self, allocator: std.mem.Allocator, input: describe_domain_auto_tunes.DescribeDomainAutoTunesInput, options: describe_domain_auto_tunes.Options) !describe_domain_auto_tunes.DescribeDomainAutoTunesOutput {
        return describe_domain_auto_tunes.execute(self, allocator, input, options);
    }

    /// Returns information about the current blue/green deployment happening on an
    /// Amazon
    /// OpenSearch Service domain. For more information, see [Making configuration
    /// changes in Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-configuration-changes.html).
    pub fn describeDomainChangeProgress(self: *Self, allocator: std.mem.Allocator, input: describe_domain_change_progress.DescribeDomainChangeProgressInput, options: describe_domain_change_progress.Options) !describe_domain_change_progress.DescribeDomainChangeProgressOutput {
        return describe_domain_change_progress.execute(self, allocator, input, options);
    }

    /// Returns the configuration of an Amazon OpenSearch Service domain.
    pub fn describeDomainConfig(self: *Self, allocator: std.mem.Allocator, input: describe_domain_config.DescribeDomainConfigInput, options: describe_domain_config.Options) !describe_domain_config.DescribeDomainConfigOutput {
        return describe_domain_config.execute(self, allocator, input, options);
    }

    /// Returns information about domain and node health, the standby Availability
    /// Zone,
    /// number of nodes per Availability Zone, and shard count per node.
    pub fn describeDomainHealth(self: *Self, allocator: std.mem.Allocator, input: describe_domain_health.DescribeDomainHealthInput, options: describe_domain_health.Options) !describe_domain_health.DescribeDomainHealthOutput {
        return describe_domain_health.execute(self, allocator, input, options);
    }

    /// Returns information about domain and nodes, including data nodes, master
    /// nodes,
    /// ultrawarm nodes, Availability Zone(s), standby nodes, node configurations,
    /// and node
    /// states.
    pub fn describeDomainNodes(self: *Self, allocator: std.mem.Allocator, input: describe_domain_nodes.DescribeDomainNodesInput, options: describe_domain_nodes.Options) !describe_domain_nodes.DescribeDomainNodesOutput {
        return describe_domain_nodes.execute(self, allocator, input, options);
    }

    /// Returns domain configuration information about the specified Amazon
    /// OpenSearch Service
    /// domains.
    pub fn describeDomains(self: *Self, allocator: std.mem.Allocator, input: describe_domains.DescribeDomainsInput, options: describe_domains.Options) !describe_domains.DescribeDomainsOutput {
        return describe_domains.execute(self, allocator, input, options);
    }

    /// Describes the progress of a pre-update dry run analysis on an Amazon
    /// OpenSearch
    /// Service domain. For more information, see [Determining whether a change will
    /// cause a blue/green
    /// deployment](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-configuration-changes#dryrun).
    pub fn describeDryRunProgress(self: *Self, allocator: std.mem.Allocator, input: describe_dry_run_progress.DescribeDryRunProgressInput, options: describe_dry_run_progress.Options) !describe_dry_run_progress.DescribeDryRunProgressOutput {
        return describe_dry_run_progress.execute(self, allocator, input, options);
    }

    /// Lists all the inbound cross-cluster search connections for a destination
    /// (remote)
    /// Amazon OpenSearch Service domain. For more information, see [Cross-cluster
    /// search for Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/cross-cluster-search.html).
    pub fn describeInboundConnections(self: *Self, allocator: std.mem.Allocator, input: describe_inbound_connections.DescribeInboundConnectionsInput, options: describe_inbound_connections.Options) !describe_inbound_connections.DescribeInboundConnectionsOutput {
        return describe_inbound_connections.execute(self, allocator, input, options);
    }

    /// Describes the instance count, storage, and master node limits for a given
    /// OpenSearch
    /// or Elasticsearch version and instance type.
    pub fn describeInstanceTypeLimits(self: *Self, allocator: std.mem.Allocator, input: describe_instance_type_limits.DescribeInstanceTypeLimitsInput, options: describe_instance_type_limits.Options) !describe_instance_type_limits.DescribeInstanceTypeLimitsOutput {
        return describe_instance_type_limits.execute(self, allocator, input, options);
    }

    /// Lists all the outbound cross-cluster connections for a local (source) Amazon
    /// OpenSearch Service domain. For more information, see [Cross-cluster search
    /// for Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/cross-cluster-search.html).
    pub fn describeOutboundConnections(self: *Self, allocator: std.mem.Allocator, input: describe_outbound_connections.DescribeOutboundConnectionsInput, options: describe_outbound_connections.Options) !describe_outbound_connections.DescribeOutboundConnectionsOutput {
        return describe_outbound_connections.execute(self, allocator, input, options);
    }

    /// Describes all packages available to OpenSearch Service. For more
    /// information, see
    /// [Custom packages
    /// for Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/custom-packages.html).
    pub fn describePackages(self: *Self, allocator: std.mem.Allocator, input: describe_packages.DescribePackagesInput, options: describe_packages.Options) !describe_packages.DescribePackagesOutput {
        return describe_packages.execute(self, allocator, input, options);
    }

    /// Describes the available Amazon OpenSearch Service Reserved Instance
    /// offerings for a
    /// given Region. For more information, see [Reserved Instances in Amazon
    /// OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/ri.html).
    pub fn describeReservedInstanceOfferings(self: *Self, allocator: std.mem.Allocator, input: describe_reserved_instance_offerings.DescribeReservedInstanceOfferingsInput, options: describe_reserved_instance_offerings.Options) !describe_reserved_instance_offerings.DescribeReservedInstanceOfferingsOutput {
        return describe_reserved_instance_offerings.execute(self, allocator, input, options);
    }

    /// Describes the Amazon OpenSearch Service instances that you have reserved in
    /// a given
    /// Region. For more information, see [Reserved Instances in Amazon
    /// OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/ri.html).
    pub fn describeReservedInstances(self: *Self, allocator: std.mem.Allocator, input: describe_reserved_instances.DescribeReservedInstancesInput, options: describe_reserved_instances.Options) !describe_reserved_instances.DescribeReservedInstancesOutput {
        return describe_reserved_instances.execute(self, allocator, input, options);
    }

    /// Describes one or more Amazon OpenSearch Service-managed VPC endpoints.
    pub fn describeVpcEndpoints(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_endpoints.DescribeVpcEndpointsInput, options: describe_vpc_endpoints.Options) !describe_vpc_endpoints.DescribeVpcEndpointsOutput {
        return describe_vpc_endpoints.execute(self, allocator, input, options);
    }

    /// Removes a package from the specified Amazon OpenSearch Service domain. The
    /// package
    /// can't be in use with any OpenSearch index for the dissociation to succeed.
    /// The package
    /// is still available in OpenSearch Service for association later. For more
    /// information,
    /// see [Custom packages
    /// for Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/custom-packages.html).
    pub fn dissociatePackage(self: *Self, allocator: std.mem.Allocator, input: dissociate_package.DissociatePackageInput, options: dissociate_package.Options) !dissociate_package.DissociatePackageOutput {
        return dissociate_package.execute(self, allocator, input, options);
    }

    /// Dissociates multiple packages from a domain simultaneously.
    pub fn dissociatePackages(self: *Self, allocator: std.mem.Allocator, input: dissociate_packages.DissociatePackagesInput, options: dissociate_packages.Options) !dissociate_packages.DissociatePackagesOutput {
        return dissociate_packages.execute(self, allocator, input, options);
    }

    /// Retrieves the configuration and status of an existing OpenSearch
    /// application.
    pub fn getApplication(self: *Self, allocator: std.mem.Allocator, input: get_application.GetApplicationInput, options: get_application.Options) !get_application.GetApplicationOutput {
        return get_application.execute(self, allocator, input, options);
    }

    /// Returns a map of OpenSearch or Elasticsearch versions and the versions you
    /// can upgrade
    /// them to.
    pub fn getCompatibleVersions(self: *Self, allocator: std.mem.Allocator, input: get_compatible_versions.GetCompatibleVersionsInput, options: get_compatible_versions.Options) !get_compatible_versions.GetCompatibleVersionsOutput {
        return get_compatible_versions.execute(self, allocator, input, options);
    }

    /// Retrieves information about a direct query data source.
    pub fn getDataSource(self: *Self, allocator: std.mem.Allocator, input: get_data_source.GetDataSourceInput, options: get_data_source.Options) !get_data_source.GetDataSourceOutput {
        return get_data_source.execute(self, allocator, input, options);
    }

    /// Gets the ARN of the current default application.
    ///
    /// If the default application isn't set, the operation returns a resource not
    /// found
    /// error.
    pub fn getDefaultApplicationSetting(self: *Self, allocator: std.mem.Allocator, input: get_default_application_setting.GetDefaultApplicationSettingInput, options: get_default_application_setting.Options) !get_default_application_setting.GetDefaultApplicationSettingOutput {
        return get_default_application_setting.execute(self, allocator, input, options);
    }

    /// Returns detailed configuration information for a specific direct query data
    /// source in
    /// Amazon OpenSearch Service.
    pub fn getDirectQueryDataSource(self: *Self, allocator: std.mem.Allocator, input: get_direct_query_data_source.GetDirectQueryDataSourceInput, options: get_direct_query_data_source.Options) !get_direct_query_data_source.GetDirectQueryDataSourceOutput {
        return get_direct_query_data_source.execute(self, allocator, input, options);
    }

    /// The status of the maintenance action.
    pub fn getDomainMaintenanceStatus(self: *Self, allocator: std.mem.Allocator, input: get_domain_maintenance_status.GetDomainMaintenanceStatusInput, options: get_domain_maintenance_status.Options) !get_domain_maintenance_status.GetDomainMaintenanceStatusOutput {
        return get_domain_maintenance_status.execute(self, allocator, input, options);
    }

    /// Retrieves information about an OpenSearch index including its schema and
    /// semantic enrichment configuration. Use this operation to view the current
    /// index structure and semantic search settings.
    pub fn getIndex(self: *Self, allocator: std.mem.Allocator, input: get_index.GetIndexInput, options: get_index.Options) !get_index.GetIndexOutput {
        return get_index.execute(self, allocator, input, options);
    }

    /// Returns a list of Amazon OpenSearch Service package versions, along with
    /// their creation
    /// time, commit message, and plugin properties (if the package is a zip plugin
    /// package). For more
    /// information, see [Custom packages for Amazon
    /// OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/custom-packages.html).
    pub fn getPackageVersionHistory(self: *Self, allocator: std.mem.Allocator, input: get_package_version_history.GetPackageVersionHistoryInput, options: get_package_version_history.Options) !get_package_version_history.GetPackageVersionHistoryOutput {
        return get_package_version_history.execute(self, allocator, input, options);
    }

    /// Retrieves the complete history of the last 10 upgrades performed on an
    /// Amazon OpenSearch
    /// Service domain.
    pub fn getUpgradeHistory(self: *Self, allocator: std.mem.Allocator, input: get_upgrade_history.GetUpgradeHistoryInput, options: get_upgrade_history.Options) !get_upgrade_history.GetUpgradeHistoryOutput {
        return get_upgrade_history.execute(self, allocator, input, options);
    }

    /// Returns the most recent status of the last upgrade or upgrade eligibility
    /// check performed on
    /// an Amazon OpenSearch Service domain.
    pub fn getUpgradeStatus(self: *Self, allocator: std.mem.Allocator, input: get_upgrade_status.GetUpgradeStatusInput, options: get_upgrade_status.Options) !get_upgrade_status.GetUpgradeStatusOutput {
        return get_upgrade_status.execute(self, allocator, input, options);
    }

    /// Lists all OpenSearch applications under your account.
    pub fn listApplications(self: *Self, allocator: std.mem.Allocator, input: list_applications.ListApplicationsInput, options: list_applications.Options) !list_applications.ListApplicationsOutput {
        return list_applications.execute(self, allocator, input, options);
    }

    /// Lists direct-query data sources for a specific domain. For more information,
    /// see For
    /// more information, see [Working with
    /// Amazon OpenSearch Service direct queries with Amazon
    /// S3](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/direct-query-s3.html).
    pub fn listDataSources(self: *Self, allocator: std.mem.Allocator, input: list_data_sources.ListDataSourcesInput, options: list_data_sources.Options) !list_data_sources.ListDataSourcesOutput {
        return list_data_sources.execute(self, allocator, input, options);
    }

    /// Lists an inventory of all the direct query data sources that you have
    /// configured
    /// within Amazon OpenSearch Service.
    pub fn listDirectQueryDataSources(self: *Self, allocator: std.mem.Allocator, input: list_direct_query_data_sources.ListDirectQueryDataSourcesInput, options: list_direct_query_data_sources.Options) !list_direct_query_data_sources.ListDirectQueryDataSourcesOutput {
        return list_direct_query_data_sources.execute(self, allocator, input, options);
    }

    /// A list of maintenance actions for the domain.
    pub fn listDomainMaintenances(self: *Self, allocator: std.mem.Allocator, input: list_domain_maintenances.ListDomainMaintenancesInput, options: list_domain_maintenances.Options) !list_domain_maintenances.ListDomainMaintenancesOutput {
        return list_domain_maintenances.execute(self, allocator, input, options);
    }

    /// Returns the names of all Amazon OpenSearch Service domains owned by the
    /// current user
    /// in the active Region.
    pub fn listDomainNames(self: *Self, allocator: std.mem.Allocator, input: list_domain_names.ListDomainNamesInput, options: list_domain_names.Options) !list_domain_names.ListDomainNamesOutput {
        return list_domain_names.execute(self, allocator, input, options);
    }

    /// Lists all Amazon OpenSearch Service domains associated with a given package.
    /// For more
    /// information, see [Custom packages
    /// for Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/custom-packages.html).
    pub fn listDomainsForPackage(self: *Self, allocator: std.mem.Allocator, input: list_domains_for_package.ListDomainsForPackageInput, options: list_domains_for_package.Options) !list_domains_for_package.ListDomainsForPackageOutput {
        return list_domains_for_package.execute(self, allocator, input, options);
    }

    /// Lists all instance types and available features for a given OpenSearch or
    /// Elasticsearch version.
    pub fn listInstanceTypeDetails(self: *Self, allocator: std.mem.Allocator, input: list_instance_type_details.ListInstanceTypeDetailsInput, options: list_instance_type_details.Options) !list_instance_type_details.ListInstanceTypeDetailsOutput {
        return list_instance_type_details.execute(self, allocator, input, options);
    }

    /// Lists all packages associated with an Amazon OpenSearch Service domain. For
    /// more
    /// information, see [Custom packages
    /// for Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/custom-packages.html).
    pub fn listPackagesForDomain(self: *Self, allocator: std.mem.Allocator, input: list_packages_for_domain.ListPackagesForDomainInput, options: list_packages_for_domain.Options) !list_packages_for_domain.ListPackagesForDomainOutput {
        return list_packages_for_domain.execute(self, allocator, input, options);
    }

    /// Retrieves a list of configuration changes that are scheduled for a domain.
    /// These
    /// changes can be [service
    /// software
    /// updates](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/service-software.html) or [blue/green Auto-Tune enhancements](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/auto-tune.html#auto-tune-types).
    pub fn listScheduledActions(self: *Self, allocator: std.mem.Allocator, input: list_scheduled_actions.ListScheduledActionsInput, options: list_scheduled_actions.Options) !list_scheduled_actions.ListScheduledActionsOutput {
        return list_scheduled_actions.execute(self, allocator, input, options);
    }

    /// Returns all resource tags for an Amazon OpenSearch Service domain, data
    /// source, or
    /// application. For more information, see [Tagging Amazon OpenSearch Service
    /// resources](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-awsresourcetagging.html).
    pub fn listTags(self: *Self, allocator: std.mem.Allocator, input: list_tags.ListTagsInput, options: list_tags.Options) !list_tags.ListTagsOutput {
        return list_tags.execute(self, allocator, input, options);
    }

    /// Lists all versions of OpenSearch and Elasticsearch that Amazon OpenSearch
    /// Service
    /// supports.
    pub fn listVersions(self: *Self, allocator: std.mem.Allocator, input: list_versions.ListVersionsInput, options: list_versions.Options) !list_versions.ListVersionsOutput {
        return list_versions.execute(self, allocator, input, options);
    }

    /// Retrieves information about each Amazon Web Services principal that is
    /// allowed to
    /// access a given Amazon OpenSearch Service domain through the use of an
    /// interface VPC
    /// endpoint.
    pub fn listVpcEndpointAccess(self: *Self, allocator: std.mem.Allocator, input: list_vpc_endpoint_access.ListVpcEndpointAccessInput, options: list_vpc_endpoint_access.Options) !list_vpc_endpoint_access.ListVpcEndpointAccessOutput {
        return list_vpc_endpoint_access.execute(self, allocator, input, options);
    }

    /// Retrieves all Amazon OpenSearch Service-managed VPC endpoints in the current
    /// Amazon Web Services account and Region.
    pub fn listVpcEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_vpc_endpoints.ListVpcEndpointsInput, options: list_vpc_endpoints.Options) !list_vpc_endpoints.ListVpcEndpointsOutput {
        return list_vpc_endpoints.execute(self, allocator, input, options);
    }

    /// Retrieves all Amazon OpenSearch Service-managed VPC endpoints associated
    /// with a
    /// particular domain.
    pub fn listVpcEndpointsForDomain(self: *Self, allocator: std.mem.Allocator, input: list_vpc_endpoints_for_domain.ListVpcEndpointsForDomainInput, options: list_vpc_endpoints_for_domain.Options) !list_vpc_endpoints_for_domain.ListVpcEndpointsForDomainOutput {
        return list_vpc_endpoints_for_domain.execute(self, allocator, input, options);
    }

    /// Allows you to purchase Amazon OpenSearch Service Reserved Instances.
    pub fn purchaseReservedInstanceOffering(self: *Self, allocator: std.mem.Allocator, input: purchase_reserved_instance_offering.PurchaseReservedInstanceOfferingInput, options: purchase_reserved_instance_offering.Options) !purchase_reserved_instance_offering.PurchaseReservedInstanceOfferingOutput {
        return purchase_reserved_instance_offering.execute(self, allocator, input, options);
    }

    /// Sets the default application to the application with the specified ARN.
    ///
    /// To remove the default application, use the `GetDefaultApplicationSetting`
    /// operation to get the current default and then call the
    /// `PutDefaultApplicationSetting` with the current applications ARN and the
    /// `setAsDefault` parameter set to `false`.
    pub fn putDefaultApplicationSetting(self: *Self, allocator: std.mem.Allocator, input: put_default_application_setting.PutDefaultApplicationSettingInput, options: put_default_application_setting.Options) !put_default_application_setting.PutDefaultApplicationSettingOutput {
        return put_default_application_setting.execute(self, allocator, input, options);
    }

    /// Allows the remote Amazon OpenSearch Service domain owner to reject an
    /// inbound
    /// cross-cluster connection request.
    pub fn rejectInboundConnection(self: *Self, allocator: std.mem.Allocator, input: reject_inbound_connection.RejectInboundConnectionInput, options: reject_inbound_connection.Options) !reject_inbound_connection.RejectInboundConnectionOutput {
        return reject_inbound_connection.execute(self, allocator, input, options);
    }

    /// Removes the specified set of tags from an Amazon OpenSearch Service domain,
    /// data
    /// source, or application. For more information, see [ Tagging Amazon
    /// OpenSearch Service
    /// resources](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains.html#managedomains-awsresorcetagging).
    pub fn removeTags(self: *Self, allocator: std.mem.Allocator, input: remove_tags.RemoveTagsInput, options: remove_tags.Options) !remove_tags.RemoveTagsOutput {
        return remove_tags.execute(self, allocator, input, options);
    }

    /// Revokes access to an Amazon OpenSearch Service domain that was provided
    /// through an
    /// interface VPC endpoint.
    pub fn revokeVpcEndpointAccess(self: *Self, allocator: std.mem.Allocator, input: revoke_vpc_endpoint_access.RevokeVpcEndpointAccessInput, options: revoke_vpc_endpoint_access.Options) !revoke_vpc_endpoint_access.RevokeVpcEndpointAccessOutput {
        return revoke_vpc_endpoint_access.execute(self, allocator, input, options);
    }

    /// Starts the node maintenance process on the data node. These processes can
    /// include a
    /// node reboot, an Opensearch or Elasticsearch process restart, or a Dashboard
    /// or Kibana
    /// restart.
    pub fn startDomainMaintenance(self: *Self, allocator: std.mem.Allocator, input: start_domain_maintenance.StartDomainMaintenanceInput, options: start_domain_maintenance.Options) !start_domain_maintenance.StartDomainMaintenanceOutput {
        return start_domain_maintenance.execute(self, allocator, input, options);
    }

    /// Schedules a service software update for an Amazon OpenSearch Service domain.
    /// For more
    /// information, see [Service
    /// software updates in Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/service-software.html).
    pub fn startServiceSoftwareUpdate(self: *Self, allocator: std.mem.Allocator, input: start_service_software_update.StartServiceSoftwareUpdateInput, options: start_service_software_update.Options) !start_service_software_update.StartServiceSoftwareUpdateOutput {
        return start_service_software_update.execute(self, allocator, input, options);
    }

    /// Updates the configuration and settings of an existing OpenSearch
    /// application.
    pub fn updateApplication(self: *Self, allocator: std.mem.Allocator, input: update_application.UpdateApplicationInput, options: update_application.Options) !update_application.UpdateApplicationOutput {
        return update_application.execute(self, allocator, input, options);
    }

    /// Updates a direct-query data source. For more information, see [Working
    /// with Amazon OpenSearch Service data source integrations with Amazon
    /// S3](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/direct-query-s3-creating.html).
    pub fn updateDataSource(self: *Self, allocator: std.mem.Allocator, input: update_data_source.UpdateDataSourceInput, options: update_data_source.Options) !update_data_source.UpdateDataSourceOutput {
        return update_data_source.execute(self, allocator, input, options);
    }

    /// Updates the configuration or properties of an existing direct query data
    /// source in
    /// Amazon OpenSearch Service.
    pub fn updateDirectQueryDataSource(self: *Self, allocator: std.mem.Allocator, input: update_direct_query_data_source.UpdateDirectQueryDataSourceInput, options: update_direct_query_data_source.Options) !update_direct_query_data_source.UpdateDirectQueryDataSourceOutput {
        return update_direct_query_data_source.execute(self, allocator, input, options);
    }

    /// Modifies the cluster configuration of the specified Amazon OpenSearch
    /// Service
    /// domain.
    pub fn updateDomainConfig(self: *Self, allocator: std.mem.Allocator, input: update_domain_config.UpdateDomainConfigInput, options: update_domain_config.Options) !update_domain_config.UpdateDomainConfigOutput {
        return update_domain_config.execute(self, allocator, input, options);
    }

    /// Updates an existing OpenSearch index schema and semantic enrichment
    /// configuration. This operation allows modification of field mappings and
    /// semantic search settings for text fields. Changes to semantic enrichment
    /// configuration will apply to newly ingested documents.
    pub fn updateIndex(self: *Self, allocator: std.mem.Allocator, input: update_index.UpdateIndexInput, options: update_index.Options) !update_index.UpdateIndexOutput {
        return update_index.execute(self, allocator, input, options);
    }

    /// Updates a package for use with Amazon OpenSearch Service domains. For more
    /// information, see [Custom packages
    /// for Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/custom-packages.html).
    pub fn updatePackage(self: *Self, allocator: std.mem.Allocator, input: update_package.UpdatePackageInput, options: update_package.Options) !update_package.UpdatePackageOutput {
        return update_package.execute(self, allocator, input, options);
    }

    /// Updates the scope of a package. Scope of the package defines users who can
    /// view and
    /// associate a package.
    pub fn updatePackageScope(self: *Self, allocator: std.mem.Allocator, input: update_package_scope.UpdatePackageScopeInput, options: update_package_scope.Options) !update_package_scope.UpdatePackageScopeOutput {
        return update_package_scope.execute(self, allocator, input, options);
    }

    /// Reschedules a planned domain configuration change for a later time. This
    /// change can be
    /// a scheduled [service
    /// software
    /// update](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/service-software.html) or a [blue/green Auto-Tune enhancement](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/auto-tune.html#auto-tune-types).
    pub fn updateScheduledAction(self: *Self, allocator: std.mem.Allocator, input: update_scheduled_action.UpdateScheduledActionInput, options: update_scheduled_action.Options) !update_scheduled_action.UpdateScheduledActionOutput {
        return update_scheduled_action.execute(self, allocator, input, options);
    }

    /// Modifies an Amazon OpenSearch Service-managed interface VPC endpoint.
    pub fn updateVpcEndpoint(self: *Self, allocator: std.mem.Allocator, input: update_vpc_endpoint.UpdateVpcEndpointInput, options: update_vpc_endpoint.Options) !update_vpc_endpoint.UpdateVpcEndpointOutput {
        return update_vpc_endpoint.execute(self, allocator, input, options);
    }

    /// Allows you to either upgrade your Amazon OpenSearch Service domain or
    /// perform an
    /// upgrade eligibility check to a compatible version of OpenSearch or
    /// Elasticsearch.
    pub fn upgradeDomain(self: *Self, allocator: std.mem.Allocator, input: upgrade_domain.UpgradeDomainInput, options: upgrade_domain.Options) !upgrade_domain.UpgradeDomainOutput {
        return upgrade_domain.execute(self, allocator, input, options);
    }

    pub fn describeDomainAutoTunesPaginator(self: *Self, params: describe_domain_auto_tunes.DescribeDomainAutoTunesInput) paginator.DescribeDomainAutoTunesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInboundConnectionsPaginator(self: *Self, params: describe_inbound_connections.DescribeInboundConnectionsInput) paginator.DescribeInboundConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeOutboundConnectionsPaginator(self: *Self, params: describe_outbound_connections.DescribeOutboundConnectionsInput) paginator.DescribeOutboundConnectionsPaginator {
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

    pub fn describeReservedInstanceOfferingsPaginator(self: *Self, params: describe_reserved_instance_offerings.DescribeReservedInstanceOfferingsInput) paginator.DescribeReservedInstanceOfferingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReservedInstancesPaginator(self: *Self, params: describe_reserved_instances.DescribeReservedInstancesInput) paginator.DescribeReservedInstancesPaginator {
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

    pub fn listApplicationsPaginator(self: *Self, params: list_applications.ListApplicationsInput) paginator.ListApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDomainMaintenancesPaginator(self: *Self, params: list_domain_maintenances.ListDomainMaintenancesInput) paginator.ListDomainMaintenancesPaginator {
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

    pub fn listInstanceTypeDetailsPaginator(self: *Self, params: list_instance_type_details.ListInstanceTypeDetailsInput) paginator.ListInstanceTypeDetailsPaginator {
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

    pub fn listScheduledActionsPaginator(self: *Self, params: list_scheduled_actions.ListScheduledActionsInput) paginator.ListScheduledActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVersionsPaginator(self: *Self, params: list_versions.ListVersionsInput) paginator.ListVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
