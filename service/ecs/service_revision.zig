const CapacityProviderStrategyItem = @import("capacity_provider_strategy_item.zig").CapacityProviderStrategyItem;
const ContainerImage = @import("container_image.zig").ContainerImage;
const ECSManagedResources = @import("ecs_managed_resources.zig").ECSManagedResources;
const DeploymentEphemeralStorage = @import("deployment_ephemeral_storage.zig").DeploymentEphemeralStorage;
const LaunchType = @import("launch_type.zig").LaunchType;
const LoadBalancer = @import("load_balancer.zig").LoadBalancer;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const ResolvedConfiguration = @import("resolved_configuration.zig").ResolvedConfiguration;
const ServiceConnectConfiguration = @import("service_connect_configuration.zig").ServiceConnectConfiguration;
const ServiceRegistry = @import("service_registry.zig").ServiceRegistry;
const ServiceVolumeConfiguration = @import("service_volume_configuration.zig").ServiceVolumeConfiguration;
const VpcLatticeConfiguration = @import("vpc_lattice_configuration.zig").VpcLatticeConfiguration;

/// Information about the service revision.
///
/// A service revision contains a record of the workload configuration Amazon
/// ECS is
/// attempting to deploy. Whenever you create or deploy a service, Amazon ECS
/// automatically
/// creates and captures the configuration that you're trying to deploy in the
/// service
/// revision. For information about service revisions, see [Amazon ECS service
/// revisions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-revision.html) in the *
/// Amazon Elastic Container Service
/// Developer Guide*
/// .
pub const ServiceRevision = struct {
    /// The capacity provider strategy the service revision uses.
    capacity_provider_strategy: ?[]const CapacityProviderStrategyItem,

    /// The ARN of the cluster that hosts the service.
    cluster_arn: ?[]const u8,

    /// The container images the service revision uses.
    container_images: ?[]const ContainerImage,

    /// The time that the service revision was created. The format is yyyy-mm-dd
    /// HH:mm:ss.SSSSS.
    created_at: ?i64,

    /// The resources created and managed by Amazon ECS when you create an Express
    /// service for Amazon ECS.
    ecs_managed_resources: ?ECSManagedResources,

    fargate_ephemeral_storage: ?DeploymentEphemeralStorage,

    /// Indicates whether Runtime Monitoring is turned on.
    guard_duty_enabled: bool = false,

    /// The launch type the service revision uses.
    launch_type: ?LaunchType,

    /// The load balancers the service revision uses.
    load_balancers: ?[]const LoadBalancer,

    network_configuration: ?NetworkConfiguration,

    /// The platform family the service revision uses.
    platform_family: ?[]const u8,

    /// For the Fargate launch type, the platform version the service revision uses.
    platform_version: ?[]const u8,

    /// The resolved configuration for the service revision which contains the
    /// actual resources your service revision uses, such as which target groups
    /// serve traffic.
    resolved_configuration: ?ResolvedConfiguration,

    /// The ARN of the service for the service revision.
    service_arn: ?[]const u8,

    service_connect_configuration: ?ServiceConnectConfiguration,

    /// The service registries (for Service Discovery) the service revision uses.
    service_registries: ?[]const ServiceRegistry,

    /// The ARN of the service revision.
    service_revision_arn: ?[]const u8,

    /// The task definition the service revision uses.
    task_definition: ?[]const u8,

    /// The volumes that are configured at deployment that the service revision
    /// uses.
    volume_configurations: ?[]const ServiceVolumeConfiguration,

    /// The VPC Lattice configuration for the service revision.
    vpc_lattice_configurations: ?[]const VpcLatticeConfiguration,

    pub const json_field_names = .{
        .capacity_provider_strategy = "capacityProviderStrategy",
        .cluster_arn = "clusterArn",
        .container_images = "containerImages",
        .created_at = "createdAt",
        .ecs_managed_resources = "ecsManagedResources",
        .fargate_ephemeral_storage = "fargateEphemeralStorage",
        .guard_duty_enabled = "guardDutyEnabled",
        .launch_type = "launchType",
        .load_balancers = "loadBalancers",
        .network_configuration = "networkConfiguration",
        .platform_family = "platformFamily",
        .platform_version = "platformVersion",
        .resolved_configuration = "resolvedConfiguration",
        .service_arn = "serviceArn",
        .service_connect_configuration = "serviceConnectConfiguration",
        .service_registries = "serviceRegistries",
        .service_revision_arn = "serviceRevisionArn",
        .task_definition = "taskDefinition",
        .volume_configurations = "volumeConfigurations",
        .vpc_lattice_configurations = "vpcLatticeConfigurations",
    };
};
