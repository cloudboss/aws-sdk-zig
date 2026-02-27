const IssueDetectionConfiguration = @import("issue_detection_configuration.zig").IssueDetectionConfiguration;
const KeywordMatchConfiguration = @import("keyword_match_configuration.zig").KeywordMatchConfiguration;
const SentimentConfiguration = @import("sentiment_configuration.zig").SentimentConfiguration;
const RealTimeAlertRuleType = @import("real_time_alert_rule_type.zig").RealTimeAlertRuleType;

/// Specifies the words or phrases that trigger an alert.
pub const RealTimeAlertRule = struct {
    /// Specifies the issue detection settings for a real-time alert rule.
    issue_detection_configuration: ?IssueDetectionConfiguration,

    /// Specifies the settings for matching the keywords in a real-time alert rule.
    keyword_match_configuration: ?KeywordMatchConfiguration,

    /// Specifies the settings for predicting sentiment in a real-time alert rule.
    sentiment_configuration: ?SentimentConfiguration,

    /// The type of alert rule.
    @"type": RealTimeAlertRuleType,

    pub const json_field_names = .{
        .issue_detection_configuration = "IssueDetectionConfiguration",
        .keyword_match_configuration = "KeywordMatchConfiguration",
        .sentiment_configuration = "SentimentConfiguration",
        .@"type" = "Type",
    };
};
