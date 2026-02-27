const PeriodUnit = @import("period_unit.zig").PeriodUnit;

/// Defines a limit and the time period during which it is enforced.
pub const Period = struct {
    /// The maximum allowed number of destination invocations per profile.
    max_invocations_per_profile: ?i32,

    /// The unit of time.
    unit: PeriodUnit,

    /// If set to true, there is no limit on the number of destination invocations
    /// per profile.
    /// The default is false.
    unlimited: bool = false,

    /// The amount of time of the specified unit.
    value: i32,

    pub const json_field_names = .{
        .max_invocations_per_profile = "MaxInvocationsPerProfile",
        .unit = "Unit",
        .unlimited = "Unlimited",
        .value = "Value",
    };
};
