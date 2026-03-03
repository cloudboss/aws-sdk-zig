const AutoTuneDesiredState = @import("auto_tune_desired_state.zig").AutoTuneDesiredState;
const AutoTuneMaintenanceSchedule = @import("auto_tune_maintenance_schedule.zig").AutoTuneMaintenanceSchedule;
const RollbackOnDisable = @import("rollback_on_disable.zig").RollbackOnDisable;

/// Auto-Tune settings when updating a domain. For more information, see
/// [Auto-Tune for Amazon OpenSearch
/// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/auto-tune.html).
pub const AutoTuneOptions = struct {
    /// Whether Auto-Tune is enabled or disabled.
    desired_state: ?AutoTuneDesiredState = null,

    /// DEPRECATED. Use [off-peak
    /// window](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/off-peak.html)
    /// instead.
    ///
    /// A list of maintenance schedules during which Auto-Tune can deploy changes.
    maintenance_schedules: ?[]const AutoTuneMaintenanceSchedule = null,

    /// When disabling Auto-Tune, specify `NO_ROLLBACK` to retain all prior
    /// Auto-Tune settings or `DEFAULT_ROLLBACK` to revert to the OpenSearch Service
    /// defaults. If you specify `DEFAULT_ROLLBACK`, you must include a
    /// `MaintenanceSchedule` in the request. Otherwise, OpenSearch Service is
    /// unable to perform the rollback.
    rollback_on_disable: ?RollbackOnDisable = null,

    /// Whether to use the domain's [off-peak
    /// window](https://docs.aws.amazon.com/opensearch-service/latest/APIReference/API_OffPeakWindow.html) to deploy configuration changes on the domain rather than a
    /// maintenance schedule.
    use_off_peak_window: ?bool = null,

    pub const json_field_names = .{
        .desired_state = "DesiredState",
        .maintenance_schedules = "MaintenanceSchedules",
        .rollback_on_disable = "RollbackOnDisable",
        .use_off_peak_window = "UseOffPeakWindow",
    };
};
