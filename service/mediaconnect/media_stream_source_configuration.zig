const EncodingName = @import("encoding_name.zig").EncodingName;
const InputConfiguration = @import("input_configuration.zig").InputConfiguration;

/// The media stream that is associated with the source, and the parameters for
/// that association.
pub const MediaStreamSourceConfiguration = struct {
    /// The format that was used to encode the data. For ancillary data streams, set
    /// the encoding name to smpte291. For audio streams, set the encoding name to
    /// pcm. For video, 2110 streams, set the encoding name to raw. For video, JPEG
    /// XS streams, set the encoding name to jxsv.
    encoding_name: EncodingName,

    /// The media streams that you want to associate with the source.
    input_configurations: ?[]const InputConfiguration,

    /// A name that helps you distinguish one media stream from another.
    media_stream_name: []const u8,

    pub const json_field_names = .{
        .encoding_name = "EncodingName",
        .input_configurations = "InputConfigurations",
        .media_stream_name = "MediaStreamName",
    };
};
