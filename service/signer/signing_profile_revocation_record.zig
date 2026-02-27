/// Revocation information for a signing profile.
pub const SigningProfileRevocationRecord = struct {
    /// The time when revocation becomes effective.
    revocation_effective_from: ?i64,

    /// The time when the signing profile was revoked.
    revoked_at: ?i64,

    /// The identity of the revoker.
    revoked_by: ?[]const u8,

    pub const json_field_names = .{
        .revocation_effective_from = "revocationEffectiveFrom",
        .revoked_at = "revokedAt",
        .revoked_by = "revokedBy",
    };
};
