const ActorSessionMfaStatus = @import("actor_session_mfa_status.zig").ActorSessionMfaStatus;

/// Contains information about the authenticated session used by the threat
/// actor identified in an Amazon GuardDuty Extended Threat Detection attack
/// sequence. GuardDuty generates an attack
/// sequence finding when multiple events align to a potentially suspicious
/// activity. To receive GuardDuty attack sequence findings in Security Hub, you
/// must have GuardDuty enabled. For more information, see [GuardDuty Extended
/// Threat Detection
/// ](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty-extended-threat-detection.html) in the *Amazon GuardDuty User Guide*.
pub const ActorSession = struct {
    /// The timestamp for when the session was created.
    ///
    /// In CloudTrail, you can find this value as
    /// `userIdentity.sessionContext.attributes.creationDate`.
    created_time: ?i64 = null,

    /// The issuer of the session.
    ///
    /// In CloudTrail, you can find this value as
    /// `userIdentity.sessionContext.sessionIssuer.arn`.
    issuer: ?[]const u8 = null,

    /// Indicates whether multi-factor authentication (MFA) was used for
    /// authentication during the session.
    ///
    /// In CloudTrail, you can find this value as
    /// `userIdentity.sessionContext.attributes.mfaAuthenticated`.
    mfa_status: ?ActorSessionMfaStatus = null,

    /// Unique identifier of the session.
    uid: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .issuer = "Issuer",
        .mfa_status = "MfaStatus",
        .uid = "Uid",
    };
};
