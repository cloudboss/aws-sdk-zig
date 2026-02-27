const SignInOrigin = @import("sign_in_origin.zig").SignInOrigin;

/// A structure that describes the sign-in options for an application portal.
pub const SignInOptions = struct {
    /// The URL that accepts authentication requests for an application. This is a
    /// required parameter if the `Origin` parameter is `APPLICATION`.
    application_url: ?[]const u8,

    /// This determines how IAM Identity Center navigates the user to the target
    /// application. It can be one of the following values:
    ///
    /// * `APPLICATION`: IAM Identity Center redirects the customer to the
    ///   configured `ApplicationUrl`.
    /// * `IDENTITY_CENTER`: IAM Identity Center uses SAML identity-provider
    ///   initiated authentication to sign the customer directly into a SAML-based
    ///   application.
    origin: SignInOrigin,

    pub const json_field_names = .{
        .application_url = "ApplicationUrl",
        .origin = "Origin",
    };
};
