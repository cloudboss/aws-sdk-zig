/// This API enables you to specify the duration that the camera,
/// or local media file, should record onto the Edge Agent. The `ScheduleConfig`
/// consists of the `ScheduleExpression` and the
/// `DurationInMinutes` attributes.
///
/// If the `ScheduleConfig` is not provided in the `RecorderConfig`,
/// then the Edge Agent will always be set to recording mode.
///
/// If the `ScheduleConfig` is not provided in the `UploaderConfig`,
/// then the Edge Agent will upload at regular intervals (every 1 hour).
pub const ScheduleConfig = struct {
    /// The total duration to record the media. If the `ScheduleExpression`
    /// attribute is provided, then the
    /// `DurationInSeconds` attribute should also be specified.
    duration_in_seconds: i32,

    /// The Quartz cron expression that takes care of scheduling jobs to record from
    /// the
    /// camera, or local media file, onto the Edge Agent. If the
    /// `ScheduleExpression` is not provided for the `RecorderConfig`,
    /// then the Edge Agent will always be set to recording mode.
    ///
    /// For more information about Quartz, refer to the
    /// [
    /// *Cron Trigger Tutorial*
    /// ](https://www.quartz-scheduler.org/documentation/quartz-2.3.0/tutorials/crontrigger.html) page to understand the valid expressions and its use.
    schedule_expression: []const u8,

    pub const json_field_names = .{
        .duration_in_seconds = "DurationInSeconds",
        .schedule_expression = "ScheduleExpression",
    };
};
