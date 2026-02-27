const DestinationConfiguration = @import("destination_configuration.zig").DestinationConfiguration;
const EncodingName = @import("encoding_name.zig").EncodingName;
const EncodingParameters = @import("encoding_parameters.zig").EncodingParameters;

/// The media stream that is associated with the output, and the parameters for
/// that association.
pub const MediaStreamOutputConfiguration = struct {
    /// The transport parameters that are associated with each outbound media
    /// stream.
    destination_configurations: ?[]const DestinationConfiguration,

    /// The format that was used to encode the data. For ancillary data streams, set
    /// the encoding name to smpte291. For audio streams, set the encoding name to
    /// pcm. For video, 2110 streams, set the encoding name to raw. For video, JPEG
    /// XS streams, set the encoding name to jxsv.
    encoding_name: EncodingName,

    /// A collection of parameters that determine how MediaConnect will convert the
    /// content. These fields only apply to outputs on flows that have a CDI source.
    encoding_parameters: ?EncodingParameters,

    /// The name of the media stream.
    media_stream_name: []const u8,

    pub const json_field_names = .{
        .destination_configurations = "DestinationConfigurations",
        .encoding_name = "EncodingName",
        .encoding_parameters = "EncodingParameters",
        .media_stream_name = "MediaStreamName",
    };
};
