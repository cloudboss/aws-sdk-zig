/// Specify whether your DRM encryption key is static or from a key provider
/// that follows the SPEKE standard. For more information about SPEKE, see
/// https://docs.aws.amazon.com/speke/latest/documentation/what-is-speke.html.
pub const CmafKeyProviderType = enum {
    speke,
    static_key,

    pub const json_field_names = .{
        .speke = "SPEKE",
        .static_key = "STATIC_KEY",
    };
};
