const UserVerificationType = @import("user_verification_type.zig").UserVerificationType;

/// Settings for authentication (MFA) with passkey, or webauthN, biometric and
/// security-key devices in a user pool. Configures the following:
///
/// * Configuration for requiring user-verification support in passkeys.
///
/// * The user pool relying-party ID. This is the domain, typically your user
///   pool
/// domain, that user's passkey providers should trust as a receiver of passkey
/// authentication.
///
/// * The providers that you want to allow as origins for passkey
/// authentication.
pub const WebAuthnConfigurationType = struct {
    /// Sets or displays the authentication domain, typically your user pool domain,
    /// that
    /// passkey providers must use as a relying party (RP) in their configuration.
    ///
    /// Under the following conditions, the passkey relying party ID must be the
    /// fully-qualified domain name of your custom domain:
    ///
    /// * The user pool is configured for passkey authentication.
    ///
    /// * The user pool has a custom domain, whether or not it also has a prefix
    /// domain.
    ///
    /// * Your application performs authentication with managed login or the classic
    /// hosted UI.
    relying_party_id: ?[]const u8 = null,

    /// When `required`, users can only register and sign in users with passkeys
    /// that are capable of [user
    /// verification](https://www.w3.org/TR/webauthn-2/#enum-userVerificationRequirement). When `preferred`, your user pool doesn't
    /// require the use of authenticators with user verification but encourages it.
    user_verification: ?UserVerificationType = null,

    pub const json_field_names = .{
        .relying_party_id = "RelyingPartyId",
        .user_verification = "UserVerification",
    };
};
