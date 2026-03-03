const EncodingName = @import("encoding_name.zig").EncodingName;
const InputConfigurationRequest = @import("input_configuration_request.zig").InputConfigurationRequest;

/// The media stream that you want to associate with the source, and the
/// parameters for that association.
pub const MediaStreamSourceConfigurationRequest = struct {
    /// The format that was used to encode the data. For ancillary data streams, set
    /// the encoding name to smpte291. For audio streams, set the encoding name to
    /// pcm. For video, 2110 streams, set the encoding name to raw. For video, JPEG
    /// XS streams, set the encoding name to jxsv.
    encoding_name: EncodingName,

    /// The media streams that you want to associate with the source.
    input_configurations: ?[]const InputConfigurationRequest = null,

    /// The name of the media stream.
    media_stream_name: []const u8,

    pub const json_field_names = .{
        .encoding_name = "EncodingName",
        .input_configurations = "InputConfigurations",
        .media_stream_name = "MediaStreamName",
    };
};
