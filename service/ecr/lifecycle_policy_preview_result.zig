const LifecyclePolicyRuleAction = @import("lifecycle_policy_rule_action.zig").LifecyclePolicyRuleAction;
const LifecyclePolicyStorageClass = @import("lifecycle_policy_storage_class.zig").LifecyclePolicyStorageClass;

/// The result of the lifecycle policy preview.
pub const LifecyclePolicyPreviewResult = struct {
    /// The type of action to be taken.
    action: ?LifecyclePolicyRuleAction = null,

    /// The priority of the applied rule.
    applied_rule_priority: ?i32 = null,

    /// The `sha256` digest of the image manifest.
    image_digest: ?[]const u8 = null,

    /// The date and time, expressed in standard JavaScript date format, at which
    /// the current
    /// image was pushed to the repository.
    image_pushed_at: ?i64 = null,

    /// The list of tags associated with this image.
    image_tags: ?[]const []const u8 = null,

    /// The storage class of the image.
    storage_class: ?LifecyclePolicyStorageClass = null,

    pub const json_field_names = .{
        .action = "action",
        .applied_rule_priority = "appliedRulePriority",
        .image_digest = "imageDigest",
        .image_pushed_at = "imagePushedAt",
        .image_tags = "imageTags",
        .storage_class = "storageClass",
    };
};
