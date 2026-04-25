const AvailabilityZoneBalanceEnforcementMode = @import("availability_zone_balance_enforcement_mode.zig").AvailabilityZoneBalanceEnforcementMode;

/// Configuration for balancing inference component copies across Availability
/// Zones.
pub const InferenceComponentAvailabilityZoneBalance = struct {
    /// Determines how strictly the Availability Zone balance constraint is
    /// enforced.
    ///
    /// **PERMISSIVE**
    ///
    /// The endpoint attempts to balance copies across Availability Zones but
    /// proceeds with scheduling even if balance can't be achieved due to available
    /// capacity or instance distribution across Availability Zones.
    enforcement_mode: AvailabilityZoneBalanceEnforcementMode,

    /// The maximum allowed difference in the number of inference component copies
    /// between any two Availability Zones. This parameter applies only when the
    /// endpoint has instances across two or more Availability Zones. A copy
    /// placement is allowed if it reduces imbalance or the resulting imbalance is
    /// within this value.
    ///
    /// Default value: `0`.
    max_imbalance: ?i32 = null,

    pub const json_field_names = .{
        .enforcement_mode = "EnforcementMode",
        .max_imbalance = "MaxImbalance",
    };
};
