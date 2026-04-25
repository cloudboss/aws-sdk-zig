const AlarmMuteRuleStatus = @import("alarm_mute_rule_status.zig").AlarmMuteRuleStatus;

/// Summary information about an alarm mute rule, including its name, status,
/// and configuration details.
pub const AlarmMuteRuleSummary = struct {
    /// The Amazon Resource Name (ARN) of the alarm mute rule.
    alarm_mute_rule_arn: ?[]const u8 = null,

    /// The date and time when the mute rule expires and is no longer evaluated.
    /// This field is only present if an expiration date was configured.
    expire_date: ?i64 = null,

    /// The date and time when the mute rule was last updated.
    last_updated_timestamp: ?i64 = null,

    /// Indicates whether the mute rule is one-time or recurring. Valid values are
    /// `ONE_TIME` or `RECURRING`.
    mute_type: ?[]const u8 = null,

    /// The current status of the alarm mute rule. Valid values are `SCHEDULED`,
    /// `ACTIVE`, or `EXPIRED`.
    status: ?AlarmMuteRuleStatus = null,

    pub const json_field_names = .{
        .alarm_mute_rule_arn = "AlarmMuteRuleArn",
        .expire_date = "ExpireDate",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .mute_type = "MuteType",
        .status = "Status",
    };
};
