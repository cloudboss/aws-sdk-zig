/// The Spot placement score for this Region or Availability Zone. The score is
/// calculated
/// based on the assumption that the `capacity-optimized` allocation strategy is
/// used and that all of the Availability Zones in the Region can be used.
pub const SpotPlacementScore = struct {
    /// The Availability Zone.
    availability_zone_id: ?[]const u8 = null,

    /// The Region.
    region: ?[]const u8 = null,

    /// The placement score, on a scale from `1` to `10`. A score of
    /// `10` indicates that your Spot request is highly likely to succeed in this
    /// Region or Availability Zone. A score of `1` indicates that your Spot request
    /// is
    /// not likely to succeed.
    score: ?i32 = null,
};
