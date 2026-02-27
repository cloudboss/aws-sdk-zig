const RoutingCriteriaInputStepExpiry = @import("routing_criteria_input_step_expiry.zig").RoutingCriteriaInputStepExpiry;
const Expression = @import("expression.zig").Expression;

/// Step defines the list of agents to be routed or route based on the agent
/// requirements such as ProficiencyLevel,
/// Name, or Value.
pub const RoutingCriteriaInputStep = struct {
    /// An object to specify the expiration of a routing step.
    expiry: ?RoutingCriteriaInputStepExpiry,

    /// A tagged union to specify expression for a routing step.
    expression: ?Expression,

    pub const json_field_names = .{
        .expiry = "Expiry",
        .expression = "Expression",
    };
};
