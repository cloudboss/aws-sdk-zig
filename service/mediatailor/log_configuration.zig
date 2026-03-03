const AdsInteractionLog = @import("ads_interaction_log.zig").AdsInteractionLog;
const LoggingStrategy = @import("logging_strategy.zig").LoggingStrategy;
const ManifestServiceInteractionLog = @import("manifest_service_interaction_log.zig").ManifestServiceInteractionLog;

/// Defines where AWS Elemental MediaTailor sends logs for the playback
/// configuration.
pub const LogConfiguration = struct {
    /// Settings for customizing what events are included in logs for interactions
    /// with the ad decision server (ADS).
    ads_interaction_log: ?AdsInteractionLog = null,

    /// The method used for collecting logs from AWS Elemental MediaTailor.
    /// `LEGACY_CLOUDWATCH` indicates that MediaTailor is sending logs directly to
    /// Amazon CloudWatch Logs. `VENDED_LOGS` indicates that MediaTailor is sending
    /// logs to CloudWatch, which then vends the logs to your destination of choice.
    /// Supported destinations are CloudWatch Logs log group, Amazon S3 bucket, and
    /// Amazon Data Firehose stream.
    enabled_logging_strategies: []const LoggingStrategy,

    /// Settings for customizing what events are included in logs for interactions
    /// with the origin server.
    manifest_service_interaction_log: ?ManifestServiceInteractionLog = null,

    /// The percentage of session logs that MediaTailor sends to your configured log
    /// destination. For example, if your playback configuration has 1000 sessions
    /// and `percentEnabled` is set to `60`, MediaTailor sends logs for 600 of the
    /// sessions to CloudWatch Logs. MediaTailor decides at random which of the
    /// playback configuration sessions to send logs for. If you want to view logs
    /// for a specific session, you can use the [debug log
    /// mode](https://docs.aws.amazon.com/mediatailor/latest/ug/debug-log-mode.html).
    ///
    /// Valid values: `0` - `100`
    percent_enabled: i32 = 0,

    pub const json_field_names = .{
        .ads_interaction_log = "AdsInteractionLog",
        .enabled_logging_strategies = "EnabledLoggingStrategies",
        .manifest_service_interaction_log = "ManifestServiceInteractionLog",
        .percent_enabled = "PercentEnabled",
    };
};
