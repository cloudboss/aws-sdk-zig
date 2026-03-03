const Tag = @import("tag.zig").Tag;

/// **[Custom snapshot and AMI policies only]** Specifies optional parameters
/// for snapshot and AMI policies. The
/// set of valid parameters depends on the combination of policy type and target
/// resource
/// type.
///
/// If you choose to exclude boot volumes and you specify tags that consequently
/// exclude
/// all of the additional data volumes attached to an instance, then Amazon Data
/// Lifecycle Manager will not create
/// any snapshots for the affected instance, and it will emit a
/// `SnapshotsCreateFailed`
/// Amazon CloudWatch metric. For more information, see [Monitor your policies
/// using Amazon
/// CloudWatch](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/monitor-dlm-cw-metrics.html).
pub const Parameters = struct {
    /// **[Custom snapshot policies that target instances only]** Indicates whether
    /// to exclude the root volume from multi-volume
    /// snapshot sets. The default is `false`. If you specify `true`,
    /// then the root volumes attached to targeted instances will be excluded from
    /// the multi-volume
    /// snapshot sets created by the policy.
    exclude_boot_volume: ?bool = null,

    /// **[Custom snapshot policies that target instances only]** The tags used to
    /// identify data (non-root) volumes to exclude from
    /// multi-volume snapshot sets.
    ///
    /// If you create a snapshot lifecycle policy that targets instances and you
    /// specify tags for
    /// this parameter, then data volumes with the specified tags that are attached
    /// to targeted
    /// instances will be excluded from the multi-volume snapshot sets created by
    /// the policy.
    exclude_data_volume_tags: ?[]const Tag = null,

    /// **[Custom AMI policies only]** Indicates whether targeted instances are
    /// rebooted when the lifecycle policy
    /// runs. `true` indicates that targeted instances are not rebooted when the
    /// policy
    /// runs. `false` indicates that target instances are rebooted when the policy
    /// runs.
    /// The default is `true` (instances are not rebooted).
    no_reboot: ?bool = null,

    pub const json_field_names = .{
        .exclude_boot_volume = "ExcludeBootVolume",
        .exclude_data_volume_tags = "ExcludeDataVolumeTags",
        .no_reboot = "NoReboot",
    };
};
