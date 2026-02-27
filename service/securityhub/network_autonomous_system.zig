/// Contains information about the Autonomous System (AS) of the network
/// endpoints involved in an Amazon GuardDuty Extended Threat Detection attack
/// sequence. GuardDuty generates an attack
/// sequence finding when multiple events align to a potentially suspicious
/// activity. To receive GuardDuty attack sequence findings in Security Hub, you
/// must have GuardDuty enabled. For more information, see [GuardDuty Extended
/// Threat Detection
/// ](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty-extended-threat-detection.html) in the *Amazon GuardDuty User Guide*.
pub const NetworkAutonomousSystem = struct {
    /// The name associated with the AS.
    name: ?[]const u8,

    /// The unique number that identifies the AS.
    number: ?i32,

    pub const json_field_names = .{
        .name = "Name",
        .number = "Number",
    };
};
