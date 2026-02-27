const HumanLoopActivationConditionsConfig = @import("human_loop_activation_conditions_config.zig").HumanLoopActivationConditionsConfig;

/// Provides information about how and under what conditions SageMaker creates a
/// human loop. If `HumanLoopActivationConfig` is not given, then all requests
/// go to humans.
pub const HumanLoopActivationConfig = struct {
    /// Container structure for defining under what conditions SageMaker creates a
    /// human loop.
    human_loop_activation_conditions_config: HumanLoopActivationConditionsConfig,

    pub const json_field_names = .{
        .human_loop_activation_conditions_config = "HumanLoopActivationConditionsConfig",
    };
};
