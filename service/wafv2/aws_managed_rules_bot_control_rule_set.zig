const InspectionLevel = @import("inspection_level.zig").InspectionLevel;

/// Details for your use of the Bot Control managed rule group,
/// `AWSManagedRulesBotControlRuleSet`. This configuration is used in
/// `ManagedRuleGroupConfig`.
///
/// For additional information about this and the other intelligent threat
/// mitigation rule groups,
/// see [Intelligent threat mitigation in
/// WAF](https://docs.aws.amazon.com/waf/latest/developerguide/waf-managed-protections)
/// and [Amazon Web Services Managed Rules rule groups
/// list](https://docs.aws.amazon.com/waf/latest/developerguide/aws-managed-rule-groups-list)
/// in the *WAF Developer Guide*.
pub const AWSManagedRulesBotControlRuleSet = struct {
    /// Applies only to the targeted inspection level.
    ///
    /// Determines whether to use machine learning (ML) to
    /// analyze your web traffic for bot-related activity. Machine learning is
    /// required for the Bot Control rules `TGT_ML_CoordinatedActivityLow` and
    /// `TGT_ML_CoordinatedActivityMedium`, which
    /// inspect for anomalous behavior that might indicate distributed, coordinated
    /// bot activity.
    ///
    /// For more information about this choice, see the listing for these rules in
    /// the table at [Bot Control rules
    /// listing](https://docs.aws.amazon.com/waf/latest/developerguide/aws-managed-rule-groups-bot.html#aws-managed-rule-groups-bot-rules) in the
    /// *WAF Developer Guide*.
    ///
    /// Default: `TRUE`
    enable_machine_learning: bool = true,

    /// The inspection level to use for the Bot Control rule group. The common level
    /// is the least expensive. The
    /// targeted level includes all common level rules and adds rules with more
    /// advanced inspection criteria. For
    /// details, see [WAF Bot Control rule
    /// group](https://docs.aws.amazon.com/waf/latest/developerguide/aws-managed-rule-groups-bot.html)
    /// in the *WAF Developer Guide*.
    inspection_level: InspectionLevel,

    pub const json_field_names = .{
        .enable_machine_learning = "EnableMachineLearning",
        .inspection_level = "InspectionLevel",
    };
};
