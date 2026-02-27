const TimePeriod = @import("time_period.zig").TimePeriod;

/// Vehicles associated with the state template will stream telemetry data
/// during a specified time period.
pub const PeriodicStateTemplateUpdateStrategy = struct {
    state_template_update_rate: TimePeriod,

    pub const json_field_names = .{
        .state_template_update_rate = "stateTemplateUpdateRate",
    };
};
