const aws = @import("aws");

const LogEvent = @import("log_event.zig").LogEvent;
const PatternToken = @import("pattern_token.zig").PatternToken;
const State = @import("state.zig").State;

/// This structure represents one anomaly that has been found by a logs anomaly
/// detector.
///
/// For more information about patterns and anomalies, see
/// [CreateLogAnomalyDetector](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateLogAnomalyDetector.html).
pub const Anomaly = struct {
    /// Specifies whether this anomaly is still ongoing.
    active: bool,

    /// The ARN of the anomaly detector that identified this anomaly.
    anomaly_detector_arn: []const u8,

    /// The unique ID that CloudWatch Logs assigned to this anomaly.
    anomaly_id: []const u8,

    /// A human-readable description of the anomaly. This description is generated
    /// by CloudWatch Logs.
    description: []const u8,

    /// The date and time when the anomaly detector first saw this anomaly. It is
    /// specified as
    /// epoch time, which is the number of seconds since `January 1, 1970, 00:00:00
    /// UTC`.
    first_seen: i64 = 0,

    /// A map showing times when the anomaly detector ran, and the number of
    /// occurrences of this
    /// anomaly that were detected at each of those runs. The times are specified in
    /// epoch time, which
    /// is the number of seconds since `January 1, 1970, 00:00:00 UTC`.
    histogram: []const aws.map.MapEntry(i64),

    /// If this anomaly is suppressed, this field is `true` if the suppression is
    /// because the pattern is suppressed. If `false`, then only this particular
    /// anomaly is
    /// suppressed.
    is_pattern_level_suppression: ?bool = null,

    /// The date and time when the anomaly detector most recently saw this anomaly.
    /// It is
    /// specified as epoch time, which is the number of seconds since `January 1,
    /// 1970, 00:00:00
    /// UTC`.
    last_seen: i64 = 0,

    /// An array of ARNS of the log groups that contained log events considered to
    /// be part of this
    /// anomaly.
    log_group_arn_list: []const []const u8,

    /// An array of sample log event messages that are considered to be part of this
    /// anomaly.
    log_samples: []const LogEvent,

    /// The ID of the pattern used to help identify this anomaly.
    pattern_id: []const u8,

    /// The pattern used to help identify this anomaly, in regular expression
    /// format.
    pattern_regex: ?[]const u8 = null,

    /// The pattern used to help identify this anomaly, in string format.
    pattern_string: []const u8,

    /// An array of structures where each structure contains information about one
    /// token that
    /// makes up the pattern.
    pattern_tokens: []const PatternToken,

    /// The priority level of this anomaly, as determined by CloudWatch Logs.
    /// Priority is
    /// computed based on log severity labels such as `FATAL` and `ERROR` and
    /// the amount of deviation from the baseline. Possible values are `HIGH`,
    /// `MEDIUM`, and `LOW`.
    priority: ?[]const u8 = null,

    /// Indicates the current state of this anomaly. If it is still being treated as
    /// an anomaly,
    /// the value is `Active`. If you have suppressed this anomaly by using the
    /// [UpdateAnomaly](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_UpdateAnomaly.html) operation, the value is `Suppressed`. If this behavior is
    /// now considered to be normal, the value is `Baseline`.
    state: State,

    /// Indicates whether this anomaly is currently suppressed. To suppress an
    /// anomaly, use
    /// [UpdateAnomaly](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_UpdateAnomaly.html).
    suppressed: ?bool = null,

    /// If the anomaly is suppressed, this indicates when it was suppressed.
    suppressed_date: i64 = 0,

    /// If the anomaly is suppressed, this indicates when the suppression will end.
    /// If this value
    /// is `0`, the anomaly was suppressed with no expiration, with the
    /// `INFINITE` value.
    suppressed_until: i64 = 0,

    pub const json_field_names = .{
        .active = "active",
        .anomaly_detector_arn = "anomalyDetectorArn",
        .anomaly_id = "anomalyId",
        .description = "description",
        .first_seen = "firstSeen",
        .histogram = "histogram",
        .is_pattern_level_suppression = "isPatternLevelSuppression",
        .last_seen = "lastSeen",
        .log_group_arn_list = "logGroupArnList",
        .log_samples = "logSamples",
        .pattern_id = "patternId",
        .pattern_regex = "patternRegex",
        .pattern_string = "patternString",
        .pattern_tokens = "patternTokens",
        .priority = "priority",
        .state = "state",
        .suppressed = "suppressed",
        .suppressed_date = "suppressedDate",
        .suppressed_until = "suppressedUntil",
    };
};
