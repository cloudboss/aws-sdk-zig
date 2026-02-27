const ThumbnailRecordingMode = @import("thumbnail_recording_mode.zig").ThumbnailRecordingMode;
const ThumbnailStorageType = @import("thumbnail_storage_type.zig").ThumbnailStorageType;

/// An object representing a configuration of thumbnails for recorded video from
/// an
/// individual participant.
pub const ParticipantThumbnailConfiguration = struct {
    /// Thumbnail recording mode. Default: `DISABLED`.
    recording_mode: ?ThumbnailRecordingMode,

    /// Indicates the format in which thumbnails are recorded. `SEQUENTIAL` records
    /// all generated thumbnails in a serial manner, to the media/thumbnails/high
    /// directory.
    /// `LATEST` saves the latest thumbnail in media/latest_thumbnail/high/thumb.jpg
    /// and overwrites it at the interval specified by `targetIntervalSeconds`. You
    /// can
    /// enable both `SEQUENTIAL` and `LATEST`. Default:
    /// `SEQUENTIAL`.
    storage: ?[]const ThumbnailStorageType,

    /// The targeted thumbnail-generation interval in seconds. This is configurable
    /// only if
    /// `recordingMode` is `INTERVAL`. Default: 60.
    target_interval_seconds: ?i32,

    pub const json_field_names = .{
        .recording_mode = "recordingMode",
        .storage = "storage",
        .target_interval_seconds = "targetIntervalSeconds",
    };
};
