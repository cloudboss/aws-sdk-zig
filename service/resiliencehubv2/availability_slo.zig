/// Defines the availability service level objective (SLO) for a resilience
/// policy.
pub const AvailabilitySlo = struct {
    /// The target availability percentage, expressed as a value between 0 and 100.
    target: ?f64 = null,

    pub const json_field_names = .{
        .target = "target",
    };
};
