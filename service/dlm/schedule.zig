const ArchiveRule = @import("archive_rule.zig").ArchiveRule;
const CreateRule = @import("create_rule.zig").CreateRule;
const CrossRegionCopyRule = @import("cross_region_copy_rule.zig").CrossRegionCopyRule;
const DeprecateRule = @import("deprecate_rule.zig").DeprecateRule;
const FastRestoreRule = @import("fast_restore_rule.zig").FastRestoreRule;
const RetainRule = @import("retain_rule.zig").RetainRule;
const ShareRule = @import("share_rule.zig").ShareRule;
const Tag = @import("tag.zig").Tag;

/// **[Custom snapshot and AMI policies only]** Specifies a schedule for a
/// snapshot or AMI lifecycle policy.
pub const Schedule = struct {
    /// **[Custom snapshot policies that target volumes only]** The snapshot
    /// archiving rule for the schedule. When you specify an archiving
    /// rule, snapshots are automatically moved from the standard tier to the
    /// archive tier once the schedule's
    /// retention threshold is met. Snapshots are then retained in the archive tier
    /// for the archive retention
    /// period that you specify.
    ///
    /// For more information about using snapshot archiving, see [Considerations for
    /// snapshot lifecycle
    /// policies](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/snapshot-ami-policy.html#dlm-archive).
    archive_rule: ?ArchiveRule = null,

    /// Copy all user-defined tags on a source volume to snapshots of the volume
    /// created by
    /// this policy.
    copy_tags: ?bool = null,

    /// The creation rule.
    create_rule: ?CreateRule = null,

    /// Specifies a rule for copying snapshots or AMIs across Regions.
    ///
    /// You can't specify cross-Region copy rules for policies that create snapshots
    /// on an
    /// Outpost or in a Local Zone. If the policy creates snapshots in a Region,
    /// then snapshots
    /// can be copied to up to three Regions or Outposts.
    cross_region_copy_rules: ?[]const CrossRegionCopyRule = null,

    /// **[Custom AMI policies only]** The AMI deprecation rule for the schedule.
    deprecate_rule: ?DeprecateRule = null,

    /// **[Custom snapshot policies only]** The rule for enabling fast snapshot
    /// restore.
    fast_restore_rule: ?FastRestoreRule = null,

    /// The name of the schedule.
    name: ?[]const u8 = null,

    /// The retention rule for snapshots or AMIs created by the policy.
    retain_rule: ?RetainRule = null,

    /// **[Custom snapshot policies only]** The rule for sharing snapshots with
    /// other Amazon Web Services accounts.
    share_rules: ?[]const ShareRule = null,

    /// The tags to apply to policy-created resources. These user-defined tags are
    /// in addition
    /// to the Amazon Web Services-added lifecycle tags.
    tags_to_add: ?[]const Tag = null,

    /// **[AMI policies and snapshot policies that target instances only]**
    /// A collection of key/value pairs with values determined dynamically when the
    /// policy is
    /// executed. Keys may be any valid Amazon EC2 tag key. Values must be in one of
    /// the two
    /// following formats: `$(instance-id)` or `$(timestamp)`. Variable
    /// tags are only valid for EBS Snapshot Management – Instance policies.
    variable_tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .archive_rule = "ArchiveRule",
        .copy_tags = "CopyTags",
        .create_rule = "CreateRule",
        .cross_region_copy_rules = "CrossRegionCopyRules",
        .deprecate_rule = "DeprecateRule",
        .fast_restore_rule = "FastRestoreRule",
        .name = "Name",
        .retain_rule = "RetainRule",
        .share_rules = "ShareRules",
        .tags_to_add = "TagsToAdd",
        .variable_tags = "VariableTags",
    };
};
