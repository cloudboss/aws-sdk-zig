const Tag = @import("tag.zig").Tag;
const EcsTaskDetails = @import("ecs_task_details.zig").EcsTaskDetails;

/// Contains information about the details of the ECS Cluster.
pub const EcsClusterDetails = struct {
    /// The number of services that are running on the cluster in an ACTIVE state.
    active_services_count: ?i32 = null,

    /// The Amazon Resource Name (ARN) that identifies the cluster.
    arn: ?[]const u8 = null,

    /// The name of the ECS Cluster.
    name: ?[]const u8 = null,

    /// The number of container instances registered into the cluster.
    registered_container_instances_count: ?i32 = null,

    /// The number of tasks in the cluster that are in the RUNNING state.
    running_tasks_count: ?i32 = null,

    /// The status of the ECS cluster.
    status: ?[]const u8 = null,

    /// The tags of the ECS Cluster.
    tags: ?[]const Tag = null,

    /// Contains information about the details of the ECS Task.
    task_details: ?EcsTaskDetails = null,

    pub const json_field_names = .{
        .active_services_count = "ActiveServicesCount",
        .arn = "Arn",
        .name = "Name",
        .registered_container_instances_count = "RegisteredContainerInstancesCount",
        .running_tasks_count = "RunningTasksCount",
        .status = "Status",
        .tags = "Tags",
        .task_details = "TaskDetails",
    };
};
