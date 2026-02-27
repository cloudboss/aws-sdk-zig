const LifecycleEvent = @import("lifecycle_event.zig").LifecycleEvent;
const TargetStatus = @import("target_status.zig").TargetStatus;
const ECSTaskSet = @import("ecs_task_set.zig").ECSTaskSet;

/// Information about the target of an Amazon ECS deployment.
pub const ECSTarget = struct {
    /// The unique ID of a deployment.
    deployment_id: ?[]const u8,

    /// The date and time when the target Amazon ECS application was updated by a
    /// deployment.
    last_updated_at: ?i64,

    /// The lifecycle events of the deployment to this target Amazon ECS
    /// application.
    lifecycle_events: ?[]const LifecycleEvent,

    /// The status an Amazon ECS deployment's target ECS application.
    status: ?TargetStatus,

    /// The Amazon Resource Name (ARN) of the target.
    target_arn: ?[]const u8,

    /// The unique ID of a deployment target that has a type of `ecsTarget`.
    target_id: ?[]const u8,

    /// The `ECSTaskSet` objects associated with the ECS target.
    task_sets_info: ?[]const ECSTaskSet,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
        .last_updated_at = "lastUpdatedAt",
        .lifecycle_events = "lifecycleEvents",
        .status = "status",
        .target_arn = "targetArn",
        .target_id = "targetId",
        .task_sets_info = "taskSetsInfo",
    };
};
