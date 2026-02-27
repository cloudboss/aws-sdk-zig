const MediaUriType = @import("media_uri_type.zig").MediaUriType;

/// The configuration details that consist of the credentials required
/// (`MediaUriSecretArn` and `MediaUriType`) to access the media files that are
/// streamed to the camera.
pub const MediaSourceConfig = struct {
    /// The Amazon Web Services Secrets Manager ARN for the username and password of
    /// the camera, or a local media file location.
    media_uri_secret_arn: []const u8,

    /// The Uniform Resource Identifier (URI) type. The `FILE_URI` value can be used
    /// to stream
    /// local media files.
    ///
    /// Preview only supports the `RTSP_URI` media source URI format .
    media_uri_type: MediaUriType,

    pub const json_field_names = .{
        .media_uri_secret_arn = "MediaUriSecretArn",
        .media_uri_type = "MediaUriType",
    };
};
