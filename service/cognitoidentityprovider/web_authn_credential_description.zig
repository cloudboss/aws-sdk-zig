/// The details of a passkey, or webauthN, biometric or security-key
/// authentication factor
/// for a user.
pub const WebAuthnCredentialDescription = struct {
    /// The general category of the passkey authenticator. Can be a platform, or
    /// on-device
    /// authenticator like a built-in fingerprint scanner, or a cross-platform
    /// device that's not
    /// attached to the device like a Bluetooth security key.
    authenticator_attachment: ?[]const u8 = null,

    /// Information about the transport methods of the passkey credential, for
    /// example USB or
    /// Bluetooth Low Energy.
    authenticator_transports: []const []const u8,

    /// The date and time when the item was created. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    created_at: i64,

    /// The unique identifier of the passkey credential.
    credential_id: []const u8,

    /// An automatically-generated friendly name for the passkey credential.
    friendly_credential_name: []const u8,

    /// The relying-party ID of the provider for the passkey credential.
    relying_party_id: []const u8,

    pub const json_field_names = .{
        .authenticator_attachment = "AuthenticatorAttachment",
        .authenticator_transports = "AuthenticatorTransports",
        .created_at = "CreatedAt",
        .credential_id = "CredentialId",
        .friendly_credential_name = "FriendlyCredentialName",
        .relying_party_id = "RelyingPartyId",
    };
};
