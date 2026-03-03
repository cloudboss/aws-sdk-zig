const IndicatorType = @import("indicator_type.zig").IndicatorType;

/// Contains information about the indicators that include a set of
/// signals observed in an attack sequence.
pub const Indicator = struct {
    /// Specific indicator keys observed in the attack sequence. For description of
    /// the valid values for key,
    /// see [Attack sequence finding
    /// details](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_findings-summary.html#guardduty-extended-threat-detection-attack-sequence-finding-details) in the *Amazon GuardDuty User Guide*.
    key: IndicatorType,

    /// Title describing the indicator.
    title: ?[]const u8 = null,

    /// Values associated with each indicator key. For example, if the indicator key
    /// is
    /// `SUSPICIOUS_NETWORK`, then the value will be the name of the network. If
    /// the indicator key is `ATTACK_TACTIC`, then the value will be one of the
    /// MITRE tactics.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .title = "Title",
        .values = "Values",
    };
};
