const ImageFormat = @import("image_format.zig").ImageFormat;

/// The image format of a AWS Signer platform or profile.
pub const SigningImageFormat = struct {
    /// The default format of a signing image.
    default_format: ImageFormat,

    /// The supported formats of a signing image.
    supported_formats: []const ImageFormat,

    pub const json_field_names = .{
        .default_format = "defaultFormat",
        .supported_formats = "supportedFormats",
    };
};
