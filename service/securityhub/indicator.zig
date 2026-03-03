/// Contains information about the indicators observed in an Amazon GuardDuty
/// Extended Threat Detection attack sequence.
/// Indicators include a set of signals, which can be API activities or findings
/// that GuardDuty uses to detect an attack sequence finding. GuardDuty
/// generates an attack sequence finding when multiple signals align to a
/// potentially suspicious activity. To receive GuardDuty attack sequence
/// findings in Security Hub, you
/// must have GuardDuty and GuardDuty S3 Protection enabled. For more
/// information, see [GuardDuty Extended Threat Detection
/// ](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty-extended-threat-detection.html) in the *Amazon GuardDuty User Guide*.
pub const Indicator = struct {
    /// The name of the indicator that’s present in the attack sequence finding.
    key: ?[]const u8 = null,

    /// The title describing the indicator.
    title: ?[]const u8 = null,

    /// The type of indicator.
    @"type": ?[]const u8 = null,

    /// Values associated with each indicator key. For example, if the indicator key
    /// is
    /// `SUSPICIOUS_NETWORK`, then the value will be the name of the network. If
    /// the indicator key is `ATTACK_TACTIC`, then the value will be one of the
    /// MITRE tactics.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .title = "Title",
        .@"type" = "Type",
        .values = "Values",
    };
};
