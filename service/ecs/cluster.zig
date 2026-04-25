const Attachment = @import("attachment.zig").Attachment;
const ClusterConfiguration = @import("cluster_configuration.zig").ClusterConfiguration;
const CapacityProviderStrategyItem = @import("capacity_provider_strategy_item.zig").CapacityProviderStrategyItem;
const ClusterServiceConnectDefaults = @import("cluster_service_connect_defaults.zig").ClusterServiceConnectDefaults;
const ClusterSetting = @import("cluster_setting.zig").ClusterSetting;
const KeyValuePair = @import("key_value_pair.zig").KeyValuePair;
const Tag = @import("tag.zig").Tag;

/// A regional grouping of one or more container instances where you can run
/// task requests. Each account receives a default cluster the first time you
/// use the Amazon ECS service, but you may also create other clusters. Clusters
/// may contain more than one instance type simultaneously.
pub const Cluster = struct {
    /// The number of services that are running on the cluster in an `ACTIVE` state.
    /// You can view these services with
    /// [ListServices](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ListServices.html).
    active_services_count: i32 = 0,

    /// The resources attached to a cluster. When using a capacity provider with a
    /// cluster, the capacity provider and associated resources are returned as
    /// cluster attachments.
    attachments: ?[]const Attachment = null,

    /// The status of the capacity providers associated with the cluster. The
    /// following are the states that are returned.
    ///
    /// **UPDATE_IN_PROGRESS**
    ///
    /// The available capacity providers for the cluster are updating.
    ///
    /// **UPDATE_COMPLETE**
    ///
    /// The capacity providers have successfully updated.
    ///
    /// **UPDATE_FAILED**
    ///
    /// The capacity provider updates failed.
    attachments_status: ?[]const u8 = null,

    /// The capacity providers associated with the cluster.
    capacity_providers: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) that identifies the cluster. For more
    /// information about the ARN format, see [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-account-settings.html#ecs-resource-ids) in the *Amazon ECS Developer Guide*.
    cluster_arn: ?[]const u8 = null,

    /// A user-generated string that you use to identify your cluster.
    cluster_name: ?[]const u8 = null,

    /// The execute command and managed storage configuration for the cluster.
    configuration: ?ClusterConfiguration = null,

    /// The default capacity provider strategy for the cluster. When services or
    /// tasks are run in the cluster with no launch type or capacity provider
    /// strategy specified, the default capacity provider strategy is used.
    default_capacity_provider_strategy: ?[]const CapacityProviderStrategyItem = null,

    /// The number of tasks in the cluster that are in the `PENDING` state.
    pending_tasks_count: i32 = 0,

    /// The number of container instances registered into the cluster. This includes
    /// container instances in both `ACTIVE` and `DRAINING` status.
    registered_container_instances_count: i32 = 0,

    /// The number of tasks in the cluster that are in the `RUNNING` state.
    running_tasks_count: i32 = 0,

    /// Use this parameter to set a default Service Connect namespace. After you set
    /// a default Service Connect namespace, any new services with Service Connect
    /// turned on that are created in the cluster are added as client services in
    /// the namespace. This setting only applies to new services that set the
    /// `enabled` parameter to `true` in the `ServiceConnectConfiguration`. You can
    /// set the namespace of each service individually in the
    /// `ServiceConnectConfiguration` to override this default parameter.
    ///
    /// Tasks that run in a namespace can use short names to connect to services in
    /// the namespace. Tasks can connect to services across all of the clusters in
    /// the namespace. Tasks connect through a managed proxy container that collects
    /// logs and metrics for increased visibility. Only the tasks that Amazon ECS
    /// services create are supported with Service Connect. For more information,
    /// see [Service
    /// Connect](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect.html) in the *Amazon Elastic Container Service Developer Guide*.
    service_connect_defaults: ?ClusterServiceConnectDefaults = null,

    /// The settings for the cluster. This parameter indicates whether CloudWatch
    /// Container Insights is on or off for a cluster.
    settings: ?[]const ClusterSetting = null,

    /// Additional information about your clusters that are separated by launch
    /// type. They include the following:
    ///
    /// * runningEC2TasksCount
    /// * RunningFargateTasksCount
    /// * pendingEC2TasksCount
    /// * pendingFargateTasksCount
    /// * activeEC2ServiceCount
    /// * activeFargateServiceCount
    /// * drainingEC2ServiceCount
    /// * drainingFargateServiceCount
    statistics: ?[]const KeyValuePair = null,

    /// The status of the cluster. The following are the possible states that are
    /// returned.
    ///
    /// **ACTIVE**
    ///
    /// The cluster is ready to accept tasks and if applicable you can register
    /// container instances with the cluster.
    ///
    /// **PROVISIONING**
    ///
    /// The cluster has capacity providers that are associated with it and the
    /// resources needed for the capacity provider are being created.
    ///
    /// **DEPROVISIONING**
    ///
    /// The cluster has capacity providers that are associated with it and the
    /// resources needed for the capacity provider are being deleted.
    ///
    /// **FAILED**
    ///
    /// The cluster has capacity providers that are associated with it and the
    /// resources needed for the capacity provider have failed to create.
    ///
    /// **INACTIVE**
    ///
    /// The cluster has been deleted. Clusters with an `INACTIVE` status may remain
    /// discoverable in your account for a period of time. However, this behavior is
    /// subject to change in the future. We don't recommend that you rely on
    /// `INACTIVE` clusters persisting.
    status: ?[]const u8 = null,

    /// The metadata that you apply to the cluster to help you categorize and
    /// organize them. Each tag consists of a key and an optional value. You define
    /// both.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only one value.
    /// * Maximum key length - 128 Unicode characters in UTF-8
    /// * Maximum value length - 256 Unicode characters in UTF-8
    /// * If your tagging schema is used across multiple services and resources,
    ///   remember that other services may have restrictions on allowed characters.
    ///   Generally allowed characters are: letters, numbers, and spaces
    ///   representable in UTF-8, and the following characters: + - = . _ : / @.
    /// * Tag keys and values are case-sensitive.
    /// * Do not use `aws:`, `AWS:`, or any upper or lowercase combination of such
    ///   as a prefix for either keys or values as it is reserved for Amazon Web
    ///   Services use. You cannot edit or delete tag keys or values with this
    ///   prefix. Tags with this prefix do not count against your tags per resource
    ///   limit.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .active_services_count = "activeServicesCount",
        .attachments = "attachments",
        .attachments_status = "attachmentsStatus",
        .capacity_providers = "capacityProviders",
        .cluster_arn = "clusterArn",
        .cluster_name = "clusterName",
        .configuration = "configuration",
        .default_capacity_provider_strategy = "defaultCapacityProviderStrategy",
        .pending_tasks_count = "pendingTasksCount",
        .registered_container_instances_count = "registeredContainerInstancesCount",
        .running_tasks_count = "runningTasksCount",
        .service_connect_defaults = "serviceConnectDefaults",
        .settings = "settings",
        .statistics = "statistics",
        .status = "status",
        .tags = "tags",
    };
};
