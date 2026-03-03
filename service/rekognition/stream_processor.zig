const StreamProcessorStatus = @import("stream_processor_status.zig").StreamProcessorStatus;

/// An object that recognizes faces or labels in a streaming video. An Amazon
/// Rekognition stream processor is created by a call to CreateStreamProcessor.
/// The request
/// parameters for `CreateStreamProcessor` describe the Kinesis video stream
/// source for the streaming video, face recognition parameters, and where to
/// stream the analysis resullts.
pub const StreamProcessor = struct {
    /// Name of the Amazon Rekognition stream processor.
    name: ?[]const u8 = null,

    /// Current status of the Amazon Rekognition stream processor.
    status: ?StreamProcessorStatus = null,

    pub const json_field_names = .{
        .name = "Name",
        .status = "Status",
    };
};
