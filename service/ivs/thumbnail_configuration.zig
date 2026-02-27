const RecordingMode = @import("recording_mode.zig").RecordingMode;
const ThumbnailConfigurationResolution = @import("thumbnail_configuration_resolution.zig").ThumbnailConfigurationResolution;
const ThumbnailConfigurationStorage = @import("thumbnail_configuration_storage.zig").ThumbnailConfigurationStorage;

/// An object representing a configuration of thumbnails for recorded video.
pub const ThumbnailConfiguration = struct {
    /// Thumbnail recording mode. Default: `INTERVAL`.
    recording_mode: ?RecordingMode,

    /// Indicates the desired resolution of recorded thumbnails. Thumbnails are
    /// recorded at the
    /// selected resolution if the corresponding rendition is available during the
    /// stream; otherwise,
    /// they are recorded at source resolution. For more information about
    /// resolution values and their
    /// corresponding height and width dimensions, see [Auto-Record to Amazon
    /// S3](https://docs.aws.amazon.com/ivs/latest/userguide/record-to-s3.html).
    /// Default:
    /// Null (source resolution is returned).
    resolution: ?ThumbnailConfigurationResolution,

    /// Indicates the format in which thumbnails are recorded. `SEQUENTIAL` records
    /// all
    /// generated thumbnails in a serial manner, to the media/thumbnails directory.
    /// `LATEST` saves the latest thumbnail in media/latest_thumbnail/thumb.jpg and
    /// overwrites it at the interval specified by `targetIntervalSeconds`. You can
    /// enable
    /// both `SEQUENTIAL` and `LATEST`. Default: `SEQUENTIAL`.
    storage: ?[]const ThumbnailConfigurationStorage,

    /// The targeted thumbnail-generation interval in seconds. This is configurable
    /// (and required)
    /// only if `recordingMode` is `INTERVAL`. Default: 60.
    ///
    /// **Important:** For the `BASIC` channel type,
    /// or the `STANDARD` channel type with multitrack input,
    /// setting a value for `targetIntervalSeconds` does not guarantee that
    /// thumbnails are
    /// generated at the specified interval. For thumbnails to be generated at the
    /// `targetIntervalSeconds` interval, the `IDR/Keyframe` value for the
    /// input video must be less than the `targetIntervalSeconds` value. See [
    /// Amazon IVS Streaming
    /// Configuration](https://docs.aws.amazon.com/ivs/latest/userguide/streaming-config.html) for information on setting `IDR/Keyframe` to the
    /// recommended value in video-encoder settings.
    target_interval_seconds: ?i64,

    pub const json_field_names = .{
        .recording_mode = "recordingMode",
        .resolution = "resolution",
        .storage = "storage",
        .target_interval_seconds = "targetIntervalSeconds",
    };
};
