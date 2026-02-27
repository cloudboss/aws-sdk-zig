const LifecyclePolicyTimeUnit = @import("lifecycle_policy_time_unit.zig").LifecyclePolicyTimeUnit;

/// Defines criteria to exclude AMIs from lifecycle actions based on the last
/// time they were used to launch an instance.
pub const LifecyclePolicyDetailExclusionRulesAmisLastLaunched = struct {
    /// Defines the unit of time that the lifecycle policy uses to calculate elapsed
    /// time
    /// since the last instance launched from the AMI. For example: days, weeks,
    /// months, or years.
    unit: LifecyclePolicyTimeUnit,

    /// The integer number of units for the time period. For example `6` (months).
    value: i32,

    pub const json_field_names = .{
        .unit = "unit",
        .value = "value",
    };
};
