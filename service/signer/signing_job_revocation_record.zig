/// Revocation information for a signing job.
pub const SigningJobRevocationRecord = struct {
    /// A caller-supplied reason for revocation.
    reason: ?[]const u8,

    /// The time of revocation.
    revoked_at: ?i64,

    /// The identity of the revoker.
    revoked_by: ?[]const u8,

    pub const json_field_names = .{
        .reason = "reason",
        .revoked_at = "revokedAt",
        .revoked_by = "revokedBy",
    };
};
