const AwsEcsContainerDetails = @import("aws_ecs_container_details.zig").AwsEcsContainerDetails;
const AwsEcsTaskVolumeDetails = @import("aws_ecs_task_volume_details.zig").AwsEcsTaskVolumeDetails;

/// Provides details about a task in a cluster.
pub const AwsEcsTaskDetails = struct {
    /// The Amazon Resource Name (ARN) of the cluster that hosts the task.
    cluster_arn: ?[]const u8,

    /// The containers that are associated with the task.
    containers: ?[]const AwsEcsContainerDetails,

    /// The Unix timestamp for the time when the task was created. More
    /// specifically, it's for the time when
    /// the task entered the `PENDING` state.
    created_at: ?[]const u8,

    /// The name of the task group that's associated with the task.
    group: ?[]const u8,

    /// The Unix timestamp for the time when the task started. More specifically,
    /// it's for the time when the
    /// task transitioned from the `PENDING` state to the `RUNNING` state.
    started_at: ?[]const u8,

    /// The tag specified when a task is started. If an Amazon ECS service started
    /// the task, the
    /// `startedBy` parameter contains the deployment ID of that service.
    started_by: ?[]const u8,

    /// The ARN of the task definition that creates the task.
    task_definition_arn: ?[]const u8,

    /// The version counter for the task.
    version: ?[]const u8,

    /// Details about the data volume that is used in a task definition.
    volumes: ?[]const AwsEcsTaskVolumeDetails,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .containers = "Containers",
        .created_at = "CreatedAt",
        .group = "Group",
        .started_at = "StartedAt",
        .started_by = "StartedBy",
        .task_definition_arn = "TaskDefinitionArn",
        .version = "Version",
        .volumes = "Volumes",
    };
};
