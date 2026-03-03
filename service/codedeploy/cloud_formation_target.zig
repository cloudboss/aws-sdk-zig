const LifecycleEvent = @import("lifecycle_event.zig").LifecycleEvent;
const TargetStatus = @import("target_status.zig").TargetStatus;

/// Information about the target to be updated by an CloudFormation blue/green
/// deployment. This target type is used for all deployments initiated by a
/// CloudFormation stack update.
pub const CloudFormationTarget = struct {
    /// The unique ID of an CloudFormation blue/green deployment.
    deployment_id: ?[]const u8 = null,

    /// The date and time when the target application was updated by an
    /// CloudFormation
    /// blue/green deployment.
    last_updated_at: ?i64 = null,

    /// The lifecycle events of the CloudFormation blue/green deployment to this
    /// target
    /// application.
    lifecycle_events: ?[]const LifecycleEvent = null,

    /// The resource type for the CloudFormation blue/green deployment.
    resource_type: ?[]const u8 = null,

    /// The status of an CloudFormation blue/green deployment's target application.
    status: ?TargetStatus = null,

    /// The unique ID of a deployment target that has a type
    /// of `CloudFormationTarget`.
    target_id: ?[]const u8 = null,

    /// The percentage of production traffic that the target version of an
    /// CloudFormation
    /// blue/green deployment receives.
    target_version_weight: f64 = 0,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
        .last_updated_at = "lastUpdatedAt",
        .lifecycle_events = "lifecycleEvents",
        .resource_type = "resourceType",
        .status = "status",
        .target_id = "targetId",
        .target_version_weight = "targetVersionWeight",
    };
};
