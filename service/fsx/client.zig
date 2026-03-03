const aws = @import("aws");
const std = @import("std");

const associate_file_system_aliases = @import("associate_file_system_aliases.zig");
const cancel_data_repository_task = @import("cancel_data_repository_task.zig");
const copy_backup = @import("copy_backup.zig");
const copy_snapshot_and_update_volume = @import("copy_snapshot_and_update_volume.zig");
const create_and_attach_s3_access_point = @import("create_and_attach_s3_access_point.zig");
const create_backup = @import("create_backup.zig");
const create_data_repository_association = @import("create_data_repository_association.zig");
const create_data_repository_task = @import("create_data_repository_task.zig");
const create_file_cache = @import("create_file_cache.zig");
const create_file_system = @import("create_file_system.zig");
const create_file_system_from_backup = @import("create_file_system_from_backup.zig");
const create_snapshot = @import("create_snapshot.zig");
const create_storage_virtual_machine = @import("create_storage_virtual_machine.zig");
const create_volume = @import("create_volume.zig");
const create_volume_from_backup = @import("create_volume_from_backup.zig");
const delete_backup = @import("delete_backup.zig");
const delete_data_repository_association = @import("delete_data_repository_association.zig");
const delete_file_cache = @import("delete_file_cache.zig");
const delete_file_system = @import("delete_file_system.zig");
const delete_snapshot = @import("delete_snapshot.zig");
const delete_storage_virtual_machine = @import("delete_storage_virtual_machine.zig");
const delete_volume = @import("delete_volume.zig");
const describe_backups = @import("describe_backups.zig");
const describe_data_repository_associations = @import("describe_data_repository_associations.zig");
const describe_data_repository_tasks = @import("describe_data_repository_tasks.zig");
const describe_file_caches = @import("describe_file_caches.zig");
const describe_file_system_aliases = @import("describe_file_system_aliases.zig");
const describe_file_systems = @import("describe_file_systems.zig");
const describe_s3_access_point_attachments = @import("describe_s3_access_point_attachments.zig");
const describe_shared_vpc_configuration = @import("describe_shared_vpc_configuration.zig");
const describe_snapshots = @import("describe_snapshots.zig");
const describe_storage_virtual_machines = @import("describe_storage_virtual_machines.zig");
const describe_volumes = @import("describe_volumes.zig");
const detach_and_delete_s3_access_point = @import("detach_and_delete_s3_access_point.zig");
const disassociate_file_system_aliases = @import("disassociate_file_system_aliases.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const release_file_system_nfs_v3_locks = @import("release_file_system_nfs_v3_locks.zig");
const restore_volume_from_snapshot = @import("restore_volume_from_snapshot.zig");
const start_misconfigured_state_recovery = @import("start_misconfigured_state_recovery.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_data_repository_association = @import("update_data_repository_association.zig");
const update_file_cache = @import("update_file_cache.zig");
const update_file_system = @import("update_file_system.zig");
const update_shared_vpc_configuration = @import("update_shared_vpc_configuration.zig");
const update_snapshot = @import("update_snapshot.zig");
const update_storage_virtual_machine = @import("update_storage_virtual_machine.zig");
const update_volume = @import("update_volume.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "FSx";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Use this action to associate one or more Domain Name Server (DNS) aliases
    /// with an existing Amazon FSx for Windows File Server file system.
    /// A file system can have a maximum of 50 DNS aliases associated with it at any
    /// one time. If you try to
    /// associate a DNS alias that is already associated with the file system, FSx
    /// takes no action on that alias in the request.
    /// For more information, see [Working with DNS
    /// Aliases](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/managing-dns-aliases.html) and
    /// [Walkthrough 5: Using DNS aliases to access your file
    /// system](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/walkthrough05-file-system-custom-CNAME.html), including
    /// additional steps you must take to be able to access your file system using a
    /// DNS alias.
    ///
    /// The system response shows the DNS aliases that
    /// Amazon FSx is attempting to associate with the file system.
    /// Use the API
    /// operation to monitor the status of the aliases Amazon FSx is
    /// associating with the file system.
    pub fn associateFileSystemAliases(self: *Self, allocator: std.mem.Allocator, input: associate_file_system_aliases.AssociateFileSystemAliasesInput, options: CallOptions) !associate_file_system_aliases.AssociateFileSystemAliasesOutput {
        return associate_file_system_aliases.execute(self, allocator, input, options);
    }

    /// Cancels an existing Amazon FSx for Lustre data repository task if that task
    /// is in either the
    /// `PENDING` or `EXECUTING` state. When you cancel an export task, Amazon FSx
    /// does the following.
    ///
    /// * Any files that FSx has already exported are not reverted.
    ///
    /// * FSx continues to export any files that are in-flight when the cancel
    ///   operation is received.
    ///
    /// * FSx does not export any files that have not yet been exported.
    ///
    /// For a release task, Amazon FSx will stop releasing files upon cancellation.
    /// Any files that
    /// have already been released will remain in the released state.
    pub fn cancelDataRepositoryTask(self: *Self, allocator: std.mem.Allocator, input: cancel_data_repository_task.CancelDataRepositoryTaskInput, options: CallOptions) !cancel_data_repository_task.CancelDataRepositoryTaskOutput {
        return cancel_data_repository_task.execute(self, allocator, input, options);
    }

    /// Copies an existing backup within the same Amazon Web Services account to
    /// another Amazon Web Services Region
    /// (cross-Region copy) or within the same Amazon Web Services Region (in-Region
    /// copy). You can have up to five
    /// backup copy requests in progress to a single destination Region per account.
    ///
    /// You can use cross-Region backup copies for cross-Region disaster recovery.
    /// You can
    /// periodically take backups and copy them to another Region so that in the
    /// event of a
    /// disaster in the primary Region, you can restore from backup and recover
    /// availability
    /// quickly in the other Region. You can make cross-Region copies only within
    /// your Amazon Web Services partition. A partition is a grouping of Regions.
    /// Amazon Web Services currently
    /// has three partitions: `aws` (Standard Regions), `aws-cn` (China
    /// Regions), and `aws-us-gov` (Amazon Web Services GovCloud [US] Regions).
    ///
    /// You can also use backup copies to clone your file dataset to another Region
    /// or within
    /// the same Region.
    ///
    /// You can use the `SourceRegion` parameter to specify the Amazon Web Services
    /// Region
    /// from which the backup will be copied. For example, if you make the call from
    /// the
    /// `us-west-1` Region and want to copy a backup from the `us-east-2`
    /// Region, you specify `us-east-2` in the `SourceRegion` parameter
    /// to make a cross-Region copy. If you don't specify a Region, the backup copy
    /// is
    /// created in the same Region where the request is sent from (in-Region copy).
    ///
    /// For more information about creating backup copies, see [ Copying
    /// backups](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/using-backups.html#copy-backups)
    /// in the *Amazon FSx for Windows User Guide*, [Copying
    /// backups](https://docs.aws.amazon.com/fsx/latest/LustreGuide/using-backups-fsx.html#copy-backups) in the *Amazon FSx for Lustre User
    /// Guide*, and [Copying
    /// backups](https://docs.aws.amazon.com/fsx/latest/OpenZFSGuide/using-backups.html#copy-backups) in the *Amazon FSx for OpenZFS User
    /// Guide*.
    pub fn copyBackup(self: *Self, allocator: std.mem.Allocator, input: copy_backup.CopyBackupInput, options: CallOptions) !copy_backup.CopyBackupOutput {
        return copy_backup.execute(self, allocator, input, options);
    }

    /// Updates an existing volume by using a snapshot from another Amazon FSx for
    /// OpenZFS file system. For more information, see [on-demand data
    /// replication](https://docs.aws.amazon.com/fsx/latest/OpenZFSGuide/on-demand-replication.html) in the Amazon FSx for OpenZFS User
    /// Guide.
    pub fn copySnapshotAndUpdateVolume(self: *Self, allocator: std.mem.Allocator, input: copy_snapshot_and_update_volume.CopySnapshotAndUpdateVolumeInput, options: CallOptions) !copy_snapshot_and_update_volume.CopySnapshotAndUpdateVolumeOutput {
        return copy_snapshot_and_update_volume.execute(self, allocator, input, options);
    }

    /// Creates an S3 access point and attaches it to an Amazon FSx volume. For FSx
    /// for OpenZFS file systems, the
    /// volume must be hosted on a high-availability file system, either Single-AZ
    /// or Multi-AZ. For more information,
    /// see [Accessing your data using Amazon S3 access
    /// points](https://docs.aws.amazon.com/fsx/latest/OpenZFSGuide/s3accesspoints-for-FSx.html).
    /// in the Amazon FSx for OpenZFS User Guide.
    ///
    /// The requester requires the following permissions to perform these actions:
    ///
    /// * `fsx:CreateAndAttachS3AccessPoint`
    ///
    /// * `s3:CreateAccessPoint`
    ///
    /// * `s3:GetAccessPoint`
    ///
    /// * `s3:PutAccessPointPolicy`
    ///
    /// * `s3:DeleteAccessPoint`
    ///
    /// The following actions are related to `CreateAndAttachS3AccessPoint`:
    ///
    /// * DescribeS3AccessPointAttachments
    ///
    /// * DetachAndDeleteS3AccessPoint
    pub fn createAndAttachS3AccessPoint(self: *Self, allocator: std.mem.Allocator, input: create_and_attach_s3_access_point.CreateAndAttachS3AccessPointInput, options: CallOptions) !create_and_attach_s3_access_point.CreateAndAttachS3AccessPointOutput {
        return create_and_attach_s3_access_point.execute(self, allocator, input, options);
    }

    /// Creates a backup of an existing Amazon FSx for Windows File Server file
    /// system, Amazon FSx for Lustre file system, Amazon FSx for NetApp ONTAP
    /// volume, or Amazon FSx for OpenZFS file system. We recommend creating regular
    /// backups so that you can restore a file system or volume from a backup if an
    /// issue arises
    /// with the original file system or volume.
    ///
    /// For Amazon FSx for Lustre file systems, you can create a backup only for
    /// file
    /// systems that have the following configuration:
    ///
    /// * A Persistent deployment type
    ///
    /// * Are *not* linked to a data repository
    ///
    /// For more information about backups, see the following:
    ///
    /// * For Amazon FSx for Lustre, see [Working with FSx for
    /// Lustre
    /// backups](https://docs.aws.amazon.com/fsx/latest/LustreGuide/using-backups-fsx.html).
    ///
    /// * For Amazon FSx for Windows, see [Working with FSx for
    /// Windows
    /// backups](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/using-backups.html).
    ///
    /// * For Amazon FSx for NetApp ONTAP, see [Working with FSx for NetApp
    /// ONTAP
    /// backups](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/using-backups.html).
    ///
    /// * For Amazon FSx for OpenZFS, see [Working with FSx for OpenZFS
    ///   backups](https://docs.aws.amazon.com/fsx/latest/OpenZFSGuide/using-backups.html).
    ///
    /// If a backup with the specified client request token exists and the
    /// parameters match,
    /// this operation returns the description of the existing backup. If a backup
    /// with the
    /// specified client request token exists and the parameters don't match, this
    /// operation
    /// returns `IncompatibleParameterError`. If a backup with the specified client
    /// request token doesn't exist, `CreateBackup` does the following:
    ///
    /// * Creates a new Amazon FSx backup with an assigned ID, and an initial
    /// lifecycle state of `CREATING`.
    ///
    /// * Returns the description of the backup.
    ///
    /// By using the idempotent operation, you can retry a `CreateBackup`
    /// operation without the risk of creating an extra backup. This approach can be
    /// useful when
    /// an initial call fails in a way that makes it unclear whether a backup was
    /// created. If
    /// you use the same client request token and the initial call created a backup,
    /// the
    /// operation returns a successful result because all the parameters are the
    /// same.
    ///
    /// The `CreateBackup` operation returns while the backup's lifecycle state is
    /// still `CREATING`. You can check the backup creation status by calling the
    /// [DescribeBackups](https://docs.aws.amazon.com/fsx/latest/APIReference/API_DescribeBackups.html) operation, which returns the backup state along with other
    /// information.
    pub fn createBackup(self: *Self, allocator: std.mem.Allocator, input: create_backup.CreateBackupInput, options: CallOptions) !create_backup.CreateBackupOutput {
        return create_backup.execute(self, allocator, input, options);
    }

    /// Creates an Amazon FSx for Lustre data repository association (DRA). A data
    /// repository association is a link between a directory on the file system and
    /// an Amazon S3 bucket or prefix. You can have a maximum of 8 data repository
    /// associations on a file system. Data repository associations are supported
    /// on all FSx for Lustre 2.12 and 2.15 file systems, excluding
    /// `scratch_1` deployment type.
    ///
    /// Each data repository association must have a unique Amazon FSx file
    /// system directory and a unique S3 bucket or prefix associated with it. You
    /// can configure a data repository association for automatic import only,
    /// for automatic export only, or for both. To learn more about linking a
    /// data repository to your file system, see
    /// [Linking your file system to an S3
    /// bucket](https://docs.aws.amazon.com/fsx/latest/LustreGuide/create-dra-linked-data-repo.html).
    ///
    /// `CreateDataRepositoryAssociation` isn't supported
    /// on Amazon File Cache resources. To create a DRA on Amazon File Cache,
    /// use the `CreateFileCache` operation.
    pub fn createDataRepositoryAssociation(self: *Self, allocator: std.mem.Allocator, input: create_data_repository_association.CreateDataRepositoryAssociationInput, options: CallOptions) !create_data_repository_association.CreateDataRepositoryAssociationOutput {
        return create_data_repository_association.execute(self, allocator, input, options);
    }

    /// Creates an Amazon FSx for Lustre data repository task.
    /// A `CreateDataRepositoryTask` operation will fail if a data
    /// repository is not linked to the FSx file system.
    ///
    /// You use import and export data repository tasks to perform bulk operations
    /// between your
    /// FSx for Lustre file system and its linked data repositories. An example of a
    /// data repository
    /// task is exporting any data and metadata changes, including POSIX metadata,
    /// to files, directories,
    /// and symbolic links (symlinks) from your FSx file system to a linked data
    /// repository.
    ///
    /// You use release data repository tasks to release data from your file system
    /// for files that
    /// are exported to S3. The metadata of released files remains on the file
    /// system so users or applications
    /// can still access released files by reading the files again, which will
    /// restore data from
    /// Amazon S3 to the FSx for Lustre file system.
    ///
    /// To learn more about data repository tasks, see
    /// [Data Repository
    /// Tasks](https://docs.aws.amazon.com/fsx/latest/LustreGuide/data-repository-tasks.html).
    /// To learn more about linking a data repository to your file system, see
    /// [Linking your file system to an S3
    /// bucket](https://docs.aws.amazon.com/fsx/latest/LustreGuide/create-dra-linked-data-repo.html).
    pub fn createDataRepositoryTask(self: *Self, allocator: std.mem.Allocator, input: create_data_repository_task.CreateDataRepositoryTaskInput, options: CallOptions) !create_data_repository_task.CreateDataRepositoryTaskOutput {
        return create_data_repository_task.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon File Cache resource.
    ///
    /// You can use this operation with a client request token in the request that
    /// Amazon File Cache uses to ensure idempotent creation.
    /// If a cache with the specified client request token exists and the parameters
    /// match, `CreateFileCache` returns the description of the existing
    /// cache. If a cache with the specified client request token exists and the
    /// parameters don't match, this call returns `IncompatibleParameterError`.
    /// If a file cache with the specified client request token doesn't exist,
    /// `CreateFileCache` does the following:
    ///
    /// * Creates a new, empty Amazon File Cache resource with an assigned ID, and
    /// an initial lifecycle state of `CREATING`.
    ///
    /// * Returns the description of the cache in JSON format.
    ///
    /// The `CreateFileCache` call returns while the cache's lifecycle
    /// state is still `CREATING`. You can check the cache creation status
    /// by calling the
    /// [DescribeFileCaches](https://docs.aws.amazon.com/fsx/latest/APIReference/API_DescribeFileCaches.html) operation, which returns the cache state
    /// along with other information.
    pub fn createFileCache(self: *Self, allocator: std.mem.Allocator, input: create_file_cache.CreateFileCacheInput, options: CallOptions) !create_file_cache.CreateFileCacheOutput {
        return create_file_cache.execute(self, allocator, input, options);
    }

    /// Creates a new, empty Amazon FSx file system. You can create the following
    /// supported
    /// Amazon FSx file systems using the `CreateFileSystem` API operation:
    ///
    /// * Amazon FSx for Lustre
    ///
    /// * Amazon FSx for NetApp ONTAP
    ///
    /// * Amazon FSx for OpenZFS
    ///
    /// * Amazon FSx for Windows File Server
    ///
    /// This operation requires a client request token in the request that Amazon
    /// FSx uses
    /// to ensure idempotent creation. This means that calling the operation
    /// multiple times with
    /// the same client request token has no effect. By using the idempotent
    /// operation, you can
    /// retry a `CreateFileSystem` operation without the risk of creating an extra
    /// file system. This approach can be useful when an initial call fails in a way
    /// that makes
    /// it unclear whether a file system was created. Examples are if a transport
    /// level timeout
    /// occurred, or your connection was reset. If you use the same client request
    /// token and the
    /// initial call created a file system, the client receives success as long as
    /// the
    /// parameters are the same.
    ///
    /// If a file system with the specified client request token exists and the
    /// parameters
    /// match, `CreateFileSystem` returns the description of the existing file
    /// system. If a file system with the specified client request token exists and
    /// the
    /// parameters don't match, this call returns `IncompatibleParameterError`. If a
    /// file system with the specified client request token doesn't exist,
    /// `CreateFileSystem` does the following:
    ///
    /// * Creates a new, empty Amazon FSx file system with an assigned ID, and
    /// an initial lifecycle state of `CREATING`.
    ///
    /// * Returns the description of the file system in JSON format.
    ///
    /// The `CreateFileSystem` call returns while the file system's lifecycle
    /// state is still `CREATING`. You can check the file-system creation status
    /// by calling the
    /// [DescribeFileSystems](https://docs.aws.amazon.com/fsx/latest/APIReference/API_DescribeFileSystems.html) operation, which returns the file system state
    /// along with other information.
    pub fn createFileSystem(self: *Self, allocator: std.mem.Allocator, input: create_file_system.CreateFileSystemInput, options: CallOptions) !create_file_system.CreateFileSystemOutput {
        return create_file_system.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon FSx for Lustre, Amazon FSx for Windows File
    /// Server, or Amazon FSx for OpenZFS file system from an existing Amazon FSx
    /// backup.
    ///
    /// If a file system with the specified client request token exists and the
    /// parameters
    /// match, this operation returns the description of the file system. If a file
    /// system
    /// with the specified client request token exists but the parameters don't
    /// match, this
    /// call returns `IncompatibleParameterError`. If a file system with the
    /// specified client request token doesn't exist, this operation does the
    /// following:
    ///
    /// * Creates a new Amazon FSx file system from backup with an assigned ID,
    /// and an initial lifecycle state of `CREATING`.
    ///
    /// * Returns the description of the file system.
    ///
    /// Parameters like the Active Directory, default share name, automatic backup,
    /// and backup
    /// settings default to the parameters of the file system that was backed up,
    /// unless
    /// overridden. You can explicitly supply other settings.
    ///
    /// By using the idempotent operation, you can retry a
    /// `CreateFileSystemFromBackup` call without the risk of creating an extra
    /// file system. This approach can be useful when an initial call fails in a way
    /// that makes
    /// it unclear whether a file system was created. Examples are if a transport
    /// level timeout
    /// occurred, or your connection was reset. If you use the same client request
    /// token and the
    /// initial call created a file system, the client receives a success message as
    /// long as the
    /// parameters are the same.
    ///
    /// The `CreateFileSystemFromBackup` call returns while the file system's
    /// lifecycle state is still `CREATING`. You can check the file-system
    /// creation status by calling the [
    /// DescribeFileSystems](https://docs.aws.amazon.com/fsx/latest/APIReference/API_DescribeFileSystems.html) operation, which returns the file system state along
    /// with other information.
    pub fn createFileSystemFromBackup(self: *Self, allocator: std.mem.Allocator, input: create_file_system_from_backup.CreateFileSystemFromBackupInput, options: CallOptions) !create_file_system_from_backup.CreateFileSystemFromBackupOutput {
        return create_file_system_from_backup.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of an existing Amazon FSx for OpenZFS volume. With
    /// snapshots, you can easily undo file changes and compare file versions by
    /// restoring the
    /// volume to a previous version.
    ///
    /// If a snapshot with the specified client request token exists, and the
    /// parameters
    /// match, this operation returns the description of the existing snapshot. If a
    /// snapshot
    /// with the specified client request token exists, and the parameters don't
    /// match, this
    /// operation returns `IncompatibleParameterError`. If a snapshot with the
    /// specified client request token doesn't exist, `CreateSnapshot` does the
    /// following:
    ///
    /// * Creates a new OpenZFS snapshot with an assigned ID, and an initial
    ///   lifecycle
    /// state of `CREATING`.
    ///
    /// * Returns the description of the snapshot.
    ///
    /// By using the idempotent operation, you can retry a `CreateSnapshot`
    /// operation without the risk of creating an extra snapshot. This approach can
    /// be useful
    /// when an initial call fails in a way that makes it unclear whether a snapshot
    /// was
    /// created. If you use the same client request token and the initial call
    /// created a
    /// snapshot, the operation returns a successful result because all the
    /// parameters are the
    /// same.
    ///
    /// The `CreateSnapshot` operation returns while the snapshot's lifecycle state
    /// is still `CREATING`. You can check the snapshot creation status by calling
    /// the
    /// [DescribeSnapshots](https://docs.aws.amazon.com/fsx/latest/APIReference/API_DescribeSnapshots.html) operation, which returns the snapshot state along with
    /// other information.
    pub fn createSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_snapshot.CreateSnapshotInput, options: CallOptions) !create_snapshot.CreateSnapshotOutput {
        return create_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a storage virtual machine (SVM) for an Amazon FSx for ONTAP file
    /// system.
    pub fn createStorageVirtualMachine(self: *Self, allocator: std.mem.Allocator, input: create_storage_virtual_machine.CreateStorageVirtualMachineInput, options: CallOptions) !create_storage_virtual_machine.CreateStorageVirtualMachineOutput {
        return create_storage_virtual_machine.execute(self, allocator, input, options);
    }

    /// Creates an FSx for ONTAP or Amazon FSx for OpenZFS storage volume.
    pub fn createVolume(self: *Self, allocator: std.mem.Allocator, input: create_volume.CreateVolumeInput, options: CallOptions) !create_volume.CreateVolumeOutput {
        return create_volume.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon FSx for NetApp ONTAP volume from an
    /// existing Amazon FSx volume backup.
    pub fn createVolumeFromBackup(self: *Self, allocator: std.mem.Allocator, input: create_volume_from_backup.CreateVolumeFromBackupInput, options: CallOptions) !create_volume_from_backup.CreateVolumeFromBackupOutput {
        return create_volume_from_backup.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon FSx backup. After deletion, the backup no longer exists,
    /// and
    /// its data is gone.
    ///
    /// The `DeleteBackup` call returns instantly. The backup won't show up in
    /// later `DescribeBackups` calls.
    ///
    /// The data in a deleted backup is also deleted and can't be recovered by any
    /// means.
    pub fn deleteBackup(self: *Self, allocator: std.mem.Allocator, input: delete_backup.DeleteBackupInput, options: CallOptions) !delete_backup.DeleteBackupOutput {
        return delete_backup.execute(self, allocator, input, options);
    }

    /// Deletes a data repository association on an Amazon FSx for Lustre
    /// file system. Deleting the data repository association unlinks the
    /// file system from the Amazon S3 bucket. When deleting a data repository
    /// association, you have the option of deleting the data in the file system
    /// that corresponds to the data repository association. Data repository
    /// associations are supported on all FSx for Lustre 2.12 and 2.15 file
    /// systems, excluding `scratch_1` deployment type.
    pub fn deleteDataRepositoryAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_data_repository_association.DeleteDataRepositoryAssociationInput, options: CallOptions) !delete_data_repository_association.DeleteDataRepositoryAssociationOutput {
        return delete_data_repository_association.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon File Cache resource. After deletion, the cache no longer
    /// exists, and its data
    /// is gone.
    ///
    /// The `DeleteFileCache` operation returns while the cache has the
    /// `DELETING` status. You can check the cache deletion status by
    /// calling the
    /// [DescribeFileCaches](https://docs.aws.amazon.com/fsx/latest/APIReference/API_DescribeFileCaches.html) operation, which returns a list of caches in your
    /// account. If you pass the cache ID for a deleted cache, the
    /// `DescribeFileCaches` operation returns a `FileCacheNotFound`
    /// error.
    ///
    /// The data in a deleted cache is also deleted and can't be recovered by
    /// any means.
    pub fn deleteFileCache(self: *Self, allocator: std.mem.Allocator, input: delete_file_cache.DeleteFileCacheInput, options: CallOptions) !delete_file_cache.DeleteFileCacheOutput {
        return delete_file_cache.execute(self, allocator, input, options);
    }

    /// Deletes a file system. After deletion, the file system no longer exists, and
    /// its data
    /// is gone. Any existing automatic backups and snapshots are also deleted.
    ///
    /// To delete an Amazon FSx for NetApp ONTAP file system, first delete all the
    /// volumes and storage virtual machines (SVMs) on the file system. Then provide
    /// a
    /// `FileSystemId` value to the `DeleteFileSystem` operation.
    ///
    /// Before deleting an Amazon FSx for OpenZFS file system, make sure that there
    /// aren't
    /// any Amazon S3 access points attached to any volume. For more information on
    /// how to list S3
    /// access points that are attached to volumes, see
    /// [Listing S3 access point
    /// attachments](https://docs.aws.amazon.com/fsx/latest/OpenZFSGuide/access-points-list.html).
    /// For more information on how to delete S3 access points, see
    /// [Deleting an S3 access point
    /// attachment](https://docs.aws.amazon.com/fsx/latest/OpenZFSGuide/delete-access-point.html).
    ///
    /// By default, when you delete an Amazon FSx for Windows File Server file
    /// system,
    /// a final backup is created upon deletion. This final backup isn't subject to
    /// the file
    /// system's retention policy, and must be manually deleted.
    ///
    /// To delete an Amazon FSx for Lustre file system, first
    /// [unmount](https://docs.aws.amazon.com/fsx/latest/LustreGuide/unmounting-fs.html)
    /// it from every connected Amazon EC2 instance, then provide a `FileSystemId`
    /// value to the `DeleteFileSystem` operation. By default, Amazon FSx will not
    /// take a final backup when the `DeleteFileSystem` operation is invoked. On
    /// file systems
    /// not linked to an Amazon S3 bucket, set `SkipFinalBackup` to `false`
    /// to take a final backup of the file system you are deleting. Backups cannot
    /// be enabled on S3-linked
    /// file systems. To ensure all of your data is written back to S3 before
    /// deleting your file system,
    /// you can either monitor for the
    /// [AgeOfOldestQueuedMessage](https://docs.aws.amazon.com/fsx/latest/LustreGuide/monitoring-cloudwatch.html#auto-import-export-metrics)
    /// metric to be zero (if using automatic export) or you can run an
    /// [export data repository
    /// task](https://docs.aws.amazon.com/fsx/latest/LustreGuide/export-data-repo-task-dra.html).
    /// If you have automatic export enabled and want to use an export data
    /// repository task, you have
    /// to disable automatic export before executing the export data repository
    /// task.
    ///
    /// The `DeleteFileSystem` operation returns while the file system has the
    /// `DELETING` status. You can check the file system deletion status by
    /// calling the
    /// [DescribeFileSystems](https://docs.aws.amazon.com/fsx/latest/APIReference/API_DescribeFileSystems.html) operation, which returns a list of file systems in your
    /// account. If you pass the file system ID for a deleted file system, the
    /// `DescribeFileSystems` operation returns a `FileSystemNotFound`
    /// error.
    ///
    /// If a data repository task is in a `PENDING` or `EXECUTING` state,
    /// deleting an Amazon FSx for Lustre file system will fail with an HTTP status
    /// code 400 (Bad Request).
    ///
    /// The data in a deleted file system is also deleted and can't be recovered by
    /// any means.
    pub fn deleteFileSystem(self: *Self, allocator: std.mem.Allocator, input: delete_file_system.DeleteFileSystemInput, options: CallOptions) !delete_file_system.DeleteFileSystemOutput {
        return delete_file_system.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon FSx for OpenZFS snapshot. After deletion, the snapshot no
    /// longer
    /// exists, and its data is gone. Deleting a snapshot doesn't affect snapshots
    /// stored in a
    /// file system backup.
    ///
    /// The `DeleteSnapshot` operation returns instantly. The snapshot appears with
    /// the lifecycle status of `DELETING` until the deletion is complete.
    pub fn deleteSnapshot(self: *Self, allocator: std.mem.Allocator, input: delete_snapshot.DeleteSnapshotInput, options: CallOptions) !delete_snapshot.DeleteSnapshotOutput {
        return delete_snapshot.execute(self, allocator, input, options);
    }

    /// Deletes an existing Amazon FSx for ONTAP storage virtual machine (SVM).
    /// Prior
    /// to deleting an SVM, you must delete all non-root volumes in the SVM,
    /// otherwise the operation will fail.
    pub fn deleteStorageVirtualMachine(self: *Self, allocator: std.mem.Allocator, input: delete_storage_virtual_machine.DeleteStorageVirtualMachineInput, options: CallOptions) !delete_storage_virtual_machine.DeleteStorageVirtualMachineOutput {
        return delete_storage_virtual_machine.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon FSx for NetApp ONTAP or Amazon FSx for OpenZFS
    /// volume.
    pub fn deleteVolume(self: *Self, allocator: std.mem.Allocator, input: delete_volume.DeleteVolumeInput, options: CallOptions) !delete_volume.DeleteVolumeOutput {
        return delete_volume.execute(self, allocator, input, options);
    }

    /// Returns the description of a specific Amazon FSx backup, if a
    /// `BackupIds` value is provided for that backup. Otherwise, it returns all
    /// backups owned by your Amazon Web Services account in the Amazon Web Services
    /// Region of the
    /// endpoint that you're calling.
    ///
    /// When retrieving all backups, you can optionally specify the `MaxResults`
    /// parameter to limit the number of backups in a response. If more backups
    /// remain, Amazon FSx returns a `NextToken` value in the response. In this
    /// case,
    /// send a later request with the `NextToken` request parameter set to the value
    /// of the `NextToken` value from the last response.
    ///
    /// This operation is used in an iterative process to retrieve a list of your
    /// backups.
    /// `DescribeBackups` is called first without a `NextToken` value.
    /// Then the operation continues to be called with the `NextToken` parameter set
    /// to the value of the last `NextToken` value until a response has no
    /// `NextToken` value.
    ///
    /// When using this operation, keep the following in mind:
    ///
    /// * The operation might return fewer than the `MaxResults` value of
    /// backup descriptions while still including a `NextToken`
    /// value.
    ///
    /// * The order of the backups returned in the response of one
    /// `DescribeBackups` call and the order of the backups returned
    /// across the responses of a multi-call iteration is unspecified.
    pub fn describeBackups(self: *Self, allocator: std.mem.Allocator, input: describe_backups.DescribeBackupsInput, options: CallOptions) !describe_backups.DescribeBackupsOutput {
        return describe_backups.execute(self, allocator, input, options);
    }

    /// Returns the description of specific Amazon FSx for Lustre or Amazon File
    /// Cache
    /// data repository associations, if one or more `AssociationIds` values
    /// are provided in the request, or if filters are used in the request. Data
    /// repository
    /// associations are supported on Amazon File Cache resources and all FSx for
    /// Lustre
    /// 2.12 and 2,15 file systems, excluding `scratch_1` deployment type.
    ///
    /// You can use filters to narrow the response to include just data repository
    /// associations for specific file systems (use the `file-system-id` filter with
    /// the ID of the file system) or caches (use the `file-cache-id` filter with
    /// the ID of the cache), or data repository associations for a specific
    /// repository type
    /// (use the `data-repository-type` filter with a value of `S3`
    /// or `NFS`). If you don't use filters, the response returns all data
    /// repository associations owned by your Amazon Web Services account in the
    /// Amazon Web Services Region
    /// of the endpoint that you're calling.
    ///
    /// When retrieving all data repository associations, you can paginate the
    /// response by using
    /// the optional `MaxResults` parameter to limit the number of data repository
    /// associations
    /// returned in a response. If more data repository associations remain, a
    /// `NextToken` value is returned in the response. In this case, send a later
    /// request with the `NextToken` request parameter set to the value of
    /// `NextToken` from the last response.
    pub fn describeDataRepositoryAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_data_repository_associations.DescribeDataRepositoryAssociationsInput, options: CallOptions) !describe_data_repository_associations.DescribeDataRepositoryAssociationsOutput {
        return describe_data_repository_associations.execute(self, allocator, input, options);
    }

    /// Returns the description of specific Amazon FSx for Lustre or Amazon File
    /// Cache data repository tasks, if
    /// one or more `TaskIds` values are provided in the request, or if filters are
    /// used in the request.
    /// You can use filters to narrow the response to include just tasks for
    /// specific file systems or caches,
    /// or tasks in a specific lifecycle state. Otherwise, it returns all data
    /// repository tasks owned
    /// by your Amazon Web Services account in the Amazon Web Services Region of the
    /// endpoint that you're calling.
    ///
    /// When retrieving all tasks, you can paginate the response by using the
    /// optional `MaxResults`
    /// parameter to limit the number of tasks returned in a response. If more tasks
    /// remain,
    /// a `NextToken` value is returned in the response. In this case, send a later
    /// request with the `NextToken` request parameter set to the value of
    /// `NextToken` from the last response.
    pub fn describeDataRepositoryTasks(self: *Self, allocator: std.mem.Allocator, input: describe_data_repository_tasks.DescribeDataRepositoryTasksInput, options: CallOptions) !describe_data_repository_tasks.DescribeDataRepositoryTasksOutput {
        return describe_data_repository_tasks.execute(self, allocator, input, options);
    }

    /// Returns the description of a specific Amazon File Cache resource, if a
    /// `FileCacheIds` value is provided for that cache. Otherwise, it
    /// returns descriptions of all caches owned by your Amazon Web Services account
    /// in the
    /// Amazon Web Services Region of the endpoint that you're calling.
    ///
    /// When retrieving all cache descriptions, you can optionally specify the
    /// `MaxResults` parameter to limit the number of descriptions in a response.
    /// If more cache descriptions remain, the operation returns a
    /// `NextToken` value in the response. In this case, send a later request
    /// with the `NextToken` request parameter set to the value of
    /// `NextToken` from the last response.
    ///
    /// This operation is used in an iterative process to retrieve a list of your
    /// cache
    /// descriptions. `DescribeFileCaches` is called first without a
    /// `NextToken`value. Then the operation continues to be called with the
    /// `NextToken` parameter set to the value of the last `NextToken`
    /// value until a response has no `NextToken`.
    ///
    /// When using this operation, keep the following in mind:
    ///
    /// * The implementation might return fewer than `MaxResults`
    /// cache descriptions while still including a `NextToken`
    /// value.
    ///
    /// * The order of caches returned in the response of one
    /// `DescribeFileCaches` call and the order of caches returned
    /// across the responses of a multicall iteration is unspecified.
    pub fn describeFileCaches(self: *Self, allocator: std.mem.Allocator, input: describe_file_caches.DescribeFileCachesInput, options: CallOptions) !describe_file_caches.DescribeFileCachesOutput {
        return describe_file_caches.execute(self, allocator, input, options);
    }

    /// Returns the DNS aliases that are associated with the specified Amazon FSx
    /// for Windows File Server file system. A history of
    /// all DNS aliases that have been associated with and disassociated from the
    /// file system is available in the list of AdministrativeAction
    /// provided in the DescribeFileSystems operation response.
    pub fn describeFileSystemAliases(self: *Self, allocator: std.mem.Allocator, input: describe_file_system_aliases.DescribeFileSystemAliasesInput, options: CallOptions) !describe_file_system_aliases.DescribeFileSystemAliasesOutput {
        return describe_file_system_aliases.execute(self, allocator, input, options);
    }

    /// Returns the description of specific Amazon FSx file systems, if a
    /// `FileSystemIds` value is provided for that file system. Otherwise, it
    /// returns descriptions of all file systems owned by your Amazon Web Services
    /// account in the
    /// Amazon Web Services Region of the endpoint that you're calling.
    ///
    /// When retrieving all file system descriptions, you can optionally specify the
    /// `MaxResults` parameter to limit the number of descriptions in a response.
    /// If more file system descriptions remain, Amazon FSx returns a
    /// `NextToken` value in the response. In this case, send a later request
    /// with the `NextToken` request parameter set to the value of
    /// `NextToken` from the last response.
    ///
    /// This operation is used in an iterative process to retrieve a list of your
    /// file system
    /// descriptions. `DescribeFileSystems` is called first without a
    /// `NextToken`value. Then the operation continues to be called with the
    /// `NextToken` parameter set to the value of the last `NextToken`
    /// value until a response has no `NextToken`.
    ///
    /// When using this operation, keep the following in mind:
    ///
    /// * The implementation might return fewer than `MaxResults` file
    /// system descriptions while still including a `NextToken`
    /// value.
    ///
    /// * The order of file systems returned in the response of one
    /// `DescribeFileSystems` call and the order of file systems returned
    /// across the responses of a multicall iteration is unspecified.
    pub fn describeFileSystems(self: *Self, allocator: std.mem.Allocator, input: describe_file_systems.DescribeFileSystemsInput, options: CallOptions) !describe_file_systems.DescribeFileSystemsOutput {
        return describe_file_systems.execute(self, allocator, input, options);
    }

    /// Describes one or more S3 access points attached to Amazon FSx volumes.
    ///
    /// The requester requires the following permission to perform this action:
    ///
    /// * `fsx:DescribeS3AccessPointAttachments`
    pub fn describeS3AccessPointAttachments(self: *Self, allocator: std.mem.Allocator, input: describe_s3_access_point_attachments.DescribeS3AccessPointAttachmentsInput, options: CallOptions) !describe_s3_access_point_attachments.DescribeS3AccessPointAttachmentsOutput {
        return describe_s3_access_point_attachments.execute(self, allocator, input, options);
    }

    /// Indicates whether participant accounts in your organization can create
    /// Amazon FSx for NetApp ONTAP Multi-AZ file systems in subnets that are shared
    /// by a virtual
    /// private cloud (VPC) owner. For more information, see [Creating FSx for ONTAP
    /// file systems in shared
    /// subnets](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/creating-file-systems.html#fsxn-vpc-shared-subnets).
    pub fn describeSharedVpcConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_shared_vpc_configuration.DescribeSharedVpcConfigurationInput, options: CallOptions) !describe_shared_vpc_configuration.DescribeSharedVpcConfigurationOutput {
        return describe_shared_vpc_configuration.execute(self, allocator, input, options);
    }

    /// Returns the description of specific Amazon FSx for OpenZFS snapshots, if a
    /// `SnapshotIds` value is provided. Otherwise, this operation returns all
    /// snapshots owned by your Amazon Web Services account in the Amazon Web
    /// Services Region of
    /// the endpoint that you're calling.
    ///
    /// When retrieving all snapshots, you can optionally specify the `MaxResults`
    /// parameter to limit the number of snapshots in a response. If more backups
    /// remain,
    /// Amazon FSx returns a `NextToken` value in the response. In this
    /// case, send a later request with the `NextToken` request parameter set to the
    /// value of `NextToken` from the last response.
    ///
    /// Use this operation in an iterative process to retrieve a list of your
    /// snapshots.
    /// `DescribeSnapshots` is called first without a `NextToken`
    /// value. Then the operation continues to be called with the `NextToken`
    /// parameter set to the value of the last `NextToken` value until a response
    /// has
    /// no `NextToken` value.
    ///
    /// When using this operation, keep the following in mind:
    ///
    /// * The operation might return fewer than the `MaxResults` value of
    /// snapshot descriptions while still including a `NextToken`
    /// value.
    ///
    /// * The order of snapshots returned in the response of one
    /// `DescribeSnapshots` call and the order of backups returned across
    /// the responses of a multi-call iteration is unspecified.
    pub fn describeSnapshots(self: *Self, allocator: std.mem.Allocator, input: describe_snapshots.DescribeSnapshotsInput, options: CallOptions) !describe_snapshots.DescribeSnapshotsOutput {
        return describe_snapshots.execute(self, allocator, input, options);
    }

    /// Describes one or more Amazon FSx for NetApp ONTAP storage virtual machines
    /// (SVMs).
    pub fn describeStorageVirtualMachines(self: *Self, allocator: std.mem.Allocator, input: describe_storage_virtual_machines.DescribeStorageVirtualMachinesInput, options: CallOptions) !describe_storage_virtual_machines.DescribeStorageVirtualMachinesOutput {
        return describe_storage_virtual_machines.execute(self, allocator, input, options);
    }

    /// Describes one or more Amazon FSx for NetApp ONTAP or Amazon FSx for
    /// OpenZFS volumes.
    pub fn describeVolumes(self: *Self, allocator: std.mem.Allocator, input: describe_volumes.DescribeVolumesInput, options: CallOptions) !describe_volumes.DescribeVolumesOutput {
        return describe_volumes.execute(self, allocator, input, options);
    }

    /// Detaches an S3 access point from an Amazon FSx volume and deletes the S3
    /// access point.
    ///
    /// The requester requires the following permission to perform this action:
    ///
    /// * `fsx:DetachAndDeleteS3AccessPoint`
    ///
    /// * `s3:DeleteAccessPoint`
    pub fn detachAndDeleteS3AccessPoint(self: *Self, allocator: std.mem.Allocator, input: detach_and_delete_s3_access_point.DetachAndDeleteS3AccessPointInput, options: CallOptions) !detach_and_delete_s3_access_point.DetachAndDeleteS3AccessPointOutput {
        return detach_and_delete_s3_access_point.execute(self, allocator, input, options);
    }

    /// Use this action to disassociate, or remove, one or more Domain Name Service
    /// (DNS) aliases
    /// from an Amazon FSx for Windows File Server file system. If you attempt to
    /// disassociate a DNS alias that is not
    /// associated with the file system, Amazon FSx responds with an HTTP status
    /// code 400 (Bad Request). For more information, see
    /// [Working with DNS
    /// Aliases](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/managing-dns-aliases.html).
    ///
    /// The system generated response showing the DNS aliases that
    /// Amazon FSx is attempting to disassociate from the file system.
    /// Use the API
    /// operation to monitor the status of the aliases Amazon FSx is
    /// disassociating with the file system.
    pub fn disassociateFileSystemAliases(self: *Self, allocator: std.mem.Allocator, input: disassociate_file_system_aliases.DisassociateFileSystemAliasesInput, options: CallOptions) !disassociate_file_system_aliases.DisassociateFileSystemAliasesOutput {
        return disassociate_file_system_aliases.execute(self, allocator, input, options);
    }

    /// Lists tags for Amazon FSx resources.
    ///
    /// When retrieving all tags, you can optionally specify the `MaxResults`
    /// parameter to limit the number of tags in a response. If more tags remain,
    /// Amazon FSx
    /// returns a `NextToken` value in the response. In this case, send a later
    /// request with the `NextToken` request parameter set to the value of
    /// `NextToken` from the last response.
    ///
    /// This action is used in an iterative process to retrieve a list of your tags.
    /// `ListTagsForResource` is called first without a
    /// `NextToken`value. Then the action continues to be called with the
    /// `NextToken` parameter set to the value of the last `NextToken`
    /// value until a response has no `NextToken`.
    ///
    /// When using this action, keep the following in mind:
    ///
    /// * The implementation might return fewer than `MaxResults` file
    /// system descriptions while still including a `NextToken`
    /// value.
    ///
    /// * The order of tags returned in the response of one
    /// `ListTagsForResource` call and the order of tags returned across
    /// the responses of a multi-call iteration is unspecified.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Releases the file system lock from an Amazon FSx for OpenZFS file
    /// system.
    pub fn releaseFileSystemNfsV3Locks(self: *Self, allocator: std.mem.Allocator, input: release_file_system_nfs_v3_locks.ReleaseFileSystemNfsV3LocksInput, options: CallOptions) !release_file_system_nfs_v3_locks.ReleaseFileSystemNfsV3LocksOutput {
        return release_file_system_nfs_v3_locks.execute(self, allocator, input, options);
    }

    /// Returns an Amazon FSx for OpenZFS volume to the state saved by the specified
    /// snapshot.
    pub fn restoreVolumeFromSnapshot(self: *Self, allocator: std.mem.Allocator, input: restore_volume_from_snapshot.RestoreVolumeFromSnapshotInput, options: CallOptions) !restore_volume_from_snapshot.RestoreVolumeFromSnapshotOutput {
        return restore_volume_from_snapshot.execute(self, allocator, input, options);
    }

    /// After performing steps to repair the Active Directory configuration of an
    /// FSx for Windows File Server file system, use this action to
    /// initiate the process of Amazon FSx attempting to reconnect to the file
    /// system.
    pub fn startMisconfiguredStateRecovery(self: *Self, allocator: std.mem.Allocator, input: start_misconfigured_state_recovery.StartMisconfiguredStateRecoveryInput, options: CallOptions) !start_misconfigured_state_recovery.StartMisconfiguredStateRecoveryOutput {
        return start_misconfigured_state_recovery.execute(self, allocator, input, options);
    }

    /// Tags an Amazon FSx resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// This action removes a tag from an Amazon FSx resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing data repository association
    /// on an Amazon FSx for Lustre file system. Data repository associations
    /// are supported on all FSx for Lustre 2.12 and 2.15 file systems,
    /// excluding `scratch_1` deployment type.
    pub fn updateDataRepositoryAssociation(self: *Self, allocator: std.mem.Allocator, input: update_data_repository_association.UpdateDataRepositoryAssociationInput, options: CallOptions) !update_data_repository_association.UpdateDataRepositoryAssociationOutput {
        return update_data_repository_association.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing Amazon File Cache resource.
    /// You can update multiple properties in a single request.
    pub fn updateFileCache(self: *Self, allocator: std.mem.Allocator, input: update_file_cache.UpdateFileCacheInput, options: CallOptions) !update_file_cache.UpdateFileCacheOutput {
        return update_file_cache.execute(self, allocator, input, options);
    }

    /// Use this operation to update the configuration of an existing Amazon FSx
    /// file
    /// system. You can update multiple properties in a single request.
    ///
    /// For FSx for Windows File Server file systems, you can update the following
    /// properties:
    ///
    /// * `AuditLogConfiguration`
    ///
    /// * `AutomaticBackupRetentionDays`
    ///
    /// * `DailyAutomaticBackupStartTime`
    ///
    /// * `DiskIopsConfiguration`
    ///
    /// * `SelfManagedActiveDirectoryConfiguration`
    ///
    /// * `StorageCapacity`
    ///
    /// * `StorageType`
    ///
    /// * `ThroughputCapacity`
    ///
    /// * `WeeklyMaintenanceStartTime`
    ///
    /// For FSx for Lustre file systems, you can update the following
    /// properties:
    ///
    /// * `AutoImportPolicy`
    ///
    /// * `AutomaticBackupRetentionDays`
    ///
    /// * `DailyAutomaticBackupStartTime`
    ///
    /// * `DataCompressionType`
    ///
    /// * `FileSystemTypeVersion`
    ///
    /// * `LogConfiguration`
    ///
    /// * `LustreReadCacheConfiguration`
    ///
    /// * `LustreRootSquashConfiguration`
    ///
    /// * `MetadataConfiguration`
    ///
    /// * `PerUnitStorageThroughput`
    ///
    /// * `StorageCapacity`
    ///
    /// * `ThroughputCapacity`
    ///
    /// * `WeeklyMaintenanceStartTime`
    ///
    /// For FSx for ONTAP file systems, you can update the following
    /// properties:
    ///
    /// * `AddRouteTableIds`
    ///
    /// * `AutomaticBackupRetentionDays`
    ///
    /// * `DailyAutomaticBackupStartTime`
    ///
    /// * `DiskIopsConfiguration`
    ///
    /// * `EndpointIpv6AddressRange`
    ///
    /// * `FsxAdminPassword`
    ///
    /// * `HAPairs`
    ///
    /// * `RemoveRouteTableIds`
    ///
    /// * `StorageCapacity`
    ///
    /// * `ThroughputCapacity`
    ///
    /// * `ThroughputCapacityPerHAPair`
    ///
    /// * `WeeklyMaintenanceStartTime`
    ///
    /// For FSx for OpenZFS file systems, you can update the following
    /// properties:
    ///
    /// * `AddRouteTableIds`
    ///
    /// * `AutomaticBackupRetentionDays`
    ///
    /// * `CopyTagsToBackups`
    ///
    /// * `CopyTagsToVolumes`
    ///
    /// * `DailyAutomaticBackupStartTime`
    ///
    /// * `DiskIopsConfiguration`
    ///
    /// * `EndpointIpv6AddressRange`
    ///
    /// * `ReadCacheConfiguration`
    ///
    /// * `RemoveRouteTableIds`
    ///
    /// * `StorageCapacity`
    ///
    /// * `ThroughputCapacity`
    ///
    /// * `WeeklyMaintenanceStartTime`
    pub fn updateFileSystem(self: *Self, allocator: std.mem.Allocator, input: update_file_system.UpdateFileSystemInput, options: CallOptions) !update_file_system.UpdateFileSystemOutput {
        return update_file_system.execute(self, allocator, input, options);
    }

    /// Configures whether participant accounts in your organization can create
    /// Amazon FSx for NetApp ONTAP Multi-AZ file systems in subnets that are shared
    /// by a virtual
    /// private cloud (VPC) owner. For more information, see the [Amazon FSx for
    /// NetApp ONTAP User
    /// Guide](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/maz-shared-vpc.html).
    ///
    /// We strongly recommend that participant-created Multi-AZ file systems in the
    /// shared
    /// VPC are deleted before you disable this feature. Once the feature is
    /// disabled, these
    /// file systems will enter a `MISCONFIGURED` state and behave like Single-AZ
    /// file systems. For more information, see [Important considerations before
    /// disabling shared VPC support for Multi-AZ file
    /// systems](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/maz-shared-vpc.html#disabling-maz-vpc-sharing).
    pub fn updateSharedVpcConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_shared_vpc_configuration.UpdateSharedVpcConfigurationInput, options: CallOptions) !update_shared_vpc_configuration.UpdateSharedVpcConfigurationOutput {
        return update_shared_vpc_configuration.execute(self, allocator, input, options);
    }

    /// Updates the name of an Amazon FSx for OpenZFS snapshot.
    pub fn updateSnapshot(self: *Self, allocator: std.mem.Allocator, input: update_snapshot.UpdateSnapshotInput, options: CallOptions) !update_snapshot.UpdateSnapshotOutput {
        return update_snapshot.execute(self, allocator, input, options);
    }

    /// Updates an FSx for ONTAP storage virtual machine (SVM).
    pub fn updateStorageVirtualMachine(self: *Self, allocator: std.mem.Allocator, input: update_storage_virtual_machine.UpdateStorageVirtualMachineInput, options: CallOptions) !update_storage_virtual_machine.UpdateStorageVirtualMachineOutput {
        return update_storage_virtual_machine.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an Amazon FSx for NetApp ONTAP or Amazon FSx
    /// for OpenZFS volume.
    pub fn updateVolume(self: *Self, allocator: std.mem.Allocator, input: update_volume.UpdateVolumeInput, options: CallOptions) !update_volume.UpdateVolumeOutput {
        return update_volume.execute(self, allocator, input, options);
    }

    pub fn describeBackupsPaginator(self: *Self, params: describe_backups.DescribeBackupsInput) paginator.DescribeBackupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDataRepositoryAssociationsPaginator(self: *Self, params: describe_data_repository_associations.DescribeDataRepositoryAssociationsInput) paginator.DescribeDataRepositoryAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDataRepositoryTasksPaginator(self: *Self, params: describe_data_repository_tasks.DescribeDataRepositoryTasksInput) paginator.DescribeDataRepositoryTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeFileCachesPaginator(self: *Self, params: describe_file_caches.DescribeFileCachesInput) paginator.DescribeFileCachesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeFileSystemAliasesPaginator(self: *Self, params: describe_file_system_aliases.DescribeFileSystemAliasesInput) paginator.DescribeFileSystemAliasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeFileSystemsPaginator(self: *Self, params: describe_file_systems.DescribeFileSystemsInput) paginator.DescribeFileSystemsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeS3AccessPointAttachmentsPaginator(self: *Self, params: describe_s3_access_point_attachments.DescribeS3AccessPointAttachmentsInput) paginator.DescribeS3AccessPointAttachmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSnapshotsPaginator(self: *Self, params: describe_snapshots.DescribeSnapshotsInput) paginator.DescribeSnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeStorageVirtualMachinesPaginator(self: *Self, params: describe_storage_virtual_machines.DescribeStorageVirtualMachinesInput) paginator.DescribeStorageVirtualMachinesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVolumesPaginator(self: *Self, params: describe_volumes.DescribeVolumesInput) paginator.DescribeVolumesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
