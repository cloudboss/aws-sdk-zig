const InstanceType = @import("instance_type.zig").InstanceType;
const LifecycleEvent = @import("lifecycle_event.zig").LifecycleEvent;
const InstanceStatus = @import("instance_status.zig").InstanceStatus;

/// Information about an instance in a deployment.
pub const InstanceSummary = struct {
    /// The unique ID of a deployment.
    deployment_id: ?[]const u8 = null,

    /// The instance ID.
    instance_id: ?[]const u8 = null,

    /// Information about which environment an instance belongs to in a blue/green
    /// deployment.
    ///
    /// * BLUE: The instance is part of the original environment.
    ///
    /// * GREEN: The instance is part of the replacement environment.
    instance_type: ?InstanceType = null,

    /// A timestamp that indicates when the instance information was last updated.
    last_updated_at: ?i64 = null,

    /// A list of lifecycle events for this instance.
    lifecycle_events: ?[]const LifecycleEvent = null,

    /// The deployment status for this instance:
    ///
    /// * `Pending`: The deployment is pending for this instance.
    ///
    /// * `In Progress`: The deployment is in progress for this
    /// instance.
    ///
    /// * `Succeeded`: The deployment has succeeded for this instance.
    ///
    /// * `Failed`: The deployment has failed for this instance.
    ///
    /// * `Skipped`: The deployment has been skipped for this
    /// instance.
    ///
    /// * `Unknown`: The deployment status is unknown for this
    /// instance.
    status: ?InstanceStatus = null,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
        .instance_id = "instanceId",
        .instance_type = "instanceType",
        .last_updated_at = "lastUpdatedAt",
        .lifecycle_events = "lifecycleEvents",
        .status = "status",
    };
};
