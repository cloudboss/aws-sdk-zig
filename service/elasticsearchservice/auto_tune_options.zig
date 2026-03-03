const AutoTuneDesiredState = @import("auto_tune_desired_state.zig").AutoTuneDesiredState;
const AutoTuneMaintenanceSchedule = @import("auto_tune_maintenance_schedule.zig").AutoTuneMaintenanceSchedule;
const RollbackOnDisable = @import("rollback_on_disable.zig").RollbackOnDisable;

/// Specifies the Auto-Tune options: the Auto-Tune desired state for the domain,
/// rollback state when disabling Auto-Tune options and list of maintenance
/// schedules.
pub const AutoTuneOptions = struct {
    /// Specifies the Auto-Tune desired state. Valid values are ENABLED, DISABLED.
    desired_state: ?AutoTuneDesiredState = null,

    /// Specifies list of maitenance schedules. See the [Developer
    /// Guide](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/auto-tune.html) for more information.
    maintenance_schedules: ?[]const AutoTuneMaintenanceSchedule = null,

    /// Specifies the rollback state while disabling Auto-Tune for the domain. Valid
    /// values are NO_ROLLBACK, DEFAULT_ROLLBACK.
    rollback_on_disable: ?RollbackOnDisable = null,

    pub const json_field_names = .{
        .desired_state = "DesiredState",
        .maintenance_schedules = "MaintenanceSchedules",
        .rollback_on_disable = "RollbackOnDisable",
    };
};
