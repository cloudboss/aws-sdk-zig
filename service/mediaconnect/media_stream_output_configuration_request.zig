const DestinationConfigurationRequest = @import("destination_configuration_request.zig").DestinationConfigurationRequest;
const EncodingName = @import("encoding_name.zig").EncodingName;
const EncodingParametersRequest = @import("encoding_parameters_request.zig").EncodingParametersRequest;

/// The media stream that you want to associate with the output, and the
/// parameters for that association.
pub const MediaStreamOutputConfigurationRequest = struct {
    /// The media streams that you want to associate with the output.
    destination_configurations: ?[]const DestinationConfigurationRequest = null,

    /// The format that will be used to encode the data. For ancillary data streams,
    /// set the encoding name to smpte291. For audio streams, set the encoding name
    /// to pcm. For video, 2110 streams, set the encoding name to raw. For video,
    /// JPEG XS streams, set the encoding name to jxsv.
    encoding_name: EncodingName,

    /// A collection of parameters that determine how MediaConnect will convert the
    /// content. These fields only apply to outputs on flows that have a CDI source.
    encoding_parameters: ?EncodingParametersRequest = null,

    /// The name of the media stream that is associated with the output.
    media_stream_name: []const u8,

    pub const json_field_names = .{
        .destination_configurations = "DestinationConfigurations",
        .encoding_name = "EncodingName",
        .encoding_parameters = "EncodingParameters",
        .media_stream_name = "MediaStreamName",
    };
};
