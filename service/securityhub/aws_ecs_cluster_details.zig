const AwsEcsClusterClusterSettingsDetails = @import("aws_ecs_cluster_cluster_settings_details.zig").AwsEcsClusterClusterSettingsDetails;
const AwsEcsClusterConfigurationDetails = @import("aws_ecs_cluster_configuration_details.zig").AwsEcsClusterConfigurationDetails;
const AwsEcsClusterDefaultCapacityProviderStrategyDetails = @import("aws_ecs_cluster_default_capacity_provider_strategy_details.zig").AwsEcsClusterDefaultCapacityProviderStrategyDetails;

/// Provides details about an Amazon ECS cluster.
pub const AwsEcsClusterDetails = struct {
    /// The number of services that are running on the cluster in an `ACTIVE` state.
    /// You can view these services with the Amazon ECS [
    /// `ListServices`
    /// ](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ListServices.html) API operation.
    active_services_count: ?i32 = null,

    /// The short name of one or more capacity providers to associate with the
    /// cluster.
    capacity_providers: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) that identifies the cluster.
    cluster_arn: ?[]const u8 = null,

    /// A name that you use to identify your cluster.
    cluster_name: ?[]const u8 = null,

    /// The setting to use to create the cluster. Specifically used to configure
    /// whether to enable CloudWatch Container Insights for the cluster.
    cluster_settings: ?[]const AwsEcsClusterClusterSettingsDetails = null,

    /// The run command configuration for the cluster.
    configuration: ?AwsEcsClusterConfigurationDetails = null,

    /// The default capacity provider strategy for the cluster. The default capacity
    /// provider strategy is used when services or tasks are run without a specified
    /// launch type or capacity provider strategy.
    default_capacity_provider_strategy: ?[]const AwsEcsClusterDefaultCapacityProviderStrategyDetails = null,

    /// The number of container instances registered into the cluster. This includes
    /// container instances in both `ACTIVE` and `DRAINING` status.
    registered_container_instances_count: ?i32 = null,

    /// The number of tasks in the cluster that are in the `RUNNING` state.
    running_tasks_count: ?i32 = null,

    /// The status of the cluster.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_services_count = "ActiveServicesCount",
        .capacity_providers = "CapacityProviders",
        .cluster_arn = "ClusterArn",
        .cluster_name = "ClusterName",
        .cluster_settings = "ClusterSettings",
        .configuration = "Configuration",
        .default_capacity_provider_strategy = "DefaultCapacityProviderStrategy",
        .registered_container_instances_count = "RegisteredContainerInstancesCount",
        .running_tasks_count = "RunningTasksCount",
        .status = "Status",
    };
};
