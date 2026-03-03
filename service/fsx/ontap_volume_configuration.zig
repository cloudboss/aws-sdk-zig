const AggregateConfiguration = @import("aggregate_configuration.zig").AggregateConfiguration;
const FlexCacheEndpointType = @import("flex_cache_endpoint_type.zig").FlexCacheEndpointType;
const OntapVolumeType = @import("ontap_volume_type.zig").OntapVolumeType;
const SecurityStyle = @import("security_style.zig").SecurityStyle;
const SnaplockConfiguration = @import("snaplock_configuration.zig").SnaplockConfiguration;
const TieringPolicy = @import("tiering_policy.zig").TieringPolicy;
const VolumeStyle = @import("volume_style.zig").VolumeStyle;

/// The configuration of an Amazon FSx for NetApp ONTAP volume.
pub const OntapVolumeConfiguration = struct {
    /// This structure specifies configuration options for a volume’s storage
    /// aggregate or aggregates.
    aggregate_configuration: ?AggregateConfiguration = null,

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

    /// Specifies the FlexCache endpoint type of the volume.
    /// Valid values are the following:
    ///
    /// * `NONE` specifies that the volume doesn't have a FlexCache configuration.
    /// `NONE` is the default.
    ///
    /// * `ORIGIN` specifies that the volume is the origin volume for a FlexCache
    ///   volume.
    ///
    /// * `CACHE` specifies that the volume is a FlexCache volume.
    flex_cache_endpoint_type: ?FlexCacheEndpointType = null,

    /// Specifies the directory that network-attached storage (NAS) clients use to
    /// mount the
    /// volume, along with the storage virtual machine (SVM) Domain Name System
    /// (DNS) name or IP
    /// address. You can create a `JunctionPath` directly below a parent volume
    /// junction or on a directory within a volume. A `JunctionPath` for a volume
    /// named `vol3` might be `/vol1/vol2/vol3`, or
    /// `/vol1/dir2/vol3`, or even `/dir1/dir2/vol3`.
    junction_path: ?[]const u8 = null,

    /// Specifies the type of volume. Valid values are the following:
    ///
    /// * `RW` specifies a read/write volume. `RW` is the default.
    ///
    /// * `DP` specifies a data-protection volume. You can protect data by
    ///   replicating it to
    /// data-protection mirror copies. If a disaster occurs, you can use these
    /// data-protection mirror copies to recover data.
    ///
    /// * `LS` specifies a load-sharing mirror volume. A load-sharing mirror reduces
    ///   the
    /// network traffic to a FlexVol volume by providing additional read-only access
    /// to
    /// clients.
    ontap_volume_type: ?OntapVolumeType = null,

    /// The security style for the volume, which can be `UNIX`, `NTFS`,
    /// or
    /// `MIXED`.
    security_style: ?SecurityStyle = null,

    /// The configured size of the volume, in bytes.
    size_in_bytes: ?i64 = null,

    /// The configured size of the volume, in megabytes (MBs).
    size_in_megabytes: ?i32 = null,

    /// The SnapLock configuration object for an FSx for ONTAP SnapLock volume.
    snaplock_configuration: ?SnaplockConfiguration = null,

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

    /// The volume's storage efficiency setting.
    storage_efficiency_enabled: ?bool = null,

    /// The ID of the volume's storage virtual machine.
    storage_virtual_machine_id: ?[]const u8 = null,

    /// A Boolean flag indicating whether this volume is the root volume for its
    /// storage
    /// virtual machine (SVM). Only one volume on an SVM can be the root volume.
    /// This value
    /// defaults to `false`. If this value is `true`, then this is the SVM
    /// root volume.
    ///
    /// This flag is useful when you're deleting an SVM, because you must first
    /// delete all
    /// non-root volumes. This flag, when set to `false`, helps you identify which
    /// volumes to delete before you can delete the SVM.
    storage_virtual_machine_root: ?bool = null,

    /// The volume's `TieringPolicy` setting.
    tiering_policy: ?TieringPolicy = null,

    /// The volume's universally unique identifier (UUID).
    uuid: ?[]const u8 = null,

    /// Use to specify the style of an ONTAP volume. For more information about
    /// FlexVols and FlexGroups, see [Volume
    /// types](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/volume-types.html)
    /// in Amazon FSx for NetApp ONTAP User Guide.
    volume_style: ?VolumeStyle = null,

    pub const json_field_names = .{
        .aggregate_configuration = "AggregateConfiguration",
        .copy_tags_to_backups = "CopyTagsToBackups",
        .flex_cache_endpoint_type = "FlexCacheEndpointType",
        .junction_path = "JunctionPath",
        .ontap_volume_type = "OntapVolumeType",
        .security_style = "SecurityStyle",
        .size_in_bytes = "SizeInBytes",
        .size_in_megabytes = "SizeInMegabytes",
        .snaplock_configuration = "SnaplockConfiguration",
        .snapshot_policy = "SnapshotPolicy",
        .storage_efficiency_enabled = "StorageEfficiencyEnabled",
        .storage_virtual_machine_id = "StorageVirtualMachineId",
        .storage_virtual_machine_root = "StorageVirtualMachineRoot",
        .tiering_policy = "TieringPolicy",
        .uuid = "UUID",
        .volume_style = "VolumeStyle",
    };
};
