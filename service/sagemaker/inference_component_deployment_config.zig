const AutoRollbackConfig = @import("auto_rollback_config.zig").AutoRollbackConfig;
const InferenceComponentRollingUpdatePolicy = @import("inference_component_rolling_update_policy.zig").InferenceComponentRollingUpdatePolicy;

/// The deployment configuration for an endpoint that hosts inference
/// components. The configuration includes the desired deployment strategy and
/// rollback settings.
pub const InferenceComponentDeploymentConfig = struct {
    auto_rollback_configuration: ?AutoRollbackConfig,

    /// Specifies a rolling deployment strategy for updating a SageMaker AI
    /// endpoint.
    rolling_update_policy: InferenceComponentRollingUpdatePolicy,

    pub const json_field_names = .{
        .auto_rollback_configuration = "AutoRollbackConfiguration",
        .rolling_update_policy = "RollingUpdatePolicy",
    };
};
