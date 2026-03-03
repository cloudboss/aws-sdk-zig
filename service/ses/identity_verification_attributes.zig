const VerificationStatus = @import("verification_status.zig").VerificationStatus;

/// Represents the verification attributes of a single identity.
pub const IdentityVerificationAttributes = struct {
    /// The verification status of the identity: "Pending", "Success", "Failed", or
    /// "TemporaryFailure".
    verification_status: VerificationStatus,

    /// The verification token for a domain identity. Null for email address
    /// identities.
    verification_token: ?[]const u8 = null,
};
