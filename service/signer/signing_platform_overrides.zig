const SigningConfigurationOverrides = @import("signing_configuration_overrides.zig").SigningConfigurationOverrides;
const ImageFormat = @import("image_format.zig").ImageFormat;

/// Any overrides that are applied to the signing configuration of a signing
/// platform.
pub const SigningPlatformOverrides = struct {
    /// A signing configuration that overrides the default encryption or hash
    /// algorithm of a
    /// signing job.
    signing_configuration: ?SigningConfigurationOverrides = null,

    /// A signed image is a JSON object. When overriding the default signing
    /// platform
    /// configuration, a customer can select either of two signing formats,
    /// `JSONEmbedded` or `JSONDetached`. (A third format value,
    /// `JSON`, is reserved for future use.) With `JSONEmbedded`, the
    /// signing image has the payload embedded in it. With `JSONDetached`, the
    /// payload is not be embedded in the signing image.
    signing_image_format: ?ImageFormat = null,

    pub const json_field_names = .{
        .signing_configuration = "signingConfiguration",
        .signing_image_format = "signingImageFormat",
    };
};
