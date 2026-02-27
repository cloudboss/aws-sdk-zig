/// Describes the type of administrative action, as follows:
///
/// * `FILE_SYSTEM_UPDATE` - A file system update administrative action
/// initiated from the Amazon FSx console, API
/// (`UpdateFileSystem`), or CLI
/// (`update-file-system`).
///
/// * `THROUGHPUT_OPTIMIZATION` - After the `FILE_SYSTEM_UPDATE`
/// task to increase a file system's throughput capacity has been completed
/// successfully, a `THROUGHPUT_OPTIMIZATION` task starts.
///
/// You can track the storage-optimization progress using the
/// `ProgressPercent` property. When
/// `THROUGHPUT_OPTIMIZATION` has been completed successfully, the
/// parent `FILE_SYSTEM_UPDATE` action status changes to
/// `COMPLETED`. For more information, see [Managing
/// throughput
/// capacity](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/managing-throughput-capacity.html) in the *Amazon FSx for Windows
/// File Server User Guide*.
///
/// * `STORAGE_OPTIMIZATION` - After the `FILE_SYSTEM_UPDATE`
/// task to increase a file system's storage capacity has completed
/// successfully, a `STORAGE_OPTIMIZATION` task starts.
///
/// * For Windows and ONTAP, storage optimization is the process of migrating
///   the file system data
/// to newer larger disks.
///
/// * For Lustre, storage optimization consists of rebalancing the data across
///   the existing and
/// newly added file servers.
///
/// You can track the storage-optimization progress using the
/// `ProgressPercent` property. When
/// `STORAGE_OPTIMIZATION` has been completed successfully, the
/// parent `FILE_SYSTEM_UPDATE` action status changes to
/// `COMPLETED`. For more information, see [Managing
/// storage
/// capacity](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/managing-storage-capacity.html) in the *Amazon FSx for Windows
/// File Server User Guide*, [Managing storage
/// capacity](https://docs.aws.amazon.com/fsx/latest/LustreGuide/managing-storage-capacity.html) in the *Amazon FSx for
/// Lustre User Guide*, and
/// [Managing storage capacity and provisioned
/// IOPS](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/managing-storage-capacity.html) in the *Amazon FSx for NetApp ONTAP User
/// Guide*.
///
/// * `FILE_SYSTEM_ALIAS_ASSOCIATION` - A file system update to associate a new
///   Domain
/// Name System (DNS) alias with the file system. For more information, see [
/// AssociateFileSystemAliases](https://docs.aws.amazon.com/fsx/latest/APIReference/API_AssociateFileSystemAliases.html).
///
/// * `FILE_SYSTEM_ALIAS_DISASSOCIATION` - A file system update to disassociate
///   a DNS alias from the file system.
/// For more information, see
/// [DisassociateFileSystemAliases](https://docs.aws.amazon.com/fsx/latest/APIReference/API_DisassociateFileSystemAliases.html).
///
/// * `IOPS_OPTIMIZATION` - After the `FILE_SYSTEM_UPDATE`
/// task to increase a file system's throughput capacity has been completed
/// successfully, a `IOPS_OPTIMIZATION` task starts.
///
/// You can track the storage-optimization progress using the
/// `ProgressPercent` property. When `IOPS_OPTIMIZATION`
/// has been completed successfully, the parent `FILE_SYSTEM_UPDATE`
/// action status changes to `COMPLETED`. For more information, see
/// [Managing
/// provisioned SSD
/// IOPS](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/managing-provisioned-ssd-iops.html) in the Amazon FSx for Windows File
/// Server User Guide.
///
/// * `STORAGE_TYPE_OPTIMIZATION` - After the `FILE_SYSTEM_UPDATE`
/// task to increase a file system's throughput capacity has been completed
/// successfully, a `STORAGE_TYPE_OPTIMIZATION` task starts.
///
/// You can track the storage-optimization progress using the
/// `ProgressPercent` property. When
/// `STORAGE_TYPE_OPTIMIZATION` has been completed successfully, the
/// parent `FILE_SYSTEM_UPDATE` action status changes to
/// `COMPLETED`.
///
/// * `VOLUME_UPDATE` - A volume update to an Amazon FSx for OpenZFS volume
/// initiated from the Amazon FSx console, API (`UpdateVolume`),
/// or CLI (`update-volume`).
///
/// * `VOLUME_RESTORE` - An Amazon FSx for OpenZFS volume
/// is returned to the state saved by the specified snapshot, initiated from an
/// API (`RestoreVolumeFromSnapshot`) or CLI
/// (`restore-volume-from-snapshot`).
///
/// * `SNAPSHOT_UPDATE` - A snapshot update to an Amazon FSx for
/// OpenZFS volume initiated from the Amazon FSx console, API
/// (`UpdateSnapshot`), or CLI (`update-snapshot`).
///
/// * `RELEASE_NFS_V3_LOCKS` - Tracks the release of Network File System
/// (NFS) V3 locks on an Amazon FSx for OpenZFS file system.
///
/// * `DOWNLOAD_DATA_FROM_BACKUP` - An FSx for ONTAP backup is
/// being restored to a new volume on a second-generation file system. Once the
/// all the file
/// metadata is loaded onto the volume, you can mount the volume with read-only
/// access.
/// during this process.
///
/// * `VOLUME_INITIALIZE_WITH_SNAPSHOT` - A volume is being created from
/// a snapshot on a different FSx for OpenZFS file system. You can
/// initiate this from the Amazon FSx console, API
/// (`CreateVolume`), or CLI (`create-volume`) when using
/// the using the `FULL_COPY` strategy.
///
/// * `VOLUME_UPDATE_WITH_SNAPSHOT` - A volume is being updated from a
/// snapshot on a different FSx for OpenZFS file system. You can initiate
/// this from the Amazon FSx console, API
/// (`CopySnapshotAndUpdateVolume`), or CLI
/// (`copy-snapshot-and-update-volume`).
pub const AdministrativeActionType = enum {
    file_system_update,
    storage_optimization,
    file_system_alias_association,
    file_system_alias_disassociation,
    volume_update,
    snapshot_update,
    release_nfs_v3_locks,
    volume_restore,
    throughput_optimization,
    iops_optimization,
    storage_type_optimization,
    misconfigured_state_recovery,
    volume_update_with_snapshot,
    volume_initialize_with_snapshot,
    download_data_from_backup,

    pub const json_field_names = .{
        .file_system_update = "FILE_SYSTEM_UPDATE",
        .storage_optimization = "STORAGE_OPTIMIZATION",
        .file_system_alias_association = "FILE_SYSTEM_ALIAS_ASSOCIATION",
        .file_system_alias_disassociation = "FILE_SYSTEM_ALIAS_DISASSOCIATION",
        .volume_update = "VOLUME_UPDATE",
        .snapshot_update = "SNAPSHOT_UPDATE",
        .release_nfs_v3_locks = "RELEASE_NFS_V3_LOCKS",
        .volume_restore = "VOLUME_RESTORE",
        .throughput_optimization = "THROUGHPUT_OPTIMIZATION",
        .iops_optimization = "IOPS_OPTIMIZATION",
        .storage_type_optimization = "STORAGE_TYPE_OPTIMIZATION",
        .misconfigured_state_recovery = "MISCONFIGURED_STATE_RECOVERY",
        .volume_update_with_snapshot = "VOLUME_UPDATE_WITH_SNAPSHOT",
        .volume_initialize_with_snapshot = "VOLUME_INITIALIZE_WITH_SNAPSHOT",
        .download_data_from_backup = "DOWNLOAD_DATA_FROM_BACKUP",
    };
};
