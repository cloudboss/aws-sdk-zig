const MultiAzDisasterRecoveryApproach = @import("multi_az_disaster_recovery_approach.zig").MultiAzDisasterRecoveryApproach;

/// Defines the multi-AZ disaster recovery targets for a resilience policy.
pub const MultiAzTargets = struct {
    /// The disaster recovery approach for multi-AZ.
    disaster_recovery_approach: ?MultiAzDisasterRecoveryApproach = null,

    /// The recovery point objective (RPO) target for multi-AZ, in minutes.
    rpo_in_minutes: ?i32 = null,

    /// The recovery time objective (RTO) target for multi-AZ, in minutes.
    rto_in_minutes: ?i32 = null,

    pub const json_field_names = .{
        .disaster_recovery_approach = "disasterRecoveryApproach",
        .rpo_in_minutes = "rpoInMinutes",
        .rto_in_minutes = "rtoInMinutes",
    };
};
