const CodecMetadata = @import("codec_metadata.zig").CodecMetadata;
const ColorPrimaries = @import("color_primaries.zig").ColorPrimaries;
const AspectRatio = @import("aspect_ratio.zig").AspectRatio;
const FrameRate = @import("frame_rate.zig").FrameRate;
const HdrMetadata = @import("hdr_metadata.zig").HdrMetadata;
const MatrixCoefficients = @import("matrix_coefficients.zig").MatrixCoefficients;
const TransferCharacteristics = @import("transfer_characteristics.zig").TransferCharacteristics;

/// Details about the media file's video track.
pub const VideoProperties = struct {
    /// The number of bits used per color component such as 8, 10, or 12 bits.
    /// Standard range (SDR) video typically uses 8-bit, while 10-bit is common for
    /// high dynamic range (HDR).
    bit_depth: ?i32 = null,

    /// The bit rate of the video track, in bits per second.
    bit_rate: ?i64 = null,

    /// Codec-specific parameters parsed from the video essence headers. This
    /// information provides detailed technical specifications about how the video
    /// was encoded, including profile settings, resolution details, and color space
    /// information that can help you understand the source video characteristics
    /// and make informed encoding decisions. These fields are returned for H.264
    /// (AVC), H.265 (HEVC), and MPEG-2 video, and might not be returned for other
    /// codecs. For MPEG-TS and MPEG-PS inputs, color information (color primaries,
    /// transfer characteristics, and matrix coefficients) appears in these fields
    /// rather than in the top-level videoProperties.
    codec_metadata: ?CodecMetadata = null,

    /// The color space primaries of the video track, defining the red, green, and
    /// blue color coordinates used for the video. This information helps ensure
    /// accurate color reproduction during playback and transcoding.
    color_primaries: ?ColorPrimaries = null,

    /// An aspect ratio expressed as a fraction with numerator and denominator
    /// values, reduced to lowest terms. Used for the sample (pixel) aspect ratio
    /// and the display aspect ratio of a video track. For example, a 720x576
    /// anamorphic track has a sample aspect ratio of 64 / 45 and a display aspect
    /// ratio of 16 / 9. A video track can declare an aspect ratio in two
    /// independent places, and MediaConvert reports each one where it was found
    /// rather than choosing between them. The ratio declared by the container
    /// appears on the video track itself, and the ratio declared by the video
    /// essence appears under codecMetadata. When a file declares an aspect ratio in
    /// only one of the two places, the other is null; when it declares both and
    /// they disagree, you can compare them and decide which to use.
    display_aspect_ratio: ?AspectRatio = null,

    /// The frame rate of the video or audio track, expressed as a fraction with
    /// numerator and denominator values.
    frame_rate: ?FrameRate = null,

    /// HDR (High Dynamic Range) metadata extracted from the container, including
    /// mastering display color volume and content light level information. This
    /// metadata is present in HDR10 and similar HDR content.
    hdr_metadata: ?HdrMetadata = null,

    /// The height of the video track, in pixels.
    height: ?i32 = null,

    /// The color space matrix coefficients of the video track, defining how RGB
    /// color values are converted to and from YUV color space. This affects color
    /// accuracy during encoding and decoding processes.
    matrix_coefficients: ?MatrixCoefficients = null,

    /// The clockwise rotation angle of the video track, in degrees, as derived from
    /// container-level metadata (e.g. the MP4 tkhd transformation matrix or the
    /// Matroska ProjectionPoseRoll element). Common values are 90, 180, and 270.
    /// This field is null when no rotation metadata is present or when the rotation
    /// is 0 degrees. For MP4, non-standard transformation matrices also yield null.
    rotation: ?i32 = null,

    /// An aspect ratio expressed as a fraction with numerator and denominator
    /// values, reduced to lowest terms. Used for the sample (pixel) aspect ratio
    /// and the display aspect ratio of a video track. For example, a 720x576
    /// anamorphic track has a sample aspect ratio of 64 / 45 and a display aspect
    /// ratio of 16 / 9. A video track can declare an aspect ratio in two
    /// independent places, and MediaConvert reports each one where it was found
    /// rather than choosing between them. The ratio declared by the container
    /// appears on the video track itself, and the ratio declared by the video
    /// essence appears under codecMetadata. When a file declares an aspect ratio in
    /// only one of the two places, the other is null; when it declares both and
    /// they disagree, you can compare them and decide which to use.
    sample_aspect_ratio: ?AspectRatio = null,

    /// The color space transfer characteristics of the video track, defining the
    /// relationship between linear light values and the encoded signal values. This
    /// affects brightness and contrast reproduction.
    transfer_characteristics: ?TransferCharacteristics = null,

    /// The width of the video track, in pixels.
    width: ?i32 = null,

    pub const json_field_names = .{
        .bit_depth = "BitDepth",
        .bit_rate = "BitRate",
        .codec_metadata = "CodecMetadata",
        .color_primaries = "ColorPrimaries",
        .display_aspect_ratio = "DisplayAspectRatio",
        .frame_rate = "FrameRate",
        .hdr_metadata = "HdrMetadata",
        .height = "Height",
        .matrix_coefficients = "MatrixCoefficients",
        .rotation = "Rotation",
        .sample_aspect_ratio = "SampleAspectRatio",
        .transfer_characteristics = "TransferCharacteristics",
        .width = "Width",
    };
};
