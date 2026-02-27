const SecurityStyle = @import("security_style.zig").SecurityStyle;
const UpdateSnaplockConfiguration = @import("update_snaplock_configuration.zig").UpdateSnaplockConfiguration;
const TieringPolicy = @import("tiering_policy.zig").TieringPolicy;

/// Used to specify changes to the ONTAP configuration for the volume you are
/// updating.
pub const UpdateOntapVolumeConfiguration = struct {
    /// A boolean flag indicating whether tags for the volume should be copied to
    /// backups. This value defaults to
    /// false. If it's set to true, all tags for the volume are copied to all
    /// automatic and user-initiated backups
    /// where the user doesn't specify tags. If this value is true, and you specify
    /// one or more tags, only the
    /// specified tags are copied to backups. If you specify one or more tags when
    /// creating a user-initiated
    /// backup, no tags are copied from the volume, regardless of this value.
    copy_tags_to_backups: ?bool,

    /// Specifies the location in the SVM's namespace where the volume is mounted.
    /// The `JunctionPath` must have a leading forward slash, such as `/vol3`.
    junction_path: ?[]const u8,

    /// The security style for the volume, which can be `UNIX`,
    /// `NTFS`, or `MIXED`.
    security_style: ?SecurityStyle,

    /// The configured size of the volume, in bytes.
    size_in_bytes: ?i64,

    /// Specifies the size of the volume in megabytes.
    size_in_megabytes: ?i32,

    /// The configuration object for updating the SnapLock configuration of an FSx
    /// for ONTAP SnapLock volume.
    snaplock_configuration: ?UpdateSnaplockConfiguration,

    /// Specifies the snapshot policy for the volume. There are three built-in
    /// snapshot policies:
    ///
    /// * `default`: This is the default policy. A maximum of six hourly snapshots
    ///   taken five minutes past
    /// the hour. A maximum of two daily snapshots taken Monday through Saturday at
    /// 10 minutes after
    /// midnight. A maximum of two weekly snapshots taken every Sunday at 15 minutes
    /// after midnight.
    ///
    /// * `default-1weekly`: This policy is the same as the `default` policy except
    /// that it only retains one snapshot from the weekly schedule.
    ///
    /// * `none`: This policy does not take any snapshots. This policy can be
    ///   assigned to volumes to
    /// prevent automatic snapshots from being taken.
    ///
    /// You can also provide the name of a custom policy that you created with the
    /// ONTAP CLI or REST API.
    ///
    /// For more information, see [Snapshot
    /// policies](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/snapshots-ontap.html#snapshot-policies)
    /// in the *Amazon FSx for NetApp ONTAP User Guide*.
    snapshot_policy: ?[]const u8,

    /// Default is `false`. Set to true to enable the deduplication,
    /// compression, and compaction storage efficiency features on the volume.
    storage_efficiency_enabled: ?bool,

    /// Update the volume's data tiering policy.
    tiering_policy: ?TieringPolicy,

    pub const json_field_names = .{
        .copy_tags_to_backups = "CopyTagsToBackups",
        .junction_path = "JunctionPath",
        .security_style = "SecurityStyle",
        .size_in_bytes = "SizeInBytes",
        .size_in_megabytes = "SizeInMegabytes",
        .snaplock_configuration = "SnaplockConfiguration",
        .snapshot_policy = "SnapshotPolicy",
        .storage_efficiency_enabled = "StorageEfficiencyEnabled",
        .tiering_policy = "TieringPolicy",
    };
};
