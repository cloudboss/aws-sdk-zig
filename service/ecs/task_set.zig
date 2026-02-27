const CapacityProviderStrategyItem = @import("capacity_provider_strategy_item.zig").CapacityProviderStrategyItem;
const DeploymentEphemeralStorage = @import("deployment_ephemeral_storage.zig").DeploymentEphemeralStorage;
const LaunchType = @import("launch_type.zig").LaunchType;
const LoadBalancer = @import("load_balancer.zig").LoadBalancer;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const Scale = @import("scale.zig").Scale;
const ServiceRegistry = @import("service_registry.zig").ServiceRegistry;
const StabilityStatus = @import("stability_status.zig").StabilityStatus;
const Tag = @import("tag.zig").Tag;

/// Information about a set of Amazon ECS tasks in either an CodeDeploy or an
/// `EXTERNAL` deployment. An Amazon ECS task set includes details such as
/// the desired number of tasks, how many tasks are running, and whether the
/// task set serves
/// production traffic.
pub const TaskSet = struct {
    /// The capacity provider strategy that are associated with the task set.
    capacity_provider_strategy: ?[]const CapacityProviderStrategyItem,

    /// The Amazon Resource Name (ARN) of the cluster that the service that hosts
    /// the task set
    /// exists in.
    cluster_arn: ?[]const u8,

    /// The computed desired count for the task set. This is calculated by
    /// multiplying the
    /// service's `desiredCount` by the task set's `scale` percentage. The
    /// result is always rounded up. For example, if the computed desired count is
    /// 1.2, it
    /// rounds up to 2 tasks.
    computed_desired_count: i32 = 0,

    /// The Unix timestamp for the time when the task set was created.
    created_at: ?i64,

    /// The external ID associated with the task set.
    ///
    /// If an CodeDeploy deployment created a task set, the `externalId`
    /// parameter contains the CodeDeploy deployment ID.
    ///
    /// If a task set is created for an external deployment and is associated with a
    /// service
    /// discovery registry, the `externalId` parameter contains the
    /// `ECS_TASK_SET_EXTERNAL_ID`
    /// Cloud Map
    /// attribute.
    external_id: ?[]const u8,

    /// The Fargate ephemeral storage settings for the task set.
    fargate_ephemeral_storage: ?DeploymentEphemeralStorage,

    /// The ID of the task set.
    id: ?[]const u8,

    /// The launch type the tasks in the task set are using. For more information,
    /// see [Amazon
    /// ECS launch
    /// types](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_types.html) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    launch_type: ?LaunchType,

    /// Details on a load balancer that are used with a task set.
    load_balancers: ?[]const LoadBalancer,

    /// The network configuration for the task set.
    network_configuration: ?NetworkConfiguration,

    /// The number of tasks in the task set that are in the `PENDING` status during
    /// a deployment. A task in the `PENDING` state is preparing to enter the
    /// `RUNNING` state. A task set enters the `PENDING` status when
    /// it launches for the first time or when it's restarted after being in the
    /// `STOPPED` state.
    pending_count: i32 = 0,

    /// The operating system that your tasks in the set are running on. A platform
    /// family is
    /// specified only for tasks that use the Fargate launch type.
    ///
    /// All tasks in the set must have the same value.
    platform_family: ?[]const u8,

    /// The Fargate platform version where the tasks in the task set are running. A
    /// platform version is only specified for tasks run on Fargate. For more
    /// information, see [Fargate
    /// platform
    /// versions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html) in the *Amazon Elastic Container Service
    /// Developer Guide*.
    platform_version: ?[]const u8,

    /// The number of tasks in the task set that are in the `RUNNING` status during
    /// a deployment. A task in the `RUNNING` state is running and ready for
    /// use.
    running_count: i32 = 0,

    /// A floating-point percentage of your desired number of tasks to place and
    /// keep running
    /// in the task set.
    scale: ?Scale,

    /// The Amazon Resource Name (ARN) of the service the task set exists in.
    service_arn: ?[]const u8,

    /// The details for the service discovery registries to assign to this task set.
    /// For more
    /// information, see [Service
    /// discovery](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-discovery.html).
    service_registries: ?[]const ServiceRegistry,

    /// The stability status. This indicates whether the task set has reached a
    /// steady state.
    /// If the following conditions are met, the task set are in
    /// `STEADY_STATE`:
    ///
    /// * The task `runningCount` is equal to the
    /// `computedDesiredCount`.
    ///
    /// * The `pendingCount` is `0`.
    ///
    /// * There are no tasks that are running on container instances in the
    /// `DRAINING` status.
    ///
    /// * All tasks are reporting a healthy status from the load balancers, service
    /// discovery, and container health checks.
    ///
    /// If any of those conditions aren't met, the stability status returns
    /// `STABILIZING`.
    stability_status: ?StabilityStatus,

    /// The Unix timestamp for the time when the task set stability status was
    /// retrieved.
    stability_status_at: ?i64,

    /// The tag specified when a task set is started. If an CodeDeploy deployment
    /// created
    /// the task set, the `startedBy` parameter is `CODE_DEPLOY`. If an
    /// external deployment created the task set, the `startedBy` field isn't
    /// used.
    started_by: ?[]const u8,

    /// The status of the task set. The following describes each state.
    ///
    /// **PRIMARY**
    ///
    /// The task set is serving production traffic.
    ///
    /// **ACTIVE**
    ///
    /// The task set isn't serving production traffic.
    ///
    /// **DRAINING**
    ///
    /// The tasks in the task set are being stopped, and their corresponding
    /// targets are being deregistered from their target group.
    status: ?[]const u8,

    /// The metadata that you apply to the task set to help you categorize and
    /// organize them.
    /// Each tag consists of a key and an optional value. You define both.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50
    ///
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only
    /// one value.
    ///
    /// * Maximum key length - 128 Unicode characters in UTF-8
    ///
    /// * Maximum value length - 256 Unicode characters in UTF-8
    ///
    /// * If your tagging schema is used across multiple services and resources,
    /// remember that other services may have restrictions on allowed characters.
    /// Generally allowed characters are: letters, numbers, and spaces representable
    /// in
    /// UTF-8, and the following characters: + - = . _ : / @.
    ///
    /// * Tag keys and values are case-sensitive.
    ///
    /// * Do not use `aws:`, `AWS:`, or any upper or lowercase
    /// combination of such as a prefix for either keys or values as it is reserved
    /// for
    /// Amazon Web
    /// Services use. You cannot edit or delete tag keys or values with
    /// this prefix. Tags with this prefix do not count against your tags per
    /// resource
    /// limit.
    tags: ?[]const Tag,

    /// The task definition that the task set is using.
    task_definition: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the task set.
    task_set_arn: ?[]const u8,

    /// The Unix timestamp for the time when the task set was last updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .capacity_provider_strategy = "capacityProviderStrategy",
        .cluster_arn = "clusterArn",
        .computed_desired_count = "computedDesiredCount",
        .created_at = "createdAt",
        .external_id = "externalId",
        .fargate_ephemeral_storage = "fargateEphemeralStorage",
        .id = "id",
        .launch_type = "launchType",
        .load_balancers = "loadBalancers",
        .network_configuration = "networkConfiguration",
        .pending_count = "pendingCount",
        .platform_family = "platformFamily",
        .platform_version = "platformVersion",
        .running_count = "runningCount",
        .scale = "scale",
        .service_arn = "serviceArn",
        .service_registries = "serviceRegistries",
        .stability_status = "stabilityStatus",
        .stability_status_at = "stabilityStatusAt",
        .started_by = "startedBy",
        .status = "status",
        .tags = "tags",
        .task_definition = "taskDefinition",
        .task_set_arn = "taskSetArn",
        .updated_at = "updatedAt",
    };
};
