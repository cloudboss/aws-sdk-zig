const Indicator = @import("indicator.zig").Indicator;

/// Contains information about the signals involved in an Amazon GuardDuty
/// Extended Threat Detection attack sequence. An attack sequence is a
/// type of threat detected by GuardDuty. GuardDuty generates an attack sequence
/// finding when multiple events, or
/// signals, align to a potentially suspicious activity. When GuardDuty and
/// Security Hub are integrated, GuardDuty
/// sends attack sequence findings to Security Hub.
///
/// A signal can be an API activity or a finding that GuardDuty uses to detect
/// an attack sequence finding.
pub const Signal = struct {
    /// The IDs of the threat actors involved in the signal.
    actor_ids: ?[]const []const u8 = null,

    /// The number of times this signal was observed.
    count: ?i32 = null,

    /// The timestamp when the first finding or activity related to this signal was
    /// observed.
    created_at: ?i64 = null,

    /// Information about the endpoint IDs associated with this signal.
    endpoint_ids: ?[]const []const u8 = null,

    /// The timestamp when the first finding or activity related to this signal was
    /// observed.
    first_seen_at: ?i64 = null,

    /// The identifier of the signal.
    id: ?[]const u8 = null,

    /// The timestamp when the last finding or activity related to this signal was
    /// observed.
    last_seen_at: ?i64 = null,

    /// The name of the GuardDuty signal. For example, when signal type is
    /// `FINDING`,
    /// the signal name is the name of the finding.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the product that generated the signal.
    product_arn: ?[]const u8 = null,

    /// The ARN or ID of the Amazon Web Services resource associated with the
    /// signal.
    resource_ids: ?[]const []const u8 = null,

    /// The severity associated with the signal. For more information about
    /// severity, see
    /// [Severity levels for GuardDuty
    /// findings](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_findings-severity.html)
    /// in the *Amazon GuardDuty User Guide*.
    severity: ?f64 = null,

    /// Contains information about the indicators associated with the signals in
    /// this attack sequence finding. The values for
    /// `SignalIndicators` are a subset of the values for
    /// [SequenceIndicators](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_Sequence.html), but the values for
    /// these fields don't always match 1:1.
    signal_indicators: ?[]const Indicator = null,

    /// The description of the GuardDuty finding.
    title: ?[]const u8 = null,

    /// The type of the signal used to identify an attack sequence.
    ///
    /// Signals can be GuardDuty findings or activities observed in data sources
    /// that GuardDuty monitors.
    /// For
    /// more information, see
    /// [GuardDuty foundational data
    /// sources](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_data-sources.html) in the
    /// *Amazon GuardDuty User Guide*.
    ///
    /// A signal type can be one of the following values. Here are the related
    /// descriptions:
    ///
    /// * `FINDING` - Individually generated GuardDuty finding.
    ///
    /// * `CLOUD_TRAIL` - Activity observed from CloudTrail logs
    ///
    /// * `S3_DATA_EVENTS` - Activity observed from CloudTrail data events for
    ///   Amazon Simple Storage Service (S3).
    /// Activities associated
    /// with this type will show up only when
    /// you have enabled GuardDuty S3 Protection feature in your account. For more
    /// information about
    /// S3 Protection and the
    /// steps to enable it, see [S3
    /// Protection](https://docs.aws.amazon.com/guardduty/latest/ug/s3-protection.html) in the
    /// *Amazon GuardDuty User Guide*.
    @"type": ?[]const u8 = null,

    /// The timestamp when this signal was last observed.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .actor_ids = "ActorIds",
        .count = "Count",
        .created_at = "CreatedAt",
        .endpoint_ids = "EndpointIds",
        .first_seen_at = "FirstSeenAt",
        .id = "Id",
        .last_seen_at = "LastSeenAt",
        .name = "Name",
        .product_arn = "ProductArn",
        .resource_ids = "ResourceIds",
        .severity = "Severity",
        .signal_indicators = "SignalIndicators",
        .title = "Title",
        .@"type" = "Type",
        .updated_at = "UpdatedAt",
    };
};
