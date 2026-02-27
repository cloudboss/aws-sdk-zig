const IdentityType = @import("identity_type.zig").IdentityType;
const VerificationStatus = @import("verification_status.zig").VerificationStatus;

/// Information about an email identity.
pub const IdentityInfo = struct {
    /// The address or domain of the identity.
    identity_name: ?[]const u8,

    /// The email identity type. Note: the `MANAGED_DOMAIN` type is not supported
    /// for email identity types.
    identity_type: ?IdentityType,

    /// Indicates whether or not you can send email from the identity.
    ///
    /// An *identity* is an email address or domain that you send email
    /// from. Before you can send email from an identity, you have to demostrate
    /// that you own
    /// the identity, and that you authorize Amazon SES to send email from that
    /// identity.
    sending_enabled: bool = false,

    /// The verification status of the identity. The status can be one of the
    /// following:
    ///
    /// * `PENDING` – The verification process was initiated, but Amazon SES
    /// hasn't yet been able to verify the identity.
    ///
    /// * `SUCCESS` – The verification process completed
    /// successfully.
    ///
    /// * `FAILED` – The verification process failed.
    ///
    /// * `TEMPORARY_FAILURE` – A temporary issue is preventing Amazon SES
    /// from determining the verification status of the identity.
    ///
    /// * `NOT_STARTED` – The verification process hasn't been
    /// initiated for the identity.
    verification_status: ?VerificationStatus,

    pub const json_field_names = .{
        .identity_name = "IdentityName",
        .identity_type = "IdentityType",
        .sending_enabled = "SendingEnabled",
        .verification_status = "VerificationStatus",
    };
};
