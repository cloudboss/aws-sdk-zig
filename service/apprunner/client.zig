const aws = @import("aws");
const std = @import("std");

const associate_custom_domain = @import("associate_custom_domain.zig");
const create_auto_scaling_configuration = @import("create_auto_scaling_configuration.zig");
const create_connection = @import("create_connection.zig");
const create_observability_configuration = @import("create_observability_configuration.zig");
const create_service = @import("create_service.zig");
const create_vpc_connector = @import("create_vpc_connector.zig");
const create_vpc_ingress_connection = @import("create_vpc_ingress_connection.zig");
const delete_auto_scaling_configuration = @import("delete_auto_scaling_configuration.zig");
const delete_connection = @import("delete_connection.zig");
const delete_observability_configuration = @import("delete_observability_configuration.zig");
const delete_service = @import("delete_service.zig");
const delete_vpc_connector = @import("delete_vpc_connector.zig");
const delete_vpc_ingress_connection = @import("delete_vpc_ingress_connection.zig");
const describe_auto_scaling_configuration = @import("describe_auto_scaling_configuration.zig");
const describe_custom_domains = @import("describe_custom_domains.zig");
const describe_observability_configuration = @import("describe_observability_configuration.zig");
const describe_service = @import("describe_service.zig");
const describe_vpc_connector = @import("describe_vpc_connector.zig");
const describe_vpc_ingress_connection = @import("describe_vpc_ingress_connection.zig");
const disassociate_custom_domain = @import("disassociate_custom_domain.zig");
const list_auto_scaling_configurations = @import("list_auto_scaling_configurations.zig");
const list_connections = @import("list_connections.zig");
const list_observability_configurations = @import("list_observability_configurations.zig");
const list_operations = @import("list_operations.zig");
const list_services = @import("list_services.zig");
const list_services_for_auto_scaling_configuration = @import("list_services_for_auto_scaling_configuration.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_vpc_connectors = @import("list_vpc_connectors.zig");
const list_vpc_ingress_connections = @import("list_vpc_ingress_connections.zig");
const pause_service = @import("pause_service.zig");
const resume_service = @import("resume_service.zig");
const start_deployment = @import("start_deployment.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_default_auto_scaling_configuration = @import("update_default_auto_scaling_configuration.zig");
const update_service = @import("update_service.zig");
const update_vpc_ingress_connection = @import("update_vpc_ingress_connection.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "AppRunner";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Associate your own domain name with the App Runner subdomain URL of your App
    /// Runner service.
    ///
    /// After you call `AssociateCustomDomain` and receive a successful response,
    /// use the information in the CustomDomain record
    /// that's returned to add CNAME records to your Domain Name System (DNS). For
    /// each mapped domain name, add a mapping to the target App Runner subdomain
    /// and one or
    /// more certificate validation records. App Runner then performs DNS validation
    /// to verify that you own or control the domain name that you associated. App
    /// Runner tracks
    /// domain validity in a certificate stored in [AWS Certificate Manager
    /// (ACM)](https://docs.aws.amazon.com/acm/latest/userguide).
    pub fn associateCustomDomain(self: *Self, allocator: std.mem.Allocator, input: associate_custom_domain.AssociateCustomDomainInput, options: associate_custom_domain.Options) !associate_custom_domain.AssociateCustomDomainOutput {
        return associate_custom_domain.execute(self, allocator, input, options);
    }

    /// Create an App Runner automatic scaling configuration resource. App Runner
    /// requires this resource when you create or update App Runner services and you
    /// require
    /// non-default auto scaling settings. You can share an auto scaling
    /// configuration across multiple services.
    ///
    /// Create multiple revisions of a configuration by calling this action multiple
    /// times using the same `AutoScalingConfigurationName`. The call
    /// returns incremental `AutoScalingConfigurationRevision` values. When you
    /// create a service and configure an auto scaling configuration resource,
    /// the service uses the latest active revision of the auto scaling
    /// configuration by default. You can optionally configure the service to use a
    /// specific
    /// revision.
    ///
    /// Configure a higher `MinSize` to increase the spread of your App Runner
    /// service over more Availability Zones in the Amazon Web Services Region. The
    /// tradeoff is a higher minimal cost.
    ///
    /// Configure a lower `MaxSize` to control your cost. The tradeoff is lower
    /// responsiveness during peak demand.
    pub fn createAutoScalingConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_auto_scaling_configuration.CreateAutoScalingConfigurationInput, options: create_auto_scaling_configuration.Options) !create_auto_scaling_configuration.CreateAutoScalingConfigurationOutput {
        return create_auto_scaling_configuration.execute(self, allocator, input, options);
    }

    /// Create an App Runner connection resource. App Runner requires a connection
    /// resource when you create App Runner services that access private
    /// repositories from
    /// certain third-party providers. You can share a connection across multiple
    /// services.
    ///
    /// A connection resource is needed to access GitHub and Bitbucket repositories.
    /// Both require
    /// a user interface approval process through the App Runner console before you
    /// can use the
    /// connection.
    pub fn createConnection(self: *Self, allocator: std.mem.Allocator, input: create_connection.CreateConnectionInput, options: create_connection.Options) !create_connection.CreateConnectionOutput {
        return create_connection.execute(self, allocator, input, options);
    }

    /// Create an App Runner observability configuration resource. App Runner
    /// requires this resource when you create or update App Runner services and you
    /// want to enable
    /// non-default observability features. You can share an observability
    /// configuration across multiple services.
    ///
    /// Create multiple revisions of a configuration by calling this action multiple
    /// times using the same `ObservabilityConfigurationName`. The
    /// call returns incremental `ObservabilityConfigurationRevision` values. When
    /// you create a service and configure an observability configuration
    /// resource, the service uses the latest active revision of the observability
    /// configuration by default. You can optionally configure the service to use a
    /// specific revision.
    ///
    /// The observability configuration resource is designed to configure multiple
    /// features (currently one feature, tracing). This action takes optional
    /// parameters that describe the configuration of these features (currently one
    /// parameter, `TraceConfiguration`). If you don't specify a feature
    /// parameter, App Runner doesn't enable the feature.
    pub fn createObservabilityConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_observability_configuration.CreateObservabilityConfigurationInput, options: create_observability_configuration.Options) !create_observability_configuration.CreateObservabilityConfigurationOutput {
        return create_observability_configuration.execute(self, allocator, input, options);
    }

    /// Create an App Runner service. After the service is created, the action also
    /// automatically starts a deployment.
    ///
    /// This is an asynchronous operation. On a successful call, you can use the
    /// returned `OperationId` and the
    /// [ListOperations](https://docs.aws.amazon.com/apprunner/latest/api/API_ListOperations.html) call to track the operation's progress.
    pub fn createService(self: *Self, allocator: std.mem.Allocator, input: create_service.CreateServiceInput, options: create_service.Options) !create_service.CreateServiceOutput {
        return create_service.execute(self, allocator, input, options);
    }

    /// Create an App Runner VPC connector resource. App Runner requires this
    /// resource when you want to associate your App Runner service to a custom
    /// Amazon Virtual Private Cloud
    /// (Amazon VPC).
    pub fn createVpcConnector(self: *Self, allocator: std.mem.Allocator, input: create_vpc_connector.CreateVpcConnectorInput, options: create_vpc_connector.Options) !create_vpc_connector.CreateVpcConnectorOutput {
        return create_vpc_connector.execute(self, allocator, input, options);
    }

    /// Create an App Runner VPC Ingress Connection resource. App Runner requires
    /// this resource when you want to associate your App Runner service with an
    /// Amazon VPC endpoint.
    pub fn createVpcIngressConnection(self: *Self, allocator: std.mem.Allocator, input: create_vpc_ingress_connection.CreateVpcIngressConnectionInput, options: create_vpc_ingress_connection.Options) !create_vpc_ingress_connection.CreateVpcIngressConnectionOutput {
        return create_vpc_ingress_connection.execute(self, allocator, input, options);
    }

    /// Delete an App Runner automatic scaling configuration resource. You can
    /// delete a top level auto scaling configuration, a specific revision of one,
    /// or all
    /// revisions associated with the top level configuration. You can't delete the
    /// default auto scaling configuration or a configuration that's used by one or
    /// more App Runner services.
    pub fn deleteAutoScalingConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_auto_scaling_configuration.DeleteAutoScalingConfigurationInput, options: delete_auto_scaling_configuration.Options) !delete_auto_scaling_configuration.DeleteAutoScalingConfigurationOutput {
        return delete_auto_scaling_configuration.execute(self, allocator, input, options);
    }

    /// Delete an App Runner connection. You must first ensure that there are no
    /// running App Runner services that use this connection. If there are any, the
    /// `DeleteConnection` action fails.
    pub fn deleteConnection(self: *Self, allocator: std.mem.Allocator, input: delete_connection.DeleteConnectionInput, options: delete_connection.Options) !delete_connection.DeleteConnectionOutput {
        return delete_connection.execute(self, allocator, input, options);
    }

    /// Delete an App Runner observability configuration resource. You can delete a
    /// specific revision or the latest active revision. You can't delete a
    /// configuration that's used by one or more App Runner services.
    pub fn deleteObservabilityConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_observability_configuration.DeleteObservabilityConfigurationInput, options: delete_observability_configuration.Options) !delete_observability_configuration.DeleteObservabilityConfigurationOutput {
        return delete_observability_configuration.execute(self, allocator, input, options);
    }

    /// Delete an App Runner service.
    ///
    /// This is an asynchronous operation. On a successful call, you can use the
    /// returned `OperationId` and the ListOperations
    /// call to track the operation's progress.
    ///
    /// Make sure that you don't have any active VPCIngressConnections associated
    /// with the service you want to delete.
    pub fn deleteService(self: *Self, allocator: std.mem.Allocator, input: delete_service.DeleteServiceInput, options: delete_service.Options) !delete_service.DeleteServiceOutput {
        return delete_service.execute(self, allocator, input, options);
    }

    /// Delete an App Runner VPC connector resource. You can't delete a
    /// connector that's used by one or more App Runner services.
    pub fn deleteVpcConnector(self: *Self, allocator: std.mem.Allocator, input: delete_vpc_connector.DeleteVpcConnectorInput, options: delete_vpc_connector.Options) !delete_vpc_connector.DeleteVpcConnectorOutput {
        return delete_vpc_connector.execute(self, allocator, input, options);
    }

    /// Delete an App Runner VPC Ingress Connection resource that's associated with
    /// an App Runner service. The VPC Ingress Connection must be in one of the
    /// following states to be deleted:
    ///
    /// * `AVAILABLE`
    ///
    /// * `FAILED_CREATION`
    ///
    /// * `FAILED_UPDATE`
    ///
    /// * `FAILED_DELETION`
    pub fn deleteVpcIngressConnection(self: *Self, allocator: std.mem.Allocator, input: delete_vpc_ingress_connection.DeleteVpcIngressConnectionInput, options: delete_vpc_ingress_connection.Options) !delete_vpc_ingress_connection.DeleteVpcIngressConnectionOutput {
        return delete_vpc_ingress_connection.execute(self, allocator, input, options);
    }

    /// Return a full description of an App Runner automatic scaling configuration
    /// resource.
    pub fn describeAutoScalingConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_auto_scaling_configuration.DescribeAutoScalingConfigurationInput, options: describe_auto_scaling_configuration.Options) !describe_auto_scaling_configuration.DescribeAutoScalingConfigurationOutput {
        return describe_auto_scaling_configuration.execute(self, allocator, input, options);
    }

    /// Return a description of custom domain names that are associated with an App
    /// Runner service.
    pub fn describeCustomDomains(self: *Self, allocator: std.mem.Allocator, input: describe_custom_domains.DescribeCustomDomainsInput, options: describe_custom_domains.Options) !describe_custom_domains.DescribeCustomDomainsOutput {
        return describe_custom_domains.execute(self, allocator, input, options);
    }

    /// Return a full description of an App Runner observability configuration
    /// resource.
    pub fn describeObservabilityConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_observability_configuration.DescribeObservabilityConfigurationInput, options: describe_observability_configuration.Options) !describe_observability_configuration.DescribeObservabilityConfigurationOutput {
        return describe_observability_configuration.execute(self, allocator, input, options);
    }

    /// Return a full description of an App Runner service.
    pub fn describeService(self: *Self, allocator: std.mem.Allocator, input: describe_service.DescribeServiceInput, options: describe_service.Options) !describe_service.DescribeServiceOutput {
        return describe_service.execute(self, allocator, input, options);
    }

    /// Return a description of an App Runner VPC connector resource.
    pub fn describeVpcConnector(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_connector.DescribeVpcConnectorInput, options: describe_vpc_connector.Options) !describe_vpc_connector.DescribeVpcConnectorOutput {
        return describe_vpc_connector.execute(self, allocator, input, options);
    }

    /// Return a full description of an App Runner VPC Ingress Connection resource.
    pub fn describeVpcIngressConnection(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_ingress_connection.DescribeVpcIngressConnectionInput, options: describe_vpc_ingress_connection.Options) !describe_vpc_ingress_connection.DescribeVpcIngressConnectionOutput {
        return describe_vpc_ingress_connection.execute(self, allocator, input, options);
    }

    /// Disassociate a custom domain name from an App Runner service.
    ///
    /// Certificates tracking domain validity are associated with a custom domain
    /// and are stored in [AWS
    /// Certificate Manager
    /// (ACM)](https://docs.aws.amazon.com/acm/latest/userguide). These certificates
    /// aren't deleted as part of this action. App Runner delays certificate
    /// deletion for
    /// 30 days after a domain is disassociated from your service.
    pub fn disassociateCustomDomain(self: *Self, allocator: std.mem.Allocator, input: disassociate_custom_domain.DisassociateCustomDomainInput, options: disassociate_custom_domain.Options) !disassociate_custom_domain.DisassociateCustomDomainOutput {
        return disassociate_custom_domain.execute(self, allocator, input, options);
    }

    /// Returns a list of active App Runner automatic scaling configurations in your
    /// Amazon Web Services account. You can query the revisions for a specific
    /// configuration name or the revisions for all active configurations in your
    /// account. You can optionally query only the latest revision of each requested
    /// name.
    ///
    /// To retrieve a full description of a particular configuration revision, call
    /// and provide one of
    /// the ARNs returned by `ListAutoScalingConfigurations`.
    pub fn listAutoScalingConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_auto_scaling_configurations.ListAutoScalingConfigurationsInput, options: list_auto_scaling_configurations.Options) !list_auto_scaling_configurations.ListAutoScalingConfigurationsOutput {
        return list_auto_scaling_configurations.execute(self, allocator, input, options);
    }

    /// Returns a list of App Runner connections that are associated with your
    /// Amazon Web Services account.
    pub fn listConnections(self: *Self, allocator: std.mem.Allocator, input: list_connections.ListConnectionsInput, options: list_connections.Options) !list_connections.ListConnectionsOutput {
        return list_connections.execute(self, allocator, input, options);
    }

    /// Returns a list of active App Runner observability configurations in your
    /// Amazon Web Services account. You can query the revisions for a specific
    /// configuration name or the revisions for all active configurations in your
    /// account. You can optionally query only the latest revision of each requested
    /// name.
    ///
    /// To retrieve a full description of a particular configuration revision, call
    /// and provide one
    /// of the ARNs returned by `ListObservabilityConfigurations`.
    pub fn listObservabilityConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_observability_configurations.ListObservabilityConfigurationsInput, options: list_observability_configurations.Options) !list_observability_configurations.ListObservabilityConfigurationsOutput {
        return list_observability_configurations.execute(self, allocator, input, options);
    }

    /// Return a list of operations that occurred on an App Runner service.
    ///
    /// The resulting list of OperationSummary objects is sorted in reverse
    /// chronological order. The first object on the list represents the
    /// last started operation.
    pub fn listOperations(self: *Self, allocator: std.mem.Allocator, input: list_operations.ListOperationsInput, options: list_operations.Options) !list_operations.ListOperationsOutput {
        return list_operations.execute(self, allocator, input, options);
    }

    /// Returns a list of running App Runner services in your Amazon Web Services
    /// account.
    pub fn listServices(self: *Self, allocator: std.mem.Allocator, input: list_services.ListServicesInput, options: list_services.Options) !list_services.ListServicesOutput {
        return list_services.execute(self, allocator, input, options);
    }

    /// Returns a list of the associated App Runner services using an auto scaling
    /// configuration.
    pub fn listServicesForAutoScalingConfiguration(self: *Self, allocator: std.mem.Allocator, input: list_services_for_auto_scaling_configuration.ListServicesForAutoScalingConfigurationInput, options: list_services_for_auto_scaling_configuration.Options) !list_services_for_auto_scaling_configuration.ListServicesForAutoScalingConfigurationOutput {
        return list_services_for_auto_scaling_configuration.execute(self, allocator, input, options);
    }

    /// List tags that are associated with for an App Runner resource. The response
    /// contains a list of tag key-value pairs.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns a list of App Runner VPC connectors in your Amazon Web Services
    /// account.
    pub fn listVpcConnectors(self: *Self, allocator: std.mem.Allocator, input: list_vpc_connectors.ListVpcConnectorsInput, options: list_vpc_connectors.Options) !list_vpc_connectors.ListVpcConnectorsOutput {
        return list_vpc_connectors.execute(self, allocator, input, options);
    }

    /// Return a list of App Runner VPC Ingress Connections in your Amazon Web
    /// Services account.
    pub fn listVpcIngressConnections(self: *Self, allocator: std.mem.Allocator, input: list_vpc_ingress_connections.ListVpcIngressConnectionsInput, options: list_vpc_ingress_connections.Options) !list_vpc_ingress_connections.ListVpcIngressConnectionsOutput {
        return list_vpc_ingress_connections.execute(self, allocator, input, options);
    }

    /// Pause an active App Runner service. App Runner reduces compute capacity for
    /// the service to zero and loses state (for example, ephemeral storage is
    /// removed).
    ///
    /// This is an asynchronous operation. On a successful call, you can use the
    /// returned `OperationId` and the ListOperations
    /// call to track the operation's progress.
    pub fn pauseService(self: *Self, allocator: std.mem.Allocator, input: pause_service.PauseServiceInput, options: pause_service.Options) !pause_service.PauseServiceOutput {
        return pause_service.execute(self, allocator, input, options);
    }

    /// Resume an active App Runner service. App Runner provisions compute capacity
    /// for the service.
    ///
    /// This is an asynchronous operation. On a successful call, you can use the
    /// returned `OperationId` and the ListOperations
    /// call to track the operation's progress.
    pub fn resumeService(self: *Self, allocator: std.mem.Allocator, input: resume_service.ResumeServiceInput, options: resume_service.Options) !resume_service.ResumeServiceOutput {
        return resume_service.execute(self, allocator, input, options);
    }

    /// Initiate a manual deployment of the latest commit in a source code
    /// repository or the latest image in a source image repository to an App Runner
    /// service.
    ///
    /// For a source code repository, App Runner retrieves the commit and builds a
    /// Docker image. For a source image repository, App Runner retrieves the latest
    /// Docker
    /// image. In both cases, App Runner then deploys the new image to your service
    /// and starts a new container instance.
    ///
    /// This is an asynchronous operation. On a successful call, you can use the
    /// returned `OperationId` and the ListOperations
    /// call to track the operation's progress.
    pub fn startDeployment(self: *Self, allocator: std.mem.Allocator, input: start_deployment.StartDeploymentInput, options: start_deployment.Options) !start_deployment.StartDeploymentOutput {
        return start_deployment.execute(self, allocator, input, options);
    }

    /// Add tags to, or update the tag values of, an App Runner resource. A tag is a
    /// key-value pair.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Remove tags from an App Runner resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Update an auto scaling configuration to be the default. The existing default
    /// auto scaling configuration will be set to non-default
    /// automatically.
    pub fn updateDefaultAutoScalingConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_default_auto_scaling_configuration.UpdateDefaultAutoScalingConfigurationInput, options: update_default_auto_scaling_configuration.Options) !update_default_auto_scaling_configuration.UpdateDefaultAutoScalingConfigurationOutput {
        return update_default_auto_scaling_configuration.execute(self, allocator, input, options);
    }

    /// Update an App Runner service. You can update the source configuration and
    /// instance configuration of the service. You can also update the ARN of the
    /// auto
    /// scaling configuration resource that's associated with the service. However,
    /// you can't change the name or the encryption configuration of the service.
    /// These can be set only when you create the service.
    ///
    /// To update the tags applied to your service, use the separate actions
    /// TagResource and UntagResource.
    ///
    /// This is an asynchronous operation. On a successful call, you can use the
    /// returned `OperationId` and the ListOperations
    /// call to track the operation's progress.
    pub fn updateService(self: *Self, allocator: std.mem.Allocator, input: update_service.UpdateServiceInput, options: update_service.Options) !update_service.UpdateServiceOutput {
        return update_service.execute(self, allocator, input, options);
    }

    /// Update an existing App Runner VPC Ingress Connection resource. The VPC
    /// Ingress Connection must be in one of the following states to be updated:
    ///
    /// * AVAILABLE
    ///
    /// * FAILED_CREATION
    ///
    /// * FAILED_UPDATE
    pub fn updateVpcIngressConnection(self: *Self, allocator: std.mem.Allocator, input: update_vpc_ingress_connection.UpdateVpcIngressConnectionInput, options: update_vpc_ingress_connection.Options) !update_vpc_ingress_connection.UpdateVpcIngressConnectionOutput {
        return update_vpc_ingress_connection.execute(self, allocator, input, options);
    }

    pub fn describeCustomDomainsPaginator(self: *Self, params: describe_custom_domains.DescribeCustomDomainsInput) paginator.DescribeCustomDomainsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAutoScalingConfigurationsPaginator(self: *Self, params: list_auto_scaling_configurations.ListAutoScalingConfigurationsInput) paginator.ListAutoScalingConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConnectionsPaginator(self: *Self, params: list_connections.ListConnectionsInput) paginator.ListConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listObservabilityConfigurationsPaginator(self: *Self, params: list_observability_configurations.ListObservabilityConfigurationsInput) paginator.ListObservabilityConfigurationsPaginator {
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

    pub fn listServicesForAutoScalingConfigurationPaginator(self: *Self, params: list_services_for_auto_scaling_configuration.ListServicesForAutoScalingConfigurationInput) paginator.ListServicesForAutoScalingConfigurationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVpcConnectorsPaginator(self: *Self, params: list_vpc_connectors.ListVpcConnectorsInput) paginator.ListVpcConnectorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVpcIngressConnectionsPaginator(self: *Self, params: list_vpc_ingress_connections.ListVpcIngressConnectionsInput) paginator.ListVpcIngressConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
