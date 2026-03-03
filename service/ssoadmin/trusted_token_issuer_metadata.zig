const TrustedTokenIssuerType = @import("trusted_token_issuer_type.zig").TrustedTokenIssuerType;

/// A structure that describes a trusted token issuer.
pub const TrustedTokenIssuerMetadata = struct {
    /// The name of the trusted token issuer configuration in the instance of IAM
    /// Identity Center.
    name: ?[]const u8 = null,

    /// The ARN of the trusted token issuer configuration in the instance of IAM
    /// Identity Center.
    trusted_token_issuer_arn: ?[]const u8 = null,

    /// The type of trusted token issuer.
    trusted_token_issuer_type: ?TrustedTokenIssuerType = null,

    pub const json_field_names = .{
        .name = "Name",
        .trusted_token_issuer_arn = "TrustedTokenIssuerArn",
        .trusted_token_issuer_type = "TrustedTokenIssuerType",
    };
};
