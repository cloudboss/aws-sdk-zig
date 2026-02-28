const Indicator = @import("indicator.zig").Indicator;
const SignalType = @import("signal_type.zig").SignalType;

/// Contains information about the signals involved in the attack sequence.
pub const Signal = struct {
    /// Information about the IDs of the threat actors involved in the signal.
    actor_ids: ?[]const []const u8,

    /// The number of times this signal was observed.
    count: i32,

    /// The timestamp when the first finding or activity related to this signal was
    /// observed.
    created_at: i64,

    /// The description of the signal.
    description: ?[]const u8,

    /// Information about the endpoint IDs associated with this signal.
    endpoint_ids: ?[]const []const u8,

    /// The timestamp when the first finding or activity related to this signal was
    /// observed.
    first_seen_at: i64,

    /// The timestamp when the last finding or activity related to this signal was
    /// observed.
    last_seen_at: i64,

    /// The name of the signal. For example, when signal type is `FINDING`,
    /// the signal name is the name of the finding.
    name: []const u8,

    /// Information about the unique identifiers of the resources involved in the
    /// signal.
    resource_uids: ?[]const []const u8,

    /// The severity associated with the signal. For more information about
    /// severity, see
    /// [Findings severity
    /// levels](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_findings-severity.html)
    /// in the *Amazon GuardDuty User Guide*.
    severity: ?f64,

    /// Contains information about the indicators associated with the signals.
    signal_indicators: ?[]const Indicator,

    /// The type of the signal used to identify an attack sequence.
    ///
    /// Signals can be GuardDuty findings or activities observed in data sources
    /// that GuardDuty monitors. For
    /// more information, see
    /// [Foundational data
    /// sources](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_data-sources.html) in the
    /// *Amazon GuardDuty User Guide*.
    ///
    /// A signal type can be one of the valid values listed in this API. Here are
    /// the related descriptions:
    ///
    /// * `FINDING` - Individually generated GuardDuty finding.
    ///
    /// * `CLOUD_TRAIL` - Activity observed from CloudTrail logs
    ///
    /// * `S3_DATA_EVENTS` - Activity observed from CloudTrail data events for S3.
    ///   Activities associated
    /// with this type will show up only when
    /// you have enabled GuardDuty S3 Protection feature in your account. For more
    /// information about S3 Protection and
    /// steps to enable it, see [S3
    /// Protection](https://docs.aws.amazon.com/guardduty/latest/ug/s3-protection.html) in the
    /// *Amazon GuardDuty User Guide*.
    @"type": SignalType,

    /// The unique identifier of the signal.
    uid: []const u8,

    /// The timestamp when this signal was last observed.
    updated_at: i64,

    pub const json_field_names = .{
        .actor_ids = "ActorIds",
        .count = "Count",
        .created_at = "CreatedAt",
        .description = "Description",
        .endpoint_ids = "EndpointIds",
        .first_seen_at = "FirstSeenAt",
        .last_seen_at = "LastSeenAt",
        .name = "Name",
        .resource_uids = "ResourceUids",
        .severity = "Severity",
        .signal_indicators = "SignalIndicators",
        .@"type" = "Type",
        .uid = "Uid",
        .updated_at = "UpdatedAt",
    };
};
