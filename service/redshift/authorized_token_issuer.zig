/// The authorized token issuer for the Amazon Redshift IAM Identity Center
/// application.
pub const AuthorizedTokenIssuer = struct {
    /// The list of audiences for the authorized token issuer for integrating Amazon
    /// Redshift
    /// with IDC Identity Center.
    authorized_audiences_list: ?[]const []const u8,

    /// The ARN for the authorized token issuer for integrating Amazon Redshift with
    /// IDC Identity Center.
    trusted_token_issuer_arn: ?[]const u8,
};
