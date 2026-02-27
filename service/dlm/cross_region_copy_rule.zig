const CrossRegionCopyDeprecateRule = @import("cross_region_copy_deprecate_rule.zig").CrossRegionCopyDeprecateRule;
const CrossRegionCopyRetainRule = @import("cross_region_copy_retain_rule.zig").CrossRegionCopyRetainRule;

/// **[Custom snapshot and AMI policies only]** Specifies a cross-Region copy
/// rule for a snapshot and AMI policies.
///
/// To specify a cross-Region copy action for event-based polices, use
/// [CrossRegionCopyAction](https://docs.aws.amazon.com/dlm/latest/APIReference/API_CrossRegionCopyAction.html).
pub const CrossRegionCopyRule = struct {
    /// The Amazon Resource Name (ARN) of the KMS key to use for EBS encryption. If
    /// this
    /// parameter is not specified, the default KMS key for the account is used.
    cmk_arn: ?[]const u8,

    /// Indicates whether to copy all user-defined tags from the source snapshot or
    /// AMI to the
    /// cross-Region copy.
    copy_tags: ?bool,

    /// **[Custom AMI policies only]** The AMI deprecation rule for cross-Region AMI
    /// copies created by the rule.
    deprecate_rule: ?CrossRegionCopyDeprecateRule,

    /// To encrypt a copy of an unencrypted snapshot if encryption by default is not
    /// enabled,
    /// enable encryption using this parameter. Copies of encrypted snapshots are
    /// encrypted,
    /// even if this parameter is false or if encryption by default is not enabled.
    encrypted: bool,

    /// The retention rule that indicates how long the cross-Region snapshot or AMI
    /// copies are
    /// to be retained in the destination Region.
    retain_rule: ?CrossRegionCopyRetainRule,

    /// Use this parameter for snapshot policies only. For AMI policies, use
    /// **TargetRegion** instead.
    ///
    /// **[Custom snapshot policies only]** The target Region or the Amazon Resource
    /// Name (ARN) of the target Outpost for the
    /// snapshot copies.
    target: ?[]const u8,

    /// Use this parameter for AMI policies only. For snapshot policies, use
    /// **Target** instead. For snapshot policies
    /// created before the **Target** parameter
    /// was introduced, this parameter indicates the target Region for snapshot
    /// copies.
    ///
    /// **[Custom AMI policies only]** The target Region or the Amazon Resource Name
    /// (ARN) of the target Outpost for the
    /// snapshot copies.
    target_region: ?[]const u8,

    pub const json_field_names = .{
        .cmk_arn = "CmkArn",
        .copy_tags = "CopyTags",
        .deprecate_rule = "DeprecateRule",
        .encrypted = "Encrypted",
        .retain_rule = "RetainRule",
        .target = "Target",
        .target_region = "TargetRegion",
    };
};
