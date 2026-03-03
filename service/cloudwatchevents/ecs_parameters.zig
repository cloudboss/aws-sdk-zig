const CapacityProviderStrategyItem = @import("capacity_provider_strategy_item.zig").CapacityProviderStrategyItem;
const LaunchType = @import("launch_type.zig").LaunchType;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const PlacementConstraint = @import("placement_constraint.zig").PlacementConstraint;
const PlacementStrategy = @import("placement_strategy.zig").PlacementStrategy;
const PropagateTags = @import("propagate_tags.zig").PropagateTags;
const Tag = @import("tag.zig").Tag;

/// The custom parameters to be used when the target is an Amazon ECS task.
pub const EcsParameters = struct {
    /// The capacity provider strategy to use for the task.
    ///
    /// If a `capacityProviderStrategy` is specified, the `launchType`
    /// parameter must be omitted. If no `capacityProviderStrategy` or launchType is
    /// specified, the `defaultCapacityProviderStrategy` for the cluster is used.
    capacity_provider_strategy: ?[]const CapacityProviderStrategyItem = null,

    /// Specifies whether to enable Amazon ECS managed tags for the task. For more
    /// information,
    /// see [Tagging Your Amazon ECS
    /// Resources](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-using-tags.html) in the Amazon Elastic Container Service Developer
    /// Guide.
    enable_ecs_managed_tags: bool = false,

    /// Whether or not to enable the execute command functionality for the
    /// containers in this
    /// task. If true, this enables execute command functionality on all containers
    /// in the
    /// task.
    enable_execute_command: bool = false,

    /// Specifies an ECS task group for the task. The maximum length is 255
    /// characters.
    group: ?[]const u8 = null,

    /// Specifies the launch type on which your task is running. The launch type
    /// that you specify
    /// here must match one of the launch type (compatibilities) of the target task.
    /// The
    /// `FARGATE` value is supported only in the Regions where Fargate witt Amazon
    /// ECS
    /// is supported. For more information, see [Fargate on Amazon
    /// ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS-Fargate.html) in
    /// the *Amazon Elastic Container Service Developer Guide*.
    launch_type: ?LaunchType = null,

    /// Use this structure if the Amazon ECS task uses the `awsvpc` network mode.
    /// This
    /// structure specifies the VPC subnets and security groups associated with the
    /// task, and whether
    /// a public IP address is to be used. This structure is required if
    /// `LaunchType` is
    /// `FARGATE` because the `awsvpc` mode is required for Fargate
    /// tasks.
    ///
    /// If you specify `NetworkConfiguration` when the target ECS task does not use
    /// the
    /// `awsvpc` network mode, the task fails.
    network_configuration: ?NetworkConfiguration = null,

    /// An array of placement constraint objects to use for the task. You can
    /// specify up to 10
    /// constraints per task (including constraints in the task definition and those
    /// specified at
    /// runtime).
    placement_constraints: ?[]const PlacementConstraint = null,

    /// The placement strategy objects to use for the task. You can specify a
    /// maximum of five
    /// strategy rules per task.
    placement_strategy: ?[]const PlacementStrategy = null,

    /// Specifies the platform version for the task. Specify only the numeric
    /// portion of the
    /// platform version, such as `1.1.0`.
    ///
    /// This structure is used only if `LaunchType` is `FARGATE`. For more
    /// information about valid platform versions, see [Fargate Platform
    /// Versions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    platform_version: ?[]const u8 = null,

    /// Specifies whether to propagate the tags from the task definition to the
    /// task. If no value
    /// is specified, the tags are not propagated. Tags can only be propagated to
    /// the task during task
    /// creation. To add tags to a task after task creation, use the TagResource API
    /// action.
    propagate_tags: ?PropagateTags = null,

    /// The reference ID to use for the task.
    reference_id: ?[]const u8 = null,

    /// The metadata that you apply to the task to help you categorize and organize
    /// them. Each tag
    /// consists of a key and an optional value, both of which you define. To learn
    /// more, see
    /// [RunTask](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_RunTask.html#ECS-RunTask-request-tags) in the Amazon ECS API Reference.
    tags: ?[]const Tag = null,

    /// The number of tasks to create based on `TaskDefinition`. The default is
    /// 1.
    task_count: ?i32 = null,

    /// The ARN of the task definition to use if the event target is an Amazon ECS
    /// task.
    task_definition_arn: []const u8,

    pub const json_field_names = .{
        .capacity_provider_strategy = "CapacityProviderStrategy",
        .enable_ecs_managed_tags = "EnableECSManagedTags",
        .enable_execute_command = "EnableExecuteCommand",
        .group = "Group",
        .launch_type = "LaunchType",
        .network_configuration = "NetworkConfiguration",
        .placement_constraints = "PlacementConstraints",
        .placement_strategy = "PlacementStrategy",
        .platform_version = "PlatformVersion",
        .propagate_tags = "PropagateTags",
        .reference_id = "ReferenceId",
        .tags = "Tags",
        .task_count = "TaskCount",
        .task_definition_arn = "TaskDefinitionArn",
    };
};
