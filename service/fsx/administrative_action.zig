const AdministrativeActionType = @import("administrative_action_type.zig").AdministrativeActionType;
const AdministrativeActionFailureDetails = @import("administrative_action_failure_details.zig").AdministrativeActionFailureDetails;
const Status = @import("status.zig").Status;
const FileSystem = @import("file_system.zig").FileSystem;
const Snapshot = @import("snapshot.zig").Snapshot;
const Volume = @import("volume.zig").Volume;

/// Describes a specific Amazon FSx administrative action for the current
/// Windows,
/// Lustre, OpenZFS, or ONTAP file system or volume.
pub const AdministrativeAction = struct {
    administrative_action_type: ?AdministrativeActionType = null,

    failure_details: ?AdministrativeActionFailureDetails = null,

    message: ?[]const u8 = null,

    /// The percentage-complete status of a `STORAGE_OPTIMIZATION`
    /// or `DOWNLOAD_DATA_FROM_BACKUP` administrative action. Does not apply to any
    /// other administrative action type.
    progress_percent: ?i32 = null,

    /// The remaining bytes to transfer for the FSx for OpenZFS snapshot that you're
    /// copying.
    remaining_transfer_bytes: ?i64 = null,

    /// The time that the administrative action request was received.
    request_time: ?i64 = null,

    /// The status of the administrative action, as follows:
    ///
    /// * `FAILED` - Amazon FSx failed to process the administrative action
    /// successfully.
    ///
    /// * `IN_PROGRESS` - Amazon FSx is processing the administrative action.
    ///
    /// * `PENDING` - Amazon FSx is waiting to process the administrative
    /// action.
    ///
    /// * `COMPLETED` - Amazon FSx has finished processing the administrative
    /// task.
    ///
    /// For a backup restore to a second-generation FSx for ONTAP file system,
    /// indicates that all data has been downloaded to the volume, and clients now
    /// have read-write access to volume.
    ///
    /// * `UPDATED_OPTIMIZING` - For a storage-capacity increase update, Amazon FSx
    /// has updated the file system with the new storage capacity, and is now
    /// performing
    /// the storage-optimization process.
    ///
    /// * `PENDING` - For a backup restore to a second-generation FSx for ONTAP file
    ///   system,
    /// indicates that the file metadata is being downloaded onto the volume. The
    /// volume's Lifecycle state is CREATING.
    ///
    /// * `IN_PROGRESS` - For a backup restore to a second-generation FSx for ONTAP
    ///   file system,
    /// indicates that all metadata has been downloaded to the new volume and client
    /// can access data with read-only access
    /// while Amazon FSx downloads the file data to the volume. Track the
    /// progress of this process with the `ProgressPercent` element.
    status: ?Status = null,

    /// The target value for the administration action, provided in the
    /// `UpdateFileSystem` operation. Returned for
    /// `FILE_SYSTEM_UPDATE` administrative actions.
    target_file_system_values: ?*FileSystem = null,

    target_snapshot_values: ?*Snapshot = null,

    target_volume_values: ?*Volume = null,

    /// The number of bytes that have transferred for the FSx for OpenZFS snapshot
    /// that you're copying.
    total_transfer_bytes: ?i64 = null,

    pub const json_field_names = .{
        .administrative_action_type = "AdministrativeActionType",
        .failure_details = "FailureDetails",
        .message = "Message",
        .progress_percent = "ProgressPercent",
        .remaining_transfer_bytes = "RemainingTransferBytes",
        .request_time = "RequestTime",
        .status = "Status",
        .target_file_system_values = "TargetFileSystemValues",
        .target_snapshot_values = "TargetSnapshotValues",
        .target_volume_values = "TargetVolumeValues",
        .total_transfer_bytes = "TotalTransferBytes",
    };
};
