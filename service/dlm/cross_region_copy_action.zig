const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const CrossRegionCopyRetainRule = @import("cross_region_copy_retain_rule.zig").CrossRegionCopyRetainRule;

/// **[Event-based policies only]** Specifies a cross-Region copy action for
/// event-based policies.
///
/// To specify a cross-Region copy rule for snapshot and AMI policies, use
/// [CrossRegionCopyRule](https://docs.aws.amazon.com/dlm/latest/APIReference/API_CrossRegionCopyRule.html).
pub const CrossRegionCopyAction = struct {
    /// The encryption settings for the copied snapshot.
    encryption_configuration: EncryptionConfiguration,

    retain_rule: ?CrossRegionCopyRetainRule = null,

    /// The target Region.
    target: []const u8,

    pub const json_field_names = .{
        .encryption_configuration = "EncryptionConfiguration",
        .retain_rule = "RetainRule",
        .target = "Target",
    };
};
