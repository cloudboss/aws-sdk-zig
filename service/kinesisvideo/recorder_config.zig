const MediaSourceConfig = @import("media_source_config.zig").MediaSourceConfig;
const ScheduleConfig = @import("schedule_config.zig").ScheduleConfig;

/// The recorder configuration consists of the local `MediaSourceConfig` details
/// that are used as
/// credentials to access the local media files streamed on the camera.
pub const RecorderConfig = struct {
    /// The configuration details that consist of the credentials required
    /// (`MediaUriSecretArn` and `MediaUriType`) to access the media files
    /// streamed to the camera.
    media_source_config: MediaSourceConfig,

    /// The configuration that consists of the `ScheduleExpression` and the
    /// `DurationInMinutes` details that specify the scheduling to record from a
    /// camera, or
    /// local media file, onto the Edge Agent. If the `ScheduleExpression` attribute
    /// is not provided,
    /// then the Edge Agent will always be set to recording mode.
    schedule_config: ?ScheduleConfig = null,

    pub const json_field_names = .{
        .media_source_config = "MediaSourceConfig",
        .schedule_config = "ScheduleConfig",
    };
};
