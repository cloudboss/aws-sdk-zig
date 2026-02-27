const CodecMetadata = @import("codec_metadata.zig").CodecMetadata;
const ColorPrimaries = @import("color_primaries.zig").ColorPrimaries;
const FrameRate = @import("frame_rate.zig").FrameRate;
const MatrixCoefficients = @import("matrix_coefficients.zig").MatrixCoefficients;
const TransferCharacteristics = @import("transfer_characteristics.zig").TransferCharacteristics;

/// Details about the media file's video track.
pub const VideoProperties = struct {
    /// The number of bits used per color component such as 8, 10, or 12 bits.
    /// Standard range (SDR) video typically uses 8-bit, while 10-bit is common for
    /// high dynamic range (HDR).
    bit_depth: ?i32,

    /// The bit rate of the video track, in bits per second.
    bit_rate: ?i64,

    /// Codec-specific parameters parsed from the video essence headers. This
    /// information provides detailed technical specifications about how the video
    /// was encoded, including profile settings, resolution details, and color space
    /// information that can help you understand the source video characteristics
    /// and make informed encoding decisions.
    codec_metadata: ?CodecMetadata,

    /// The color space primaries of the video track, defining the red, green, and
    /// blue color coordinates used for the video. This information helps ensure
    /// accurate color reproduction during playback and transcoding.
    color_primaries: ?ColorPrimaries,

    /// The frame rate of the video or audio track, expressed as a fraction with
    /// numerator and denominator values.
    frame_rate: ?FrameRate,

    /// The height of the video track, in pixels.
    height: ?i32,

    /// The color space matrix coefficients of the video track, defining how RGB
    /// color values are converted to and from YUV color space. This affects color
    /// accuracy during encoding and decoding processes.
    matrix_coefficients: ?MatrixCoefficients,

    /// The color space transfer characteristics of the video track, defining the
    /// relationship between linear light values and the encoded signal values. This
    /// affects brightness and contrast reproduction.
    transfer_characteristics: ?TransferCharacteristics,

    /// The width of the video track, in pixels.
    width: ?i32,

    pub const json_field_names = .{
        .bit_depth = "BitDepth",
        .bit_rate = "BitRate",
        .codec_metadata = "CodecMetadata",
        .color_primaries = "ColorPrimaries",
        .frame_rate = "FrameRate",
        .height = "Height",
        .matrix_coefficients = "MatrixCoefficients",
        .transfer_characteristics = "TransferCharacteristics",
        .width = "Width",
    };
};
