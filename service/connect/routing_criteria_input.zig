const RoutingCriteriaInputStep = @import("routing_criteria_input_step.zig").RoutingCriteriaInputStep;

/// An object to define the RoutingCriteria.
pub const RoutingCriteriaInput = struct {
    /// When Amazon Connect does not find an available agent meeting the
    /// requirements in a step for a given step
    /// duration, the routing criteria will move on to the next step sequentially
    /// until a join is completed with an agent.
    /// When all steps are exhausted, the contact will be offered to any agent in
    /// the queue.
    steps: ?[]const RoutingCriteriaInputStep = null,

    pub const json_field_names = .{
        .steps = "Steps",
    };
};
