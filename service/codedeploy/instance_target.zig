const TargetLabel = @import("target_label.zig").TargetLabel;
const LifecycleEvent = @import("lifecycle_event.zig").LifecycleEvent;
const TargetStatus = @import("target_status.zig").TargetStatus;

/// A target Amazon EC2 or on-premises instance during a deployment that uses
/// the
/// EC2/On-premises compute platform.
pub const InstanceTarget = struct {
    /// The unique ID of a deployment.
    deployment_id: ?[]const u8,

    /// A label that identifies whether the instance is an original target
    /// (`BLUE`) or a replacement target (`GREEN`).
    instance_label: ?TargetLabel,

    /// The date and time when the target instance was updated by a deployment.
    last_updated_at: ?i64,

    /// The lifecycle events of the deployment to this target instance.
    lifecycle_events: ?[]const LifecycleEvent,

    /// The status an EC2/On-premises deployment's target instance.
    status: ?TargetStatus,

    /// The Amazon Resource Name (ARN) of the target.
    target_arn: ?[]const u8,

    /// The unique ID of a deployment target that has a type of `instanceTarget`.
    target_id: ?[]const u8,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
        .instance_label = "instanceLabel",
        .last_updated_at = "lastUpdatedAt",
        .lifecycle_events = "lifecycleEvents",
        .status = "status",
        .target_arn = "targetArn",
        .target_id = "targetId",
    };
};
