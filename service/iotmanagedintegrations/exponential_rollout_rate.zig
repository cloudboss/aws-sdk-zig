const RolloutRateIncreaseCriteria = @import("rollout_rate_increase_criteria.zig").RolloutRateIncreaseCriteria;

/// Structure representing exponential rate of rollout for an over-the-air (OTA)
/// task.
pub const ExponentialRolloutRate = struct {
    /// The base rate per minute for the rollout of an over-the-air (OTA) task.
    base_rate_per_minute: ?i32,

    /// The incremental factor for increasing the rollout rate of an over-the-air
    /// (OTA) task.
    increment_factor: ?f64,

    /// The criteria for increasing the rollout rate of an over-the-air (OTA) task.
    rate_increase_criteria: ?RolloutRateIncreaseCriteria,

    pub const json_field_names = .{
        .base_rate_per_minute = "BaseRatePerMinute",
        .increment_factor = "IncrementFactor",
        .rate_increase_criteria = "RateIncreaseCriteria",
    };
};
