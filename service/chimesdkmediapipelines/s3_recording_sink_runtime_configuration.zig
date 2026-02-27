const RecordingFileFormat = @import("recording_file_format.zig").RecordingFileFormat;

/// A structure that holds the settings for transmitting media files to the
/// Amazon S3 bucket. If specified, the settings in this structure override any
/// settings in `S3RecordingSinkConfiguration`.
pub const S3RecordingSinkRuntimeConfiguration = struct {
    /// The URI of the S3 bucket used as the sink.
    destination: []const u8,

    /// The file format for the media files sent to the Amazon S3 bucket.
    recording_file_format: RecordingFileFormat,

    pub const json_field_names = .{
        .destination = "Destination",
        .recording_file_format = "RecordingFileFormat",
    };
};
