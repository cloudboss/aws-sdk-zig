const AuthorizedTokenIssuer = @import("authorized_token_issuer.zig").AuthorizedTokenIssuer;

/// A structure that defines configuration settings for an application that
/// supports the JWT Bearer Token Authorization Grant. The `AuthorizedAudience`
/// field is the aud claim. For more information, see [RFC
/// 7523](https://datatracker.ietf.org/doc/html/rfc7523).
pub const JwtBearerGrant = struct {
    /// A list of allowed token issuers trusted by the Identity Center instances for
    /// this application.
    ///
    /// `AuthorizedTokenIssuers` is required when the grant type is
    /// `JwtBearerGrant`.
    authorized_token_issuers: ?[]const AuthorizedTokenIssuer = null,

    pub const json_field_names = .{
        .authorized_token_issuers = "AuthorizedTokenIssuers",
    };
};
