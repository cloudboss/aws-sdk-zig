/// Contains OpenID Connect (OIDC) parameters for use with Microsoft Intune. For
/// more information about using Connector for SCEP for Microsoft Intune, see
/// [Using Connector for SCEP for Microsoft
/// Intune](https://docs.aws.amazon.com/privateca/latest/userguide/scep-connector.htmlconnector-for-scep-intune.html).
pub const OpenIdConfiguration = struct {
    /// The audience value to copy into your Microsoft Entra app registration's
    /// OIDC.
    audience: ?[]const u8,

    /// The issuer value to copy into your Microsoft Entra app registration's OIDC.
    issuer: ?[]const u8,

    /// The subject value to copy into your Microsoft Entra app registration's OIDC.
    subject: ?[]const u8,

    pub const json_field_names = .{
        .audience = "Audience",
        .issuer = "Issuer",
        .subject = "Subject",
    };
};
