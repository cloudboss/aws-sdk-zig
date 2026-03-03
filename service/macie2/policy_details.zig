const FindingAction = @import("finding_action.zig").FindingAction;
const FindingActor = @import("finding_actor.zig").FindingActor;

/// Provides the details of a policy finding.
pub const PolicyDetails = struct {
    /// The action that produced the finding.
    action: ?FindingAction = null,

    /// The entity that performed the action that produced the finding.
    actor: ?FindingActor = null,

    pub const json_field_names = .{
        .action = "action",
        .actor = "actor",
    };
};
