const FrameRate = @import("frame_rate.zig").FrameRate;
const ColorPrimaries = @import("color_primaries.zig").ColorPrimaries;
const MatrixCoefficients = @import("matrix_coefficients.zig").MatrixCoefficients;
const TransferCharacteristics = @import("transfer_characteristics.zig").TransferCharacteristics;

/// Codec-specific parameters parsed from the video essence headers. This
/// information provides detailed technical specifications about how the video
/// was encoded, including profile settings, resolution details, and color space
/// information that can help you understand the source video characteristics
/// and make informed encoding decisions.
pub const CodecMetadata = struct {
    /// The number of bits used per color component in the video essence such as 8,
    /// 10, or 12 bits. Standard range (SDR) video typically uses 8-bit, while
    /// 10-bit is common for high dynamic range (HDR).
    bit_depth: ?i32 = null,

    /// The chroma subsampling format used in the video encoding, such as "4:2:0" or
    /// "4:4:4". This describes how color information is sampled relative to
    /// brightness information. Different subsampling ratios affect video quality
    /// and file size, with "4:4:4" providing the highest color fidelity and "4:2:0"
    /// being most common for standard video.
    chroma_subsampling: ?[]const u8 = null,

    /// The frame rate of the video or audio track, expressed as a fraction with
    /// numerator and denominator values.
    coded_frame_rate: ?FrameRate = null,

    /// The color space primaries of the video track, defining the red, green, and
    /// blue color coordinates used for the video. This information helps ensure
    /// accurate color reproduction during playback and transcoding.
    color_primaries: ?ColorPrimaries = null,

    /// The height in pixels as coded by the codec. This represents the actual
    /// encoded video height as specified in the video stream headers.
    height: ?i32 = null,

    /// The codec level or tier that specifies the maximum processing requirements
    /// and capabilities. Levels define constraints such as maximum bit rate, frame
    /// rate, and resolution.
    level: ?[]const u8 = null,

    /// The color space matrix coefficients of the video track, defining how RGB
    /// color values are converted to and from YUV color space. This affects color
    /// accuracy during encoding and decoding processes.
    matrix_coefficients: ?MatrixCoefficients = null,

    /// The codec profile used to encode the video. Profiles define specific feature
    /// sets and capabilities within a codec standard. For example, H.264 profiles
    /// include Baseline, Main, and High, each supporting different encoding
    /// features and complexity levels.
    profile: ?[]const u8 = null,

    /// The scanning method specified in the video essence, indicating whether the
    /// video uses progressive or interlaced scanning.
    scan_type: ?[]const u8 = null,

    /// The color space transfer characteristics of the video track, defining the
    /// relationship between linear light values and the encoded signal values. This
    /// affects brightness and contrast reproduction.
    transfer_characteristics: ?TransferCharacteristics = null,

    /// The width in pixels as coded by the codec. This represents the actual
    /// encoded video width as specified in the video stream headers.
    width: ?i32 = null,

    pub const json_field_names = .{
        .bit_depth = "BitDepth",
        .chroma_subsampling = "ChromaSubsampling",
        .coded_frame_rate = "CodedFrameRate",
        .color_primaries = "ColorPrimaries",
        .height = "Height",
        .level = "Level",
        .matrix_coefficients = "MatrixCoefficients",
        .profile = "Profile",
        .scan_type = "ScanType",
        .transfer_characteristics = "TransferCharacteristics",
        .width = "Width",
    };
};
