const EncryptionContractConfiguration = @import("encryption_contract_configuration.zig").EncryptionContractConfiguration;

/// If your output group type is HLS, DASH, or Microsoft Smooth, use these
/// settings when doing DRM encryption with a SPEKE-compliant key provider. If
/// your output group type is CMAF, use the SpekeKeyProviderCmaf settings
/// instead.
pub const SpekeKeyProvider = struct {
    /// If you want your key provider to encrypt the content keys that it provides
    /// to MediaConvert, set up a certificate with a master key using AWS
    /// Certificate Manager. Specify the certificate's Amazon Resource Name (ARN)
    /// here.
    certificate_arn: ?[]const u8,

    /// Specify the SPEKE version, either v1.0 or v2.0, that MediaConvert uses when
    /// encrypting your output. For more information, see:
    /// https://docs.aws.amazon.com/speke/latest/documentation/speke-api-specification.html To use SPEKE v1.0: Leave blank. To use SPEKE v2.0: Specify a SPEKE v2.0 video preset and a SPEKE v2.0 audio preset.
    encryption_contract_configuration: ?EncryptionContractConfiguration,

    /// Specify the resource ID that your SPEKE-compliant key provider uses to
    /// identify this content.
    resource_id: ?[]const u8,

    /// Relates to SPEKE implementation. DRM system identifiers. DASH output groups
    /// support a max of two system ids. HLS output groups support a max of 3 system
    /// ids. Other group types support one system id. See
    /// https://dashif.org/identifiers/content_protection/ for more details.
    system_ids: ?[]const []const u8,

    /// Specify the URL to the key server that your SPEKE-compliant DRM key provider
    /// uses to provide keys for encrypting your content.
    url: ?[]const u8,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .encryption_contract_configuration = "EncryptionContractConfiguration",
        .resource_id = "ResourceId",
        .system_ids = "SystemIds",
        .url = "Url",
    };
};
