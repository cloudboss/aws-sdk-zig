const MultiRegionDisasterRecoveryApproach = @import("multi_region_disaster_recovery_approach.zig").MultiRegionDisasterRecoveryApproach;

/// Defines the multi-Region disaster recovery targets for a resilience policy.
pub const MultiRegionTargets = struct {
    /// The disaster recovery approach for multi-Region.
    disaster_recovery_approach: ?MultiRegionDisasterRecoveryApproach = null,

    /// The recovery point objective (RPO) target for multi-Region, in minutes.
    rpo_in_minutes: ?i32 = null,

    /// The recovery time objective (RTO) target for multi-Region, in minutes.
    rto_in_minutes: ?i32 = null,

    pub const json_field_names = .{
        .disaster_recovery_approach = "disasterRecoveryApproach",
        .rpo_in_minutes = "rpoInMinutes",
        .rto_in_minutes = "rtoInMinutes",
    };
};
