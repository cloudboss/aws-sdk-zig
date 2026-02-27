const StreamFile = @import("stream_file.zig").StreamFile;

/// Information about a stream.
pub const StreamInfo = struct {
    /// The date when the stream was created.
    created_at: ?i64,

    /// The description of the stream.
    description: ?[]const u8,

    /// The files to stream.
    files: ?[]const StreamFile,

    /// The date when the stream was last updated.
    last_updated_at: ?i64,

    /// An IAM role IoT assumes to access your S3 files.
    role_arn: ?[]const u8,

    /// The stream ARN.
    stream_arn: ?[]const u8,

    /// The stream ID.
    stream_id: ?[]const u8,

    /// The stream version.
    stream_version: ?i32,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .files = "files",
        .last_updated_at = "lastUpdatedAt",
        .role_arn = "roleArn",
        .stream_arn = "streamArn",
        .stream_id = "streamId",
        .stream_version = "streamVersion",
    };
};
