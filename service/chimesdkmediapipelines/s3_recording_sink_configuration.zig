const RecordingFileFormat = @import("recording_file_format.zig").RecordingFileFormat;

/// The structure that holds the settings for transmitting media to the Amazon
/// S3 bucket. These values are used as defaults if
/// `S3RecordingSinkRuntimeConfiguration` is not specified.
pub const S3RecordingSinkConfiguration = struct {
    /// The default URI of the Amazon S3 bucket used as the recording sink.
    destination: ?[]const u8,

    /// The default file format for the media files sent to the Amazon S3 bucket.
    recording_file_format: ?RecordingFileFormat,

    pub const json_field_names = .{
        .destination = "Destination",
        .recording_file_format = "RecordingFileFormat",
    };
};
