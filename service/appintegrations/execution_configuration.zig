const ExecutionMode = @import("execution_mode.zig").ExecutionMode;
const OnDemandConfiguration = @import("on_demand_configuration.zig").OnDemandConfiguration;
const ScheduleConfiguration = @import("schedule_configuration.zig").ScheduleConfiguration;

/// The configuration for how the files should be pulled from the source.
pub const ExecutionConfiguration = struct {
    /// The mode for data import/export execution.
    execution_mode: ExecutionMode,

    on_demand_configuration: ?OnDemandConfiguration,

    schedule_configuration: ?ScheduleConfiguration,

    pub const json_field_names = .{
        .execution_mode = "ExecutionMode",
        .on_demand_configuration = "OnDemandConfiguration",
        .schedule_configuration = "ScheduleConfiguration",
    };
};
