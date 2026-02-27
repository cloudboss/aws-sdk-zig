/// The frequency with which Amazon Macie publishes updates to policy findings
/// for an account. This includes publishing updates to Security Hub and Amazon
/// EventBridge (formerly Amazon CloudWatch Events). For more information, see
/// [Monitoring and processing
/// findings](https://docs.aws.amazon.com/macie/latest/user/findings-monitor.html) in the *Amazon Macie User Guide*. Valid values are:
pub const FindingPublishingFrequency = enum {
    fifteen_minutes,
    one_hour,
    six_hours,

    pub const json_field_names = .{
        .fifteen_minutes = "FIFTEEN_MINUTES",
        .one_hour = "ONE_HOUR",
        .six_hours = "SIX_HOURS",
    };
};
