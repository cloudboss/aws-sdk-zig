const AutoTuneDesiredState = @import("auto_tune_desired_state.zig").AutoTuneDesiredState;
const AutoTuneMaintenanceSchedule = @import("auto_tune_maintenance_schedule.zig").AutoTuneMaintenanceSchedule;

/// Options for configuring Auto-Tune. For more information, see [Auto-Tune for
/// Amazon OpenSearch
/// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/auto-tune.html)
pub const AutoTuneOptionsInput = struct {
    /// Whether Auto-Tune is enabled or disabled.
    desired_state: ?AutoTuneDesiredState,

    /// A list of maintenance schedules during which Auto-Tune can deploy changes.
    /// Maintenance
    /// windows are deprecated and have been replaced with [off-peak
    /// windows](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/off-peak.html).
    maintenance_schedules: ?[]const AutoTuneMaintenanceSchedule,

    /// Whether to schedule Auto-Tune optimizations that require blue/green
    /// deployments during
    /// the domain's configured daily off-peak window.
    use_off_peak_window: ?bool,

    pub const json_field_names = .{
        .desired_state = "DesiredState",
        .maintenance_schedules = "MaintenanceSchedules",
        .use_off_peak_window = "UseOffPeakWindow",
    };
};
