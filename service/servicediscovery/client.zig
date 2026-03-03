const aws = @import("aws");
const std = @import("std");

const create_http_namespace = @import("create_http_namespace.zig");
const create_private_dns_namespace = @import("create_private_dns_namespace.zig");
const create_public_dns_namespace = @import("create_public_dns_namespace.zig");
const create_service = @import("create_service.zig");
const delete_namespace = @import("delete_namespace.zig");
const delete_service = @import("delete_service.zig");
const delete_service_attributes = @import("delete_service_attributes.zig");
const deregister_instance = @import("deregister_instance.zig");
const discover_instances = @import("discover_instances.zig");
const discover_instances_revision = @import("discover_instances_revision.zig");
const get_instance = @import("get_instance.zig");
const get_instances_health_status = @import("get_instances_health_status.zig");
const get_namespace = @import("get_namespace.zig");
const get_operation = @import("get_operation.zig");
const get_service = @import("get_service.zig");
const get_service_attributes = @import("get_service_attributes.zig");
const list_instances = @import("list_instances.zig");
const list_namespaces = @import("list_namespaces.zig");
const list_operations = @import("list_operations.zig");
const list_services = @import("list_services.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const register_instance = @import("register_instance.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_http_namespace = @import("update_http_namespace.zig");
const update_instance_custom_health_status = @import("update_instance_custom_health_status.zig");
const update_private_dns_namespace = @import("update_private_dns_namespace.zig");
const update_public_dns_namespace = @import("update_public_dns_namespace.zig");
const update_service = @import("update_service.zig");
const update_service_attributes = @import("update_service_attributes.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ServiceDiscovery";

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

    /// Creates an HTTP namespace. Service instances registered using an HTTP
    /// namespace can be
    /// discovered using a `DiscoverInstances` request but can't be discovered using
    /// DNS.
    ///
    /// For the current quota on the number of namespaces that you can create using
    /// the same Amazon Web Services account, see [Cloud Map
    /// quotas](https://docs.aws.amazon.com/cloud-map/latest/dg/cloud-map-limits.html) in the
    /// *Cloud Map Developer Guide*.
    pub fn createHttpNamespace(self: *Self, allocator: std.mem.Allocator, input: create_http_namespace.CreateHttpNamespaceInput, options: create_http_namespace.Options) !create_http_namespace.CreateHttpNamespaceOutput {
        return create_http_namespace.execute(self, allocator, input, options);
    }

    /// Creates a private namespace based on DNS, which is visible only inside a
    /// specified Amazon
    /// VPC. The namespace defines your service naming scheme. For example, if you
    /// name your namespace
    /// `example.com` and name your service `backend`, the resulting DNS name for
    /// the service is `backend.example.com`. Service instances that are registered
    /// using a
    /// private DNS namespace can be discovered using either a `DiscoverInstances`
    /// request or
    /// using DNS. For the current quota on the number of namespaces that you can
    /// create using the same
    /// Amazon Web Services account, see [Cloud Map
    /// quotas](https://docs.aws.amazon.com/cloud-map/latest/dg/cloud-map-limits.html) in the
    /// *Cloud Map Developer Guide*.
    pub fn createPrivateDnsNamespace(self: *Self, allocator: std.mem.Allocator, input: create_private_dns_namespace.CreatePrivateDnsNamespaceInput, options: create_private_dns_namespace.Options) !create_private_dns_namespace.CreatePrivateDnsNamespaceOutput {
        return create_private_dns_namespace.execute(self, allocator, input, options);
    }

    /// Creates a public namespace based on DNS, which is visible on the internet.
    /// The namespace
    /// defines your service naming scheme. For example, if you name your namespace
    /// `example.com` and name your service `backend`, the resulting DNS name for
    /// the service is `backend.example.com`. You can discover instances that were
    /// registered
    /// with a public DNS namespace by using either a `DiscoverInstances` request or
    /// using
    /// DNS. For the current quota on the number of namespaces that you can create
    /// using the same Amazon Web Services account, see [Cloud Map
    /// quotas](https://docs.aws.amazon.com/cloud-map/latest/dg/cloud-map-limits.html) in the
    /// *Cloud Map Developer Guide*.
    ///
    /// The `CreatePublicDnsNamespace` API operation is not supported in the Amazon
    /// Web Services GovCloud (US) Regions.
    pub fn createPublicDnsNamespace(self: *Self, allocator: std.mem.Allocator, input: create_public_dns_namespace.CreatePublicDnsNamespaceInput, options: create_public_dns_namespace.Options) !create_public_dns_namespace.CreatePublicDnsNamespaceOutput {
        return create_public_dns_namespace.execute(self, allocator, input, options);
    }

    /// Creates a service. This action defines the configuration for the following
    /// entities:
    ///
    /// * For public and private DNS namespaces, one of the following combinations
    ///   of DNS records in
    /// Amazon Route 53:
    ///
    /// * `A`
    ///
    /// * `AAAA`
    ///
    /// * `A` and `AAAA`
    ///
    /// * `SRV`
    ///
    /// * `CNAME`
    ///
    /// * Optionally, a health check
    ///
    /// After you create the service, you can submit a
    /// [RegisterInstance](https://docs.aws.amazon.com/cloud-map/latest/api/API_RegisterInstance.html) request, and
    /// Cloud Map uses the values in the configuration to create the specified
    /// entities.
    ///
    /// For the current quota on the number of instances that you can register using
    /// the same
    /// namespace and using the same service, see [Cloud Map
    /// quotas](https://docs.aws.amazon.com/cloud-map/latest/dg/cloud-map-limits.html) in the
    /// *Cloud Map Developer Guide*.
    pub fn createService(self: *Self, allocator: std.mem.Allocator, input: create_service.CreateServiceInput, options: create_service.Options) !create_service.CreateServiceOutput {
        return create_service.execute(self, allocator, input, options);
    }

    /// Deletes a namespace from the current account. If the namespace still
    /// contains one or more
    /// services, the request fails.
    pub fn deleteNamespace(self: *Self, allocator: std.mem.Allocator, input: delete_namespace.DeleteNamespaceInput, options: delete_namespace.Options) !delete_namespace.DeleteNamespaceOutput {
        return delete_namespace.execute(self, allocator, input, options);
    }

    /// Deletes a specified service and all associated service attributes. If the
    /// service still
    /// contains one or more registered instances, the request fails.
    pub fn deleteService(self: *Self, allocator: std.mem.Allocator, input: delete_service.DeleteServiceInput, options: delete_service.Options) !delete_service.DeleteServiceOutput {
        return delete_service.execute(self, allocator, input, options);
    }

    /// Deletes specific attributes associated with a service.
    pub fn deleteServiceAttributes(self: *Self, allocator: std.mem.Allocator, input: delete_service_attributes.DeleteServiceAttributesInput, options: delete_service_attributes.Options) !delete_service_attributes.DeleteServiceAttributesOutput {
        return delete_service_attributes.execute(self, allocator, input, options);
    }

    /// Deletes the Amazon Route 53 DNS records and health check, if any, that Cloud
    /// Map created for the
    /// specified instance.
    pub fn deregisterInstance(self: *Self, allocator: std.mem.Allocator, input: deregister_instance.DeregisterInstanceInput, options: deregister_instance.Options) !deregister_instance.DeregisterInstanceOutput {
        return deregister_instance.execute(self, allocator, input, options);
    }

    /// Discovers registered instances for a specified namespace and service. You
    /// can use
    /// `DiscoverInstances` to discover instances for any type of namespace.
    /// `DiscoverInstances` returns a randomized list of instances allowing
    /// customers to
    /// distribute traffic evenly across instances. For public and private DNS
    /// namespaces, you can also
    /// use DNS queries to discover instances.
    pub fn discoverInstances(self: *Self, allocator: std.mem.Allocator, input: discover_instances.DiscoverInstancesInput, options: discover_instances.Options) !discover_instances.DiscoverInstancesOutput {
        return discover_instances.execute(self, allocator, input, options);
    }

    /// Discovers the increasing revision associated with an instance.
    pub fn discoverInstancesRevision(self: *Self, allocator: std.mem.Allocator, input: discover_instances_revision.DiscoverInstancesRevisionInput, options: discover_instances_revision.Options) !discover_instances_revision.DiscoverInstancesRevisionOutput {
        return discover_instances_revision.execute(self, allocator, input, options);
    }

    /// Gets information about a specified instance.
    pub fn getInstance(self: *Self, allocator: std.mem.Allocator, input: get_instance.GetInstanceInput, options: get_instance.Options) !get_instance.GetInstanceOutput {
        return get_instance.execute(self, allocator, input, options);
    }

    /// Gets the current health status (`Healthy`, `Unhealthy`, or
    /// `Unknown`) of one or more instances that are associated with a specified
    /// service.
    ///
    /// There's a brief delay between when you register an instance and when the
    /// health status for
    /// the instance is available.
    pub fn getInstancesHealthStatus(self: *Self, allocator: std.mem.Allocator, input: get_instances_health_status.GetInstancesHealthStatusInput, options: get_instances_health_status.Options) !get_instances_health_status.GetInstancesHealthStatusOutput {
        return get_instances_health_status.execute(self, allocator, input, options);
    }

    /// Gets information about a namespace.
    pub fn getNamespace(self: *Self, allocator: std.mem.Allocator, input: get_namespace.GetNamespaceInput, options: get_namespace.Options) !get_namespace.GetNamespaceOutput {
        return get_namespace.execute(self, allocator, input, options);
    }

    /// Gets information about any operation that returns an operation ID in the
    /// response, such as a
    /// `CreateHttpNamespace` request.
    ///
    /// To get a list of operations that match specified criteria, see
    /// [ListOperations](https://docs.aws.amazon.com/cloud-map/latest/api/API_ListOperations.html).
    pub fn getOperation(self: *Self, allocator: std.mem.Allocator, input: get_operation.GetOperationInput, options: get_operation.Options) !get_operation.GetOperationOutput {
        return get_operation.execute(self, allocator, input, options);
    }

    /// Gets the settings for a specified service.
    pub fn getService(self: *Self, allocator: std.mem.Allocator, input: get_service.GetServiceInput, options: get_service.Options) !get_service.GetServiceOutput {
        return get_service.execute(self, allocator, input, options);
    }

    /// Returns the attributes associated with a specified service.
    pub fn getServiceAttributes(self: *Self, allocator: std.mem.Allocator, input: get_service_attributes.GetServiceAttributesInput, options: get_service_attributes.Options) !get_service_attributes.GetServiceAttributesOutput {
        return get_service_attributes.execute(self, allocator, input, options);
    }

    /// Lists summary information about the instances that you registered by using a
    /// specified
    /// service.
    pub fn listInstances(self: *Self, allocator: std.mem.Allocator, input: list_instances.ListInstancesInput, options: list_instances.Options) !list_instances.ListInstancesOutput {
        return list_instances.execute(self, allocator, input, options);
    }

    /// Lists summary information about the namespaces that were created by the
    /// current Amazon Web Services account and shared with the current Amazon Web
    /// Services account.
    pub fn listNamespaces(self: *Self, allocator: std.mem.Allocator, input: list_namespaces.ListNamespacesInput, options: list_namespaces.Options) !list_namespaces.ListNamespacesOutput {
        return list_namespaces.execute(self, allocator, input, options);
    }

    /// Lists operations that match the criteria that you specify.
    pub fn listOperations(self: *Self, allocator: std.mem.Allocator, input: list_operations.ListOperationsInput, options: list_operations.Options) !list_operations.ListOperationsOutput {
        return list_operations.execute(self, allocator, input, options);
    }

    /// Lists summary information for all the services that are associated with one
    /// or more
    /// namespaces.
    pub fn listServices(self: *Self, allocator: std.mem.Allocator, input: list_services.ListServicesInput, options: list_services.Options) !list_services.ListServicesOutput {
        return list_services.execute(self, allocator, input, options);
    }

    /// Lists tags for the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates or updates one or more records and, optionally, creates a health
    /// check based on the
    /// settings in a specified service. When you submit a `RegisterInstance`
    /// request, the
    /// following occurs:
    ///
    /// * For each DNS record that you define in the service that's specified by
    /// `ServiceId`, a record is created or updated in the hosted zone that's
    /// associated
    /// with the corresponding namespace.
    ///
    /// * If the service includes `HealthCheckConfig`, a health check is created
    ///   based on
    /// the settings in the health check configuration.
    ///
    /// * The health check, if any, is associated with each of the new or updated
    ///   records.
    ///
    /// One `RegisterInstance` request must complete before you can submit another
    /// request and specify the same service ID and instance ID.
    ///
    /// For more information, see
    /// [CreateService](https://docs.aws.amazon.com/cloud-map/latest/api/API_CreateService.html).
    ///
    /// When Cloud Map receives a DNS query for the specified DNS name, it returns
    /// the applicable
    /// value:
    ///
    /// * **If the health check is healthy**: returns all the
    /// records
    ///
    /// * **If the health check is unhealthy**: returns the applicable
    /// value for the last healthy instance
    ///
    /// * **If you didn't specify a health check configuration**:
    /// returns all the records
    ///
    /// For the current quota on the number of instances that you can register using
    /// the same
    /// namespace and using the same service, see [Cloud Map
    /// quotas](https://docs.aws.amazon.com/cloud-map/latest/dg/cloud-map-limits.html) in the
    /// *Cloud Map Developer Guide*.
    pub fn registerInstance(self: *Self, allocator: std.mem.Allocator, input: register_instance.RegisterInstanceInput, options: register_instance.Options) !register_instance.RegisterInstanceOutput {
        return register_instance.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an HTTP
    /// namespace.
    pub fn updateHttpNamespace(self: *Self, allocator: std.mem.Allocator, input: update_http_namespace.UpdateHttpNamespaceInput, options: update_http_namespace.Options) !update_http_namespace.UpdateHttpNamespaceOutput {
        return update_http_namespace.execute(self, allocator, input, options);
    }

    /// Submits a request to change the health status of a custom health check to
    /// healthy or
    /// unhealthy.
    ///
    /// You can use `UpdateInstanceCustomHealthStatus` to change the status only for
    /// custom health checks, which you define using `HealthCheckCustomConfig` when
    /// you create
    /// a service. You can't use it to change the status for Route 53 health checks,
    /// which you define using
    /// `HealthCheckConfig`.
    ///
    /// For more information, see
    /// [HealthCheckCustomConfig](https://docs.aws.amazon.com/cloud-map/latest/api/API_HealthCheckCustomConfig.html).
    pub fn updateInstanceCustomHealthStatus(self: *Self, allocator: std.mem.Allocator, input: update_instance_custom_health_status.UpdateInstanceCustomHealthStatusInput, options: update_instance_custom_health_status.Options) !update_instance_custom_health_status.UpdateInstanceCustomHealthStatusOutput {
        return update_instance_custom_health_status.execute(self, allocator, input, options);
    }

    /// Updates a private DNS
    /// namespace.
    pub fn updatePrivateDnsNamespace(self: *Self, allocator: std.mem.Allocator, input: update_private_dns_namespace.UpdatePrivateDnsNamespaceInput, options: update_private_dns_namespace.Options) !update_private_dns_namespace.UpdatePrivateDnsNamespaceOutput {
        return update_private_dns_namespace.execute(self, allocator, input, options);
    }

    /// Updates a public DNS namespace.
    pub fn updatePublicDnsNamespace(self: *Self, allocator: std.mem.Allocator, input: update_public_dns_namespace.UpdatePublicDnsNamespaceInput, options: update_public_dns_namespace.Options) !update_public_dns_namespace.UpdatePublicDnsNamespaceOutput {
        return update_public_dns_namespace.execute(self, allocator, input, options);
    }

    /// Submits a request to perform the following operations:
    ///
    /// * Update the TTL setting for existing `DnsRecords` configurations
    ///
    /// * Add, update, or delete `HealthCheckConfig` for a specified service
    ///
    /// You can't add, update, or delete a `HealthCheckCustomConfig`
    /// configuration.
    ///
    /// For public and private DNS namespaces, note the following:
    ///
    /// * If you omit any existing `DnsRecords` or `HealthCheckConfig`
    /// configurations from an `UpdateService` request, the configurations are
    /// deleted from
    /// the service.
    ///
    /// * If you omit an existing `HealthCheckCustomConfig` configuration from an
    /// `UpdateService` request, the configuration isn't deleted from the service.
    ///
    /// You can't call `UpdateService` and update settings in the following
    /// scenarios:
    ///
    /// * When the service is associated with an HTTP namespace
    ///
    /// * When the service is associated with a shared namespace and contains
    ///   instances that were
    /// registered by Amazon Web Services accounts other than the account making the
    /// `UpdateService`
    /// call
    ///
    /// When you update settings for a service, Cloud Map also updates the
    /// corresponding settings
    /// in all the records and health checks that were created by using the
    /// specified service.
    pub fn updateService(self: *Self, allocator: std.mem.Allocator, input: update_service.UpdateServiceInput, options: update_service.Options) !update_service.UpdateServiceOutput {
        return update_service.execute(self, allocator, input, options);
    }

    /// Submits a request to update a specified service to add service-level
    /// attributes.
    pub fn updateServiceAttributes(self: *Self, allocator: std.mem.Allocator, input: update_service_attributes.UpdateServiceAttributesInput, options: update_service_attributes.Options) !update_service_attributes.UpdateServiceAttributesOutput {
        return update_service_attributes.execute(self, allocator, input, options);
    }

    pub fn getInstancesHealthStatusPaginator(self: *Self, params: get_instances_health_status.GetInstancesHealthStatusInput) paginator.GetInstancesHealthStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInstancesPaginator(self: *Self, params: list_instances.ListInstancesInput) paginator.ListInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNamespacesPaginator(self: *Self, params: list_namespaces.ListNamespacesInput) paginator.ListNamespacesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOperationsPaginator(self: *Self, params: list_operations.ListOperationsInput) paginator.ListOperationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServicesPaginator(self: *Self, params: list_services.ListServicesInput) paginator.ListServicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
