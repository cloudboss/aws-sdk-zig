const ServerStepConfiguration = @import("server_step_configuration.zig").ServerStepConfiguration;
const WaitStepConfiguration = @import("wait_step_configuration.zig").WaitStepConfiguration;

/// Type-specific configuration for a recovery plan step.
/// Exactly one member must be set.
pub const RecoveryPlanStepConfiguration = union(enum) {
    /// Configuration for a SERVER type step.
    server_step_configuration: ?ServerStepConfiguration,
    /// Configuration for a WAIT type step.
    wait_step_configuration: ?WaitStepConfiguration,

    pub const json_field_names = .{
        .server_step_configuration = "serverStepConfiguration",
        .wait_step_configuration = "waitStepConfiguration",
    };
};
