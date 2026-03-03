const CreateAggregateConfiguration = @import("create_aggregate_configuration.zig").CreateAggregateConfiguration;
const InputOntapVolumeType = @import("input_ontap_volume_type.zig").InputOntapVolumeType;
const SecurityStyle = @import("security_style.zig").SecurityStyle;
const CreateSnaplockConfiguration = @import("create_snaplock_configuration.zig").CreateSnaplockConfiguration;
const TieringPolicy = @import("tiering_policy.zig").TieringPolicy;
const VolumeStyle = @import("volume_style.zig").VolumeStyle;

/// Specifies the configuration of the ONTAP volume that you are creating.
pub const CreateOntapVolumeConfiguration = struct {
    /// Use to specify configuration options for a volume’s storage aggregate or
    /// aggregates.
    aggregate_configuration: ?CreateAggregateConfiguration = null,

    /// A boolean flag indicating whether tags for the volume should be copied to
    /// backups. This value defaults to
    /// false. If it's set to true, all tags for the volume are copied to all
    /// automatic and user-initiated backups
    /// where the user doesn't specify tags. If this value is true, and you specify
    /// one or more tags, only the
    /// specified tags are copied to backups. If you specify one or more tags when
    /// creating a user-initiated
    /// backup, no tags are copied from the volume, regardless of this value.
    copy_tags_to_backups: ?bool = null,

    /// Specifies the location in the SVM's namespace where the volume is mounted.
    /// This parameter is required. The `JunctionPath` must have a leading
    /// forward slash, such as `/vol3`.
    junction_path: ?[]const u8 = null,

    /// Specifies the type of volume you are creating. Valid values are the
    /// following:
    ///
    /// * `RW` specifies a read/write volume. `RW` is the default.
    ///
    /// * `DP` specifies a data-protection volume. A `DP` volume
    /// is read-only and can be used as the destination of a NetApp SnapMirror
    /// relationship.
    ///
    /// For more information, see [Volume
    /// types](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/managing-volumes.html#volume-types)
    /// in the Amazon FSx for NetApp ONTAP User Guide.
    ontap_volume_type: ?InputOntapVolumeType = null,

    /// Specifies the security style for the volume. If a volume's security style is
    /// not specified,
    /// it is automatically set to the root volume's security style. The security
    /// style determines the type of permissions
    /// that FSx for ONTAP uses to control data access. Specify one of the following
    /// values:
    ///
    /// * `UNIX` if the file system is managed by a UNIX
    /// administrator, the majority of users are NFS clients, and an application
    /// accessing the data uses a UNIX user as the service account.
    ///
    /// * `NTFS` if the file system is managed by a Windows
    /// administrator, the majority of users are SMB clients, and an application
    /// accessing the data uses a Windows user as the service account.
    ///
    /// * `MIXED` This is an advanced setting. For more information, see the topic
    /// [What the security styles and their effects
    /// are](https://docs.netapp.com/us-en/ontap/nfs-admin/security-styles-their-effects-concept.html)
    /// in the NetApp Documentation Center.
    ///
    /// For more information, see [Volume security
    /// style](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/managing-volumes.html#volume-security-style) in the
    /// FSx for ONTAP User Guide.
    security_style: ?SecurityStyle = null,

    /// Specifies the configured size of the volume, in bytes.
    size_in_bytes: ?i64 = null,

    /// Use `SizeInBytes` instead. Specifies the size of the volume, in megabytes
    /// (MB), that you are creating.
    size_in_megabytes: ?i32 = null,

    /// Specifies the SnapLock configuration for an FSx for ONTAP volume.
    snaplock_configuration: ?CreateSnaplockConfiguration = null,

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
    /// in the Amazon FSx for NetApp ONTAP User Guide.
    snapshot_policy: ?[]const u8 = null,

    /// Set to true to enable deduplication, compression, and compaction storage
    /// efficiency features on the volume, or set to false to disable them.
    ///
    /// `StorageEfficiencyEnabled` is required when creating a `RW` volume
    /// (`OntapVolumeType` set to `RW`).
    storage_efficiency_enabled: ?bool = null,

    /// Specifies the ONTAP SVM in which to create the volume.
    storage_virtual_machine_id: []const u8,

    tiering_policy: ?TieringPolicy = null,

    /// Use to specify the style of an ONTAP volume. FSx for ONTAP offers two styles
    /// of volumes that you can use for different purposes,
    /// FlexVol and FlexGroup volumes. For more information, see
    /// [Volume
    /// styles](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/managing-volumes.html#volume-styles) in the Amazon FSx for NetApp ONTAP User Guide.
    volume_style: ?VolumeStyle = null,

    pub const json_field_names = .{
        .aggregate_configuration = "AggregateConfiguration",
        .copy_tags_to_backups = "CopyTagsToBackups",
        .junction_path = "JunctionPath",
        .ontap_volume_type = "OntapVolumeType",
        .security_style = "SecurityStyle",
        .size_in_bytes = "SizeInBytes",
        .size_in_megabytes = "SizeInMegabytes",
        .snaplock_configuration = "SnaplockConfiguration",
        .snapshot_policy = "SnapshotPolicy",
        .storage_efficiency_enabled = "StorageEfficiencyEnabled",
        .storage_virtual_machine_id = "StorageVirtualMachineId",
        .tiering_policy = "TieringPolicy",
        .volume_style = "VolumeStyle",
    };
};
