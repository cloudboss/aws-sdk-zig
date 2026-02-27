const SearchableRoutingCriteriaStep = @import("searchable_routing_criteria_step.zig").SearchableRoutingCriteriaStep;

/// Routing criteria of the contact to match on.
pub const SearchableRoutingCriteria = struct {
    /// The list of Routing criteria steps of the contact routing.
    steps: ?[]const SearchableRoutingCriteriaStep,

    pub const json_field_names = .{
        .steps = "Steps",
    };
};
