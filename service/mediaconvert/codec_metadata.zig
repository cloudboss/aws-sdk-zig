const FrameRate = @import("frame_rate.zig").FrameRate;
const ColorPrimaries = @import("color_primaries.zig").ColorPrimaries;
const ContentLightLevel = @import("content_light_level.zig").ContentLightLevel;
const AspectRatio = @import("aspect_ratio.zig").AspectRatio;
const DolbyVisionMetadata = @import("dolby_vision_metadata.zig").DolbyVisionMetadata;
const Hdr10PlusPresence = @import("hdr_10_plus_presence.zig").Hdr10PlusPresence;
const MatrixCoefficients = @import("matrix_coefficients.zig").MatrixCoefficients;
const TransferCharacteristics = @import("transfer_characteristics.zig").TransferCharacteristics;

/// Codec-specific parameters parsed from the video essence headers. This
/// information provides detailed technical specifications about how the video
/// was encoded, including profile settings, resolution details, and color space
/// information that can help you understand the source video characteristics
/// and make informed encoding decisions. These fields are returned for H.264
/// (AVC), H.265 (HEVC), and MPEG-2 video, and might not be returned for other
/// codecs. For MPEG-TS and MPEG-PS inputs, color information (color primaries,
/// transfer characteristics, and matrix coefficients) appears in these fields
/// rather than in the top-level videoProperties.
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

    /// Content light level information (CTA-861.3). Describes the light level
    /// characteristics of the content.
    content_light_level: ?ContentLightLevel = null,

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

    /// Dolby Vision characteristics of the video track: the profile and level, and
    /// whether the RPU (dynamic metadata), base layer, and enhancement layer are
    /// present. Use this to distinguish Dolby Vision content from standard HEVC and
    /// to choose your encoding or passthrough settings. Omitted when the content is
    /// not Dolby Vision.
    dolby_vision: ?DolbyVisionMetadata = null,

    /// The field order of interlaced video, which indicates whether the top or
    /// bottom field is displayed first. Use this to select the correct
    /// deinterlacing behavior. One of "TopFieldFirst" or "BottomFieldFirst". This
    /// field is present only for interlaced video; it is omitted for progressive
    /// video and when the field order is not indicated by the source.
    field_order: ?[]const u8 = null,

    /// Indicates that HDR10+ (SMPTE ST 2094-40) dynamic metadata was detected in
    /// the HEVC bitstream. Present only when detected.
    hdr_10_plus_presence: ?Hdr10PlusPresence = null,

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

    /// The clockwise rotation angle of the video, in degrees, as specified in the
    /// codec bitstream via a Display Orientation SEI message (payload type 47 for
    /// both H.264 and H.265). This field is null when the video essence does not
    /// contain a Display Orientation SEI message or when the rotation is 0 degrees.
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
        .content_light_level = "ContentLightLevel",
        .display_aspect_ratio = "DisplayAspectRatio",
        .dolby_vision = "DolbyVision",
        .field_order = "FieldOrder",
        .hdr_10_plus_presence = "Hdr10PlusPresence",
        .height = "Height",
        .level = "Level",
        .matrix_coefficients = "MatrixCoefficients",
        .profile = "Profile",
        .rotation = "Rotation",
        .sample_aspect_ratio = "SampleAspectRatio",
        .scan_type = "ScanType",
        .transfer_characteristics = "TransferCharacteristics",
        .width = "Width",
    };
};
