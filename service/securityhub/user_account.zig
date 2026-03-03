/// Provides Amazon Web Services account information of the user involved in an
/// Amazon GuardDuty Extended Threat Detection attack sequence. GuardDuty
/// generates an attack
/// sequence finding when multiple events align to a potentially suspicious
/// activity. To receive GuardDuty attack sequence findings in Security Hub, you
/// must have GuardDuty enabled. For more information, see [GuardDuty Extended
/// Threat Detection
/// ](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty-extended-threat-detection.html) in the *Amazon GuardDuty User Guide*.
pub const UserAccount = struct {
    /// The name of the user account involved in the attack sequence.
    name: ?[]const u8 = null,

    /// The unique identifier of the user account involved in the attack sequence.
    uid: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .uid = "Uid",
    };
};
