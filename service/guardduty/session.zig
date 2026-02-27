const MfaStatus = @import("mfa_status.zig").MfaStatus;

/// Contains information about the authenticated session.
pub const Session = struct {
    /// The timestamp for when the session was created.
    ///
    /// In Amazon Web Services CloudTrail, you can find this value as
    /// `userIdentity.sessionContext.attributes.creationDate`.
    created_time: ?i64,

    /// Identifier of the session issuer.
    ///
    /// In Amazon Web Services CloudTrail, you can find this value as
    /// `userIdentity.sessionContext.sessionIssuer.arn`.
    issuer: ?[]const u8,

    /// Indicates whether or not multi-factor authencation (MFA) was used during
    /// authentication.
    ///
    /// In Amazon Web Services CloudTrail, you can find this value as
    /// `userIdentity.sessionContext.attributes.mfaAuthenticated`.
    mfa_status: ?MfaStatus,

    /// The unique identifier of the session.
    uid: ?[]const u8,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .issuer = "Issuer",
        .mfa_status = "MfaStatus",
        .uid = "Uid",
    };
};
