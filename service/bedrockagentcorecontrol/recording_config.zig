const S3Location = @import("s3_location.zig").S3Location;

/// The recording configuration for a browser. This structure defines how
/// browser sessions are recorded.
pub const RecordingConfig = struct {
    /// Indicates whether recording is enabled for the browser. When set to true,
    /// browser sessions are recorded.
    enabled: bool = false,

    /// The Amazon S3 location where browser recordings are stored. This location
    /// contains the recorded browser sessions.
    s_3_location: ?S3Location = null,

    pub const json_field_names = .{
        .enabled = "enabled",
        .s_3_location = "s3Location",
    };
};
