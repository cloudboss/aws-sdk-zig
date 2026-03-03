const AutoTuneDesiredState = @import("auto_tune_desired_state.zig").AutoTuneDesiredState;
const AutoTuneMaintenanceSchedule = @import("auto_tune_maintenance_schedule.zig").AutoTuneMaintenanceSchedule;

/// Specifies the Auto-Tune options: the Auto-Tune desired state for the domain
/// and list of maintenance schedules.
pub const AutoTuneOptionsInput = struct {
    /// Specifies the Auto-Tune desired state. Valid values are ENABLED, DISABLED.
    desired_state: ?AutoTuneDesiredState = null,

    /// Specifies list of maitenance schedules. See the [Developer
    /// Guide](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/auto-tune.html) for more information.
    maintenance_schedules: ?[]const AutoTuneMaintenanceSchedule = null,

    pub const json_field_names = .{
        .desired_state = "DesiredState",
        .maintenance_schedules = "MaintenanceSchedules",
    };
};
