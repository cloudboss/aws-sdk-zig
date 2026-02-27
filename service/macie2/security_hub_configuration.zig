/// Specifies configuration settings that determine which findings are published
/// to Security Hub automatically. For information about how Macie publishes
/// findings to Security Hub, see [Evaluating findings with Security
/// Hub](https://docs.aws.amazon.com/macie/latest/user/securityhub-integration.html) in the *Amazon Macie User Guide*.
pub const SecurityHubConfiguration = struct {
    /// Specifies whether to publish sensitive data findings to Security Hub. If you
    /// set this value to true, Amazon Macie automatically publishes all sensitive
    /// data findings that weren't suppressed by a findings filter. The default
    /// value is false.
    publish_classification_findings: bool,

    /// Specifies whether to publish policy findings to Security Hub. If you set
    /// this value to true, Amazon Macie automatically publishes all new and updated
    /// policy findings that weren't suppressed by a findings filter. The default
    /// value is true.
    publish_policy_findings: bool,

    pub const json_field_names = .{
        .publish_classification_findings = "publishClassificationFindings",
        .publish_policy_findings = "publishPolicyFindings",
    };
};
