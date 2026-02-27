const FragmentSelector = @import("fragment_selector.zig").FragmentSelector;
const RecordingStreamConfiguration = @import("recording_stream_configuration.zig").RecordingStreamConfiguration;

/// A structure that contains the runtime settings for recording a Kinesis video
/// stream.
pub const KinesisVideoStreamRecordingSourceRuntimeConfiguration = struct {
    /// Describes the timestamp range and timestamp origin of a range of fragments
    /// in the Kinesis video stream.
    fragment_selector: FragmentSelector,

    /// The stream or streams to be recorded.
    streams: []const RecordingStreamConfiguration,

    pub const json_field_names = .{
        .fragment_selector = "FragmentSelector",
        .streams = "Streams",
    };
};
