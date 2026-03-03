const ActiveDirectoryBackupAttributes = @import("active_directory_backup_attributes.zig").ActiveDirectoryBackupAttributes;
const BackupFailureDetails = @import("backup_failure_details.zig").BackupFailureDetails;
const FileSystem = @import("file_system.zig").FileSystem;
const BackupLifecycle = @import("backup_lifecycle.zig").BackupLifecycle;
const ResourceType = @import("resource_type.zig").ResourceType;
const Tag = @import("tag.zig").Tag;
const BackupType = @import("backup_type.zig").BackupType;
const Volume = @import("volume.zig").Volume;

/// A backup of an Amazon FSx for Windows File Server, Amazon FSx for
/// Lustre file system, Amazon FSx for NetApp ONTAP volume, or Amazon FSx
/// for OpenZFS file system.
pub const Backup = struct {
    /// The ID of the backup.
    backup_id: []const u8,

    /// The time when a particular backup was created.
    creation_time: i64,

    /// The configuration of the self-managed Microsoft Active Directory directory
    /// to which
    /// the Windows File Server instance is joined.
    directory_information: ?ActiveDirectoryBackupAttributes = null,

    /// Details explaining any failures that occurred when creating a backup.
    failure_details: ?BackupFailureDetails = null,

    /// The metadata of the file system associated with the backup. This metadata is
    /// persisted
    /// even if the file system is deleted.
    file_system: FileSystem,

    /// The ID of the Key Management Service (KMS) key used to encrypt the
    /// backup of the Amazon FSx file system's data at rest.
    kms_key_id: ?[]const u8 = null,

    /// The lifecycle status of the backup.
    ///
    /// * `AVAILABLE` - The backup is fully available.
    ///
    /// * `PENDING` - For user-initiated backups on Lustre file systems only; Amazon
    ///   FSx hasn't started creating the backup.
    ///
    /// * `CREATING` - Amazon FSx is creating the backup.
    ///
    /// * `TRANSFERRING` - For user-initiated backups on Lustre file systems only;
    ///   Amazon FSx is transferring the backup to Amazon S3.
    ///
    /// * `COPYING` - Amazon FSx is copying the backup.
    ///
    /// * `DELETED` - Amazon FSx deleted the backup and it's no longer
    /// available.
    ///
    /// * `FAILED` - Amazon FSx couldn't finish the backup.
    lifecycle: BackupLifecycle,

    owner_id: ?[]const u8 = null,

    progress_percent: ?i32 = null,

    /// The Amazon Resource Name (ARN) for the backup resource.
    resource_arn: ?[]const u8 = null,

    /// Specifies the resource type that's backed up.
    resource_type: ?ResourceType = null,

    /// The size of the backup in bytes. This represents the amount of data that the
    /// file system would contain if you restore this backup.
    size_in_bytes: ?i64 = null,

    source_backup_id: ?[]const u8 = null,

    /// The source Region of the backup. Specifies the Region from where this backup
    /// is copied.
    source_backup_region: ?[]const u8 = null,

    /// The tags associated with a particular file system.
    tags: ?[]const Tag = null,

    /// The type of the file-system backup.
    @"type": BackupType,

    volume: ?Volume = null,

    pub const json_field_names = .{
        .backup_id = "BackupId",
        .creation_time = "CreationTime",
        .directory_information = "DirectoryInformation",
        .failure_details = "FailureDetails",
        .file_system = "FileSystem",
        .kms_key_id = "KmsKeyId",
        .lifecycle = "Lifecycle",
        .owner_id = "OwnerId",
        .progress_percent = "ProgressPercent",
        .resource_arn = "ResourceARN",
        .resource_type = "ResourceType",
        .size_in_bytes = "SizeInBytes",
        .source_backup_id = "SourceBackupId",
        .source_backup_region = "SourceBackupRegion",
        .tags = "Tags",
        .@"type" = "Type",
        .volume = "Volume",
    };
};
