const RecorderStatus = @import("recorder_status.zig").RecorderStatus;

/// The current status of the configuration recorder.
///
/// For a detailed status of recording events over time, add your Config events
/// to CloudWatch metrics and use CloudWatch metrics.
pub const ConfigurationRecorderStatus = struct {
    /// The Amazon Resource Name (ARN) of the configuration recorder.
    arn: ?[]const u8 = null,

    /// The latest error code from when the recorder last failed.
    last_error_code: ?[]const u8 = null,

    /// The latest error message from when the recorder last failed.
    last_error_message: ?[]const u8 = null,

    /// The time the recorder was last started.
    last_start_time: ?i64 = null,

    /// The status of the latest recording event processed by the recorder.
    last_status: ?RecorderStatus = null,

    /// The time of the latest change in status of an recording event processed by
    /// the recorder.
    last_status_change_time: ?i64 = null,

    /// The time the recorder was last stopped.
    last_stop_time: ?i64 = null,

    /// The name of the configuration recorder.
    name: ?[]const u8 = null,

    /// Specifies whether or not the recorder is currently
    /// recording.
    recording: bool = false,

    /// For service-linked configuration recorders, the service principal of the
    /// linked Amazon Web Services service.
    service_principal: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .last_error_code = "lastErrorCode",
        .last_error_message = "lastErrorMessage",
        .last_start_time = "lastStartTime",
        .last_status = "lastStatus",
        .last_status_change_time = "lastStatusChangeTime",
        .last_stop_time = "lastStopTime",
        .name = "name",
        .recording = "recording",
        .service_principal = "servicePrincipal",
    };
};
