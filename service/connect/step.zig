const Expiry = @import("expiry.zig").Expiry;
const Expression = @import("expression.zig").Expression;
const RoutingCriteriaStepStatus = @import("routing_criteria_step_status.zig").RoutingCriteriaStepStatus;

/// Step signifies the criteria to be used for routing to an agent
pub const Step = struct {
    /// An object to specify the expiration of a routing step.
    expiry: ?Expiry = null,

    /// A tagged union to specify expression for a routing step.
    expression: ?Expression = null,

    /// Represents status of the Routing step.
    status: ?RoutingCriteriaStepStatus = null,

    pub const json_field_names = .{
        .expiry = "Expiry",
        .expression = "Expression",
        .status = "Status",
    };
};
