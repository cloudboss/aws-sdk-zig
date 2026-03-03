const UserAccount = @import("user_account.zig").UserAccount;

/// Contains information about the credentials used by the threat actor
/// identified in an Amazon GuardDuty Extended Threat Detection attack sequence.
/// GuardDuty generates an attack
/// sequence finding when multiple events align to a potentially suspicious
/// activity. To receive GuardDuty attack sequence findings in Security Hub, you
/// must have GuardDuty enabled. For more information, see [GuardDuty Extended
/// Threat Detection
/// ](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty-extended-threat-detection.html) in the *Amazon GuardDuty User Guide*.
pub const ActorUser = struct {
    /// The account of the threat actor.
    account: ?UserAccount = null,

    /// Unique identifier of the threat actor’s user credentials.
    credential_uid: ?[]const u8 = null,

    /// The name of the threat actor.
    name: ?[]const u8 = null,

    /// The type of user.
    @"type": ?[]const u8 = null,

    /// The unique identifier of the threat actor.
    uid: ?[]const u8 = null,

    pub const json_field_names = .{
        .account = "Account",
        .credential_uid = "CredentialUid",
        .name = "Name",
        .@"type" = "Type",
        .uid = "Uid",
    };
};
