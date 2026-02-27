const Container = @import("container.zig").Container;
const Tag = @import("tag.zig").Tag;
const Volume = @import("volume.zig").Volume;

/// Contains information about the task in an ECS cluster.
pub const EcsTaskDetails = struct {
    /// The Amazon Resource Name (ARN) of the task.
    arn: ?[]const u8,

    /// The containers that's associated with the task.
    containers: ?[]const Container,

    /// The ARN of the task definition that creates the task.
    definition_arn: ?[]const u8,

    /// The name of the task group that's associated with the task.
    group: ?[]const u8,

    /// A capacity on which the task is running. For example, `Fargate` and `EC2`.
    launch_type: ?[]const u8,

    /// The Unix timestamp for the time when the task started.
    started_at: ?i64,

    /// Contains the tag specified when a task is started.
    started_by: ?[]const u8,

    /// The tags of the ECS Task.
    tags: ?[]const Tag,

    /// The Unix timestamp for the time when the task was created.
    task_created_at: ?i64,

    /// The version counter for the task.
    version: ?[]const u8,

    /// The list of data volume definitions for the task.
    volumes: ?[]const Volume,

    pub const json_field_names = .{
        .arn = "Arn",
        .containers = "Containers",
        .definition_arn = "DefinitionArn",
        .group = "Group",
        .launch_type = "LaunchType",
        .started_at = "StartedAt",
        .started_by = "StartedBy",
        .tags = "Tags",
        .task_created_at = "TaskCreatedAt",
        .version = "Version",
        .volumes = "Volumes",
    };
};
