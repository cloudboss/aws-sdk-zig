const ScheduleConfig = @import("schedule_config.zig").ScheduleConfig;

/// The configuration that consists of the `ScheduleExpression`
/// and the `DurationInMinutes` details that specify the scheduling to record
/// from a camera,
/// or local media file, onto the Edge Agent. If the `ScheduleConfig`
/// is not provided in the `UploaderConfig`, then the Edge Agent will upload at
/// regular intervals (every 1 hour).
pub const UploaderConfig = struct {
    /// The configuration that consists of the `ScheduleExpression` and the
    /// `DurationInMinutes` details that specify the scheduling to record from a
    /// camera, or
    /// local media file, onto the Edge Agent. If the `ScheduleConfig` is not
    /// provided in this `UploaderConfig`,
    /// then the Edge Agent will upload at regular intervals (every 1 hour).
    schedule_config: ScheduleConfig,

    pub const json_field_names = .{
        .schedule_config = "ScheduleConfig",
    };
};
