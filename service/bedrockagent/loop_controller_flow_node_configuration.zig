const FlowCondition = @import("flow_condition.zig").FlowCondition;

/// Contains configurations for the controller node of a DoWhile loop in the
/// flow.
pub const LoopControllerFlowNodeConfiguration = struct {
    /// Specifies the condition that determines when the flow exits the DoWhile
    /// loop. The loop executes until this condition evaluates to true.
    continue_condition: FlowCondition,

    /// Specifies the maximum number of times the DoWhile loop can iterate before
    /// the flow exits the loop.
    max_iterations: i32 = 10,

    pub const json_field_names = .{
        .continue_condition = "continueCondition",
        .max_iterations = "maxIterations",
    };
};
