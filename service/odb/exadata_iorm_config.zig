const DbIormConfig = @import("db_iorm_config.zig").DbIormConfig;
const IormLifecycleState = @import("iorm_lifecycle_state.zig").IormLifecycleState;
const Objective = @import("objective.zig").Objective;

/// The IORM settings of the Exadata DB system.
pub const ExadataIormConfig = struct {
    /// An array of IORM settings for all the database in the Exadata DB system.
    db_plans: ?[]const DbIormConfig = null,

    /// Additional information about the current lifecycleState.
    lifecycle_details: ?[]const u8 = null,

    /// The current state of IORM configuration for the Exadata DB system.
    lifecycle_state: ?IormLifecycleState = null,

    /// The current value for the IORM objective. The default is AUTO.
    objective: ?Objective = null,

    pub const json_field_names = .{
        .db_plans = "dbPlans",
        .lifecycle_details = "lifecycleDetails",
        .lifecycle_state = "lifecycleState",
        .objective = "objective",
    };
};
