const CapacityProviderStrategyItem = @import("capacity_provider_strategy_item.zig").CapacityProviderStrategyItem;
const DeploymentEphemeralStorage = @import("deployment_ephemeral_storage.zig").DeploymentEphemeralStorage;
const LaunchType = @import("launch_type.zig").LaunchType;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const DeploymentRolloutState = @import("deployment_rollout_state.zig").DeploymentRolloutState;
const ServiceConnectConfiguration = @import("service_connect_configuration.zig").ServiceConnectConfiguration;
const ServiceConnectServiceResource = @import("service_connect_service_resource.zig").ServiceConnectServiceResource;
const ServiceVolumeConfiguration = @import("service_volume_configuration.zig").ServiceVolumeConfiguration;
const VpcLatticeConfiguration = @import("vpc_lattice_configuration.zig").VpcLatticeConfiguration;

/// The details of an Amazon ECS service deployment. This is used only when a
/// service uses
/// the `ECS` deployment controller type.
pub const Deployment = struct {
    /// The capacity provider strategy that the deployment is using.
    capacity_provider_strategy: ?[]const CapacityProviderStrategyItem = null,

    /// The Unix timestamp for the time when the service deployment was created.
    created_at: ?i64 = null,

    /// The most recent desired count of tasks that was specified for the service to
    /// deploy or
    /// maintain.
    desired_count: i32 = 0,

    /// The number of consecutively failed tasks in the deployment. A task is
    /// considered a
    /// failure if the service scheduler can't launch the task, the task doesn't
    /// transition to a
    /// `RUNNING` state, or if it fails any of its defined health checks and is
    /// stopped.
    ///
    /// Once a service deployment has one or more successfully running tasks, the
    /// failed
    /// task count resets to zero and stops being evaluated.
    failed_tasks: i32 = 0,

    /// The Fargate ephemeral storage settings for the deployment.
    fargate_ephemeral_storage: ?DeploymentEphemeralStorage = null,

    /// The ID of the deployment.
    id: ?[]const u8 = null,

    /// The launch type the tasks in the service are using. For more information,
    /// see [Amazon
    /// ECS Launch
    /// Types](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_types.html) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    launch_type: ?LaunchType = null,

    /// The VPC subnet and security group configuration for tasks that receive their
    /// own
    /// elastic network interface by using the `awsvpc` networking mode.
    network_configuration: ?NetworkConfiguration = null,

    /// The number of tasks in the deployment that are in the `PENDING`
    /// status.
    pending_count: i32 = 0,

    /// The operating system that your tasks in the service, or tasks are running
    /// on. A
    /// platform family is specified only for tasks using the Fargate launch type.
    ///
    /// All tasks that run as part of this service must use the same
    /// `platformFamily` value as the service, for example, `
    /// LINUX.`.
    platform_family: ?[]const u8 = null,

    /// The platform version that your tasks in the service run on. A platform
    /// version is only
    /// specified for tasks using the Fargate launch type. If one isn't specified,
    /// the
    /// `LATEST` platform version is used. For more information, see [Fargate
    /// Platform
    /// Versions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html) in the *Amazon Elastic
    /// Container Service Developer Guide*.
    platform_version: ?[]const u8 = null,

    /// The `rolloutState` of a service is only returned for services that use
    /// the rolling update (`ECS`) deployment type that aren't behind a Classic
    /// Load Balancer.
    ///
    /// The rollout state of the deployment. When a service deployment is started,
    /// it begins
    /// in an `IN_PROGRESS` state. When the service reaches a steady state, the
    /// deployment transitions to a `COMPLETED` state. If the service fails to reach
    /// a steady state and circuit breaker is turned on, the deployment transitions
    /// to a
    /// `FAILED` state. A deployment in `FAILED` state doesn't launch
    /// any new tasks. For more information, see
    /// [DeploymentCircuitBreaker](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DeploymentCircuitBreaker.html).
    rollout_state: ?DeploymentRolloutState = null,

    /// A description of the rollout state of a deployment.
    rollout_state_reason: ?[]const u8 = null,

    /// The number of tasks in the deployment that are in the `RUNNING`
    /// status.
    running_count: i32 = 0,

    /// The details of the Service Connect configuration that's used by this
    /// deployment.
    /// Compare the configuration between multiple deployments when troubleshooting
    /// issues with
    /// new deployments.
    ///
    /// The configuration for this service to discover and connect to services, and
    /// be
    /// discovered by, and connected from, other services within a namespace.
    ///
    /// Tasks that run in a namespace can use short names to connect to services in
    /// the
    /// namespace. Tasks can connect to services across all of the clusters in the
    /// namespace.
    /// Tasks connect through a managed proxy container that collects logs and
    /// metrics for
    /// increased visibility. Only the tasks that Amazon ECS services create are
    /// supported with
    /// Service Connect. For more information, see [Service
    /// Connect](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect.html)
    /// in the *Amazon Elastic Container Service Developer Guide*.
    service_connect_configuration: ?ServiceConnectConfiguration = null,

    /// The list of Service Connect resources that are associated with this
    /// deployment. Each
    /// list entry maps a discovery name to a Cloud Map service name.
    service_connect_resources: ?[]const ServiceConnectServiceResource = null,

    /// The status of the deployment. The following describes each state.
    ///
    /// **PRIMARY**
    ///
    /// The most recent deployment of a service.
    ///
    /// **ACTIVE**
    ///
    /// A service deployment that still has running tasks, but are in the process
    /// of being replaced with a new `PRIMARY` deployment.
    ///
    /// **INACTIVE**
    ///
    /// A deployment that has been completely replaced.
    status: ?[]const u8 = null,

    /// The most recent task definition that was specified for the tasks in the
    /// service to
    /// use.
    task_definition: ?[]const u8 = null,

    /// The Unix timestamp for the time when the service deployment was last
    /// updated.
    updated_at: ?i64 = null,

    /// The details of the volume that was `configuredAtLaunch`. You can configure
    /// different settings like the size, throughput, volumeType, and ecryption in
    /// [ServiceManagedEBSVolumeConfiguration](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ServiceManagedEBSVolumeConfiguration.html). The `name` of the volume
    /// must match the `name` from the task definition.
    volume_configurations: ?[]const ServiceVolumeConfiguration = null,

    /// The VPC Lattice configuration for the service deployment.
    vpc_lattice_configurations: ?[]const VpcLatticeConfiguration = null,

    pub const json_field_names = .{
        .capacity_provider_strategy = "capacityProviderStrategy",
        .created_at = "createdAt",
        .desired_count = "desiredCount",
        .failed_tasks = "failedTasks",
        .fargate_ephemeral_storage = "fargateEphemeralStorage",
        .id = "id",
        .launch_type = "launchType",
        .network_configuration = "networkConfiguration",
        .pending_count = "pendingCount",
        .platform_family = "platformFamily",
        .platform_version = "platformVersion",
        .rollout_state = "rolloutState",
        .rollout_state_reason = "rolloutStateReason",
        .running_count = "runningCount",
        .service_connect_configuration = "serviceConnectConfiguration",
        .service_connect_resources = "serviceConnectResources",
        .status = "status",
        .task_definition = "taskDefinition",
        .updated_at = "updatedAt",
        .volume_configurations = "volumeConfigurations",
        .vpc_lattice_configurations = "vpcLatticeConfigurations",
    };
};
