/// Specify whether this routing criteria step should apply for only a limited
/// amount of time, or if it should never
/// expire.
pub const RoutingCriteriaInputStepExpiry = struct {
    /// The number of seconds that the contact will be routed only to agents
    /// matching this routing step, if expiry was
    /// configured for this routing step.
    duration_in_seconds: ?i32,

    pub const json_field_names = .{
        .duration_in_seconds = "DurationInSeconds",
    };
};
