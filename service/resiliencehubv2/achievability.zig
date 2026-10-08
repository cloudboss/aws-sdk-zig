const AchievabilityStatus = @import("achievability_status.zig").AchievabilityStatus;

/// Describes the achievability status of a service's resilience targets based
/// on the most recent assessment.
pub const Achievability = struct {
    /// The achievability status of the availability SLO target for the service.
    availability_slo: ?AchievabilityStatus = null,

    /// The achievability status of the data recovery time between backups for the
    /// service.
    data_recovery_time_between_backups: ?AchievabilityStatus = null,

    /// The achievability status of the multi-AZ RTO and RPO targets for the
    /// service.
    multi_az_rto_rpo: ?AchievabilityStatus = null,

    /// The achievability status of the multi-Region RTO and RPO targets for the
    /// service.
    multi_region_rto_rpo: ?AchievabilityStatus = null,

    pub const json_field_names = .{
        .availability_slo = "availabilitySlo",
        .data_recovery_time_between_backups = "dataRecoveryTimeBetweenBackups",
        .multi_az_rto_rpo = "multiAzRtoRpo",
        .multi_region_rto_rpo = "multiRegionRtoRpo",
    };
};
