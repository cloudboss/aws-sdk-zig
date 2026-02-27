const IdentifiedType = @import("identified_type.zig").IdentifiedType;

/// The analysis result for Network Firewall's stateless rule group analyzer.
/// Every time you call CreateRuleGroup, UpdateRuleGroup, or DescribeRuleGroup
/// on a stateless rule group, Network Firewall analyzes the stateless rule
/// groups in your account and identifies the rules that might adversely effect
/// your firewall's functionality. For example, if Network Firewall detects a
/// rule that's routing traffic asymmetrically, which impacts the service's
/// ability to properly process traffic, the service includes the rule in a list
/// of analysis results.
///
/// The `AnalysisResult` data type is not related to traffic analysis reports
/// you generate using StartAnalysisReport. For information on traffic analysis
/// report results, see AnalysisTypeReportResult.
pub const AnalysisResult = struct {
    /// Provides analysis details for the identified rule.
    analysis_detail: ?[]const u8,

    /// The priority number of the stateless rules identified in the analysis.
    identified_rule_ids: ?[]const []const u8,

    /// The types of rule configurations that Network Firewall analyzes your rule
    /// groups for. Network Firewall analyzes stateless rule groups for the
    /// following types of rule configurations:
    ///
    /// * `STATELESS_RULE_FORWARDING_ASYMMETRICALLY`
    ///
    /// Cause: One or more stateless rules with the action `pass` or `forward` are
    /// forwarding traffic asymmetrically. Specifically, the rule's set of source IP
    /// addresses or their associated port numbers, don't match the set of
    /// destination IP addresses or their associated port numbers.
    ///
    /// To mitigate: Make sure that there's an existing return path. For example, if
    /// the rule allows traffic from source 10.1.0.0/24 to destination 20.1.0.0/24,
    /// you should allow return traffic from source 20.1.0.0/24 to destination
    /// 10.1.0.0/24.
    ///
    /// * `STATELESS_RULE_CONTAINS_TCP_FLAGS`
    ///
    /// Cause: At least one stateless rule with the action `pass` or`forward`
    /// contains TCP flags that are inconsistent in the forward and return
    /// directions.
    ///
    /// To mitigate: Prevent asymmetric routing issues caused by TCP flags by
    /// following these actions:
    ///
    /// * Remove unnecessary TCP flag inspections from the rules.
    ///
    /// * If you need to inspect TCP flags, check that the rules correctly account
    ///   for changes in TCP flags throughout the TCP connection cycle, for example
    ///   `SYN` and `ACK` flags used in a 3-way TCP handshake.
    identified_type: ?IdentifiedType,

    pub const json_field_names = .{
        .analysis_detail = "AnalysisDetail",
        .identified_rule_ids = "IdentifiedRuleIds",
        .identified_type = "IdentifiedType",
    };
};
