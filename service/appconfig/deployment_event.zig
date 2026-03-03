const ActionInvocation = @import("action_invocation.zig").ActionInvocation;
const DeploymentEventType = @import("deployment_event_type.zig").DeploymentEventType;
const TriggeredBy = @import("triggered_by.zig").TriggeredBy;

/// An object that describes a deployment event.
pub const DeploymentEvent = struct {
    /// The list of extensions that were invoked as part of the deployment.
    action_invocations: ?[]const ActionInvocation = null,

    /// A description of the deployment event. Descriptions include, but are not
    /// limited to, the
    /// following:
    ///
    /// * The Amazon Web Services account or the Amazon CloudWatch alarm ARN that
    ///   initiated a rollback.
    ///
    /// * The percentage of hosts that received the deployment.
    ///
    /// * A recommendation to attempt a new deployment (in the case of an internal
    /// error).
    description: ?[]const u8 = null,

    /// The type of deployment event. Deployment event types include the start,
    /// stop, or
    /// completion of a deployment; a percentage update; the start or stop of a bake
    /// period; and
    /// the start or completion of a rollback.
    event_type: ?DeploymentEventType = null,

    /// The date and time the event occurred.
    occurred_at: ?i64 = null,

    /// The entity that triggered the deployment event. Events can be triggered by a
    /// user,
    /// AppConfig, an Amazon CloudWatch alarm, or an internal error.
    triggered_by: ?TriggeredBy = null,

    pub const json_field_names = .{
        .action_invocations = "ActionInvocations",
        .description = "Description",
        .event_type = "EventType",
        .occurred_at = "OccurredAt",
        .triggered_by = "TriggeredBy",
    };
};
