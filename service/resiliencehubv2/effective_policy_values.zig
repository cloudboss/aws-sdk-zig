const SloSource = @import("slo_source.zig").SloSource;
const TargetSource = @import("target_source.zig").TargetSource;
const DisasterRecoverySource = @import("disaster_recovery_source.zig").DisasterRecoverySource;

/// Contains the effective resilience policy values for a service.
pub const EffectivePolicyValues = struct {
    /// The effective availability SLO value for the service.
    availability_slo: ?SloSource = null,

    /// The effective data recovery time between backups value for the service.
    data_recovery_time_between_backups: ?TargetSource = null,

    /// The effective multi-AZ disaster recovery approach for the service.
    multi_az_dr_approach: ?DisasterRecoverySource = null,

    /// The effective multi-AZ RPO value for the service, in minutes.
    multi_az_rpo: ?TargetSource = null,

    /// The effective multi-AZ RTO value for the service, in minutes.
    multi_az_rto: ?TargetSource = null,

    /// The effective multi-Region disaster recovery approach for the service.
    multi_region_dr_approach: ?DisasterRecoverySource = null,

    /// The effective multi-Region RPO value for the service, in minutes.
    multi_region_rpo: ?TargetSource = null,

    /// The effective multi-Region RTO value for the service, in minutes.
    multi_region_rto: ?TargetSource = null,

    pub const json_field_names = .{
        .availability_slo = "availabilitySlo",
        .data_recovery_time_between_backups = "dataRecoveryTimeBetweenBackups",
        .multi_az_dr_approach = "multiAzDrApproach",
        .multi_az_rpo = "multiAzRpo",
        .multi_az_rto = "multiAzRto",
        .multi_region_dr_approach = "multiRegionDrApproach",
        .multi_region_rpo = "multiRegionRpo",
        .multi_region_rto = "multiRegionRto",
    };
};
