const EncryptionContractConfiguration = @import("encryption_contract_configuration.zig").EncryptionContractConfiguration;

/// If your output group type is CMAF, use these settings when doing DRM
/// encryption with a SPEKE-compliant key provider. If your output group type is
/// HLS, DASH, or Microsoft Smooth, use the SpekeKeyProvider settings instead.
pub const SpekeKeyProviderCmaf = struct {
    /// If you want your key provider to encrypt the content keys that it provides
    /// to MediaConvert, set up a certificate with a master key using AWS
    /// Certificate Manager. Specify the certificate's Amazon Resource Name (ARN)
    /// here.
    certificate_arn: ?[]const u8 = null,

    /// Specify the DRM system IDs that you want signaled in the DASH manifest that
    /// MediaConvert creates as part of this CMAF package. The DASH manifest can
    /// currently signal up to three system IDs. For more information, see
    /// https://dashif.org/identifiers/content_protection/.
    dash_signaled_system_ids: ?[]const []const u8 = null,

    /// Specify the SPEKE version, either v1.0 or v2.0, that MediaConvert uses when
    /// encrypting your output. For more information, see:
    /// https://docs.aws.amazon.com/speke/latest/documentation/speke-api-specification.html To use SPEKE v1.0: Leave blank. To use SPEKE v2.0: Specify a SPEKE v2.0 video preset and a SPEKE v2.0 audio preset.
    encryption_contract_configuration: ?EncryptionContractConfiguration = null,

    /// Specify up to 3 DRM system IDs that you want signaled in the HLS manifest
    /// that MediaConvert creates as part of this CMAF package. For more
    /// information, see https://dashif.org/identifiers/content_protection/.
    hls_signaled_system_ids: ?[]const []const u8 = null,

    /// Specify the resource ID that your SPEKE-compliant key provider uses to
    /// identify this content.
    resource_id: ?[]const u8 = null,

    /// Specify the URL to the key server that your SPEKE-compliant DRM key provider
    /// uses to provide keys for encrypting your content.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .dash_signaled_system_ids = "DashSignaledSystemIds",
        .encryption_contract_configuration = "EncryptionContractConfiguration",
        .hls_signaled_system_ids = "HlsSignaledSystemIds",
        .resource_id = "ResourceId",
        .url = "Url",
    };
};
