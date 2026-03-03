/// Set this period to specify how long your data is stored in the warm tier
/// before it is deleted. You can set this only if cold tier is enabled.
pub const WarmTierRetentionPeriod = struct {
    /// The number of days the data is stored in the warm tier.
    number_of_days: ?i32 = null,

    /// If set to true, the data is stored indefinitely in the warm tier.
    unlimited: ?bool = null,

    pub const json_field_names = .{
        .number_of_days = "numberOfDays",
        .unlimited = "unlimited",
    };
};
