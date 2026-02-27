/// Describes a policy adjustment type.
pub const AdjustmentType = struct {
    /// The policy adjustment type. The valid values are `ChangeInCapacity`,
    /// `ExactCapacity`, and `PercentChangeInCapacity`.
    adjustment_type: ?[]const u8,
};
