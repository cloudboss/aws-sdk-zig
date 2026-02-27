pub const RealTimeAlertRuleType = enum {
    keyword_match,
    sentiment,
    issue_detection,

    pub const json_field_names = .{
        .keyword_match = "KeywordMatch",
        .sentiment = "Sentiment",
        .issue_detection = "IssueDetection",
    };
};
