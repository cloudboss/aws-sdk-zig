const KeywordInputType = @import("keyword_input_type.zig").KeywordInputType;

/// A keyword that relates to the control data source.
///
/// For manual evidence, this keyword indicates if the manual evidence is a file
/// or
/// text.
///
/// For automated evidence, this keyword identifies a specific CloudTrail event,
/// Config rule, Security Hub control, or Amazon Web Services API name.
///
/// To learn more about the supported keywords that you can use when mapping a
/// control data
/// source, see the following pages in the *Audit Manager User
/// Guide*:
///
/// * [Config rules supported by Audit
///   Manager](https://docs.aws.amazon.com/audit-manager/latest/userguide/control-data-sources-config.html)
///
/// * [Security Hub controls supported by Audit
///   Manager](https://docs.aws.amazon.com/audit-manager/latest/userguide/control-data-sources-ash.html)
///
/// * [API calls
/// supported by Audit
/// Manager](https://docs.aws.amazon.com/audit-manager/latest/userguide/control-data-sources-api.html)
///
/// * [CloudTrail event names supported by Audit
///   Manager](https://docs.aws.amazon.com/audit-manager/latest/userguide/control-data-sources-cloudtrail.html)
pub const SourceKeyword = struct {
    /// The input method for the keyword.
    ///
    /// * `SELECT_FROM_LIST` is used when mapping a data source for automated
    /// evidence.
    ///
    /// * When `keywordInputType` is `SELECT_FROM_LIST`, a
    /// keyword must be selected to collect automated evidence. For example, this
    /// keyword can be a CloudTrail event name, a rule name for Config, a Security
    /// Hub control, or the name of an Amazon Web Services API call.
    ///
    /// * `UPLOAD_FILE` and `INPUT_TEXT` are only used when mapping a
    /// data source for manual evidence.
    ///
    /// * When `keywordInputType` is `UPLOAD_FILE`, a file must
    /// be uploaded as manual evidence.
    ///
    /// * When `keywordInputType` is `INPUT_TEXT`, text must be
    /// entered as manual evidence.
    keyword_input_type: ?KeywordInputType,

    /// The value of the keyword that's used when mapping a control data source. For
    /// example,
    /// this can be a CloudTrail event name, a rule name for Config, a
    /// Security Hub control, or the name of an Amazon Web Services API call.
    ///
    /// If you’re mapping a data source to a rule in Config, the
    /// `keywordValue` that you specify depends on the type of rule:
    ///
    /// * For [managed
    ///   rules](https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config_use-managed-rules.html), you can use the rule identifier as the
    /// `keywordValue`. You can find the rule identifier from the [list of Config
    /// managed
    /// rules](https://docs.aws.amazon.com/config/latest/developerguide/managed-rules-by-aws-config.html). For some
    /// rules, the rule identifier is different from the rule name. For example, the
    /// rule
    /// name `restricted-ssh` has the following rule identifier:
    /// `INCOMING_SSH_DISABLED`. Make sure to use the rule identifier, not the
    /// rule name.
    ///
    /// Keyword example for managed rules:
    ///
    /// * Managed rule name:
    ///   [s3-bucket-acl-prohibited](https://docs.aws.amazon.com/config/latest/developerguide/s3-bucket-acl-prohibited.html)
    ///
    /// `keywordValue`: `S3_BUCKET_ACL_PROHIBITED`
    ///
    /// * For [custom
    ///   rules](https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config_develop-rules.html), you form the `keywordValue`
    /// by adding the `Custom_` prefix to the rule name. This prefix distinguishes
    /// the custom rule from a managed rule.
    ///
    /// Keyword example for custom rules:
    ///
    /// * Custom rule name: my-custom-config-rule
    ///
    /// `keywordValue`: `Custom_my-custom-config-rule`
    ///
    /// * For [service-linked
    ///   rules](https://docs.aws.amazon.com/config/latest/developerguide/service-linked-awsconfig-rules.html), you form the
    /// `keywordValue` by adding the `Custom_` prefix to the rule
    /// name. In addition, you remove the suffix ID that appears at the end of the
    /// rule name.
    ///
    /// Keyword examples for service-linked rules:
    ///
    /// * Service-linked rule name:
    /// CustomRuleForAccount-conformance-pack-szsm1uv0w
    ///
    /// `keywordValue`:
    /// `Custom_CustomRuleForAccount-conformance-pack`
    ///
    /// * Service-linked rule name:
    /// OrgConfigRule-s3-bucket-versioning-enabled-dbgzf8ba
    ///
    /// `keywordValue`:
    /// `Custom_OrgConfigRule-s3-bucket-versioning-enabled`
    ///
    /// The `keywordValue` is case sensitive. If you enter a value incorrectly,
    /// Audit Manager might not recognize the data source mapping. As a result, you
    /// might not
    /// successfully collect evidence from that data source as intended.
    ///
    /// Keep in mind the following requirements, depending on the data source type
    /// that
    /// you're using.
    ///
    /// * For Config:
    ///
    /// * For managed rules, make sure that the `keywordValue` is the rule
    ///   identifier in
    /// `ALL_CAPS_WITH_UNDERSCORES`. For example,
    /// `CLOUDWATCH_LOG_GROUP_ENCRYPTED`. For accuracy, we recommend
    /// that you reference the list of [supported Config managed
    /// rules](https://docs.aws.amazon.com/audit-manager/latest/userguide/control-data-sources-config.html).
    ///
    /// * For custom rules, make sure that the `keywordValue` has the `Custom_`
    /// prefix followed by the custom rule name. The format of the custom rule name
    /// itself may vary. For accuracy, we recommend that you visit the [Config
    /// console](https://console.aws.amazon.com/config/) to
    /// verify your custom rule name.
    ///
    /// * For Security Hub: The format varies for Security Hub control names.
    /// For accuracy, we recommend that you reference the list of [supported
    /// Security Hub
    /// controls](https://docs.aws.amazon.com/audit-manager/latest/userguide/control-data-sources-ash.html).
    ///
    /// * For Amazon Web Services API calls: Make sure that the `keywordValue`
    /// is written as `serviceprefix_ActionName`. For example,
    /// `iam_ListGroups`. For accuracy, we recommend that you reference the
    /// list of [supported
    /// API
    /// calls](https://docs.aws.amazon.com/audit-manager/latest/userguide/control-data-sources-api.html).
    ///
    /// * For CloudTrail: Make sure that the `keywordValue` is written
    /// as `serviceprefix_ActionName`. For example,
    /// `cloudtrail_StartLogging`. For accuracy, we recommend that you
    /// review the Amazon Web Services service prefix and action names in the
    /// [Service Authorization
    /// Reference](https://docs.aws.amazon.com/service-authorization/latest/reference/reference_policies_actions-resources-contextkeys.html).
    keyword_value: ?[]const u8,

    pub const json_field_names = .{
        .keyword_input_type = "keywordInputType",
        .keyword_value = "keywordValue",
    };
};
