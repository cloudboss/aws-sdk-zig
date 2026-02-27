const aws = @import("aws");
const std = @import("std");

const activate_gateway = @import("activate_gateway.zig");
const add_cache = @import("add_cache.zig");
const add_tags_to_resource = @import("add_tags_to_resource.zig");
const add_upload_buffer = @import("add_upload_buffer.zig");
const add_working_storage = @import("add_working_storage.zig");
const assign_tape_pool = @import("assign_tape_pool.zig");
const associate_file_system = @import("associate_file_system.zig");
const attach_volume = @import("attach_volume.zig");
const cancel_archival = @import("cancel_archival.zig");
const cancel_cache_report = @import("cancel_cache_report.zig");
const cancel_retrieval = @import("cancel_retrieval.zig");
const create_cachedi_scsi_volume = @import("create_cachedi_scsi_volume.zig");
const create_nfs_file_share = @import("create_nfs_file_share.zig");
const create_smb_file_share = @import("create_smb_file_share.zig");
const create_snapshot = @import("create_snapshot.zig");
const create_snapshot_from_volume_recovery_point = @import("create_snapshot_from_volume_recovery_point.zig");
const create_storedi_scsi_volume = @import("create_storedi_scsi_volume.zig");
const create_tape_pool = @import("create_tape_pool.zig");
const create_tape_with_barcode = @import("create_tape_with_barcode.zig");
const create_tapes = @import("create_tapes.zig");
const delete_automatic_tape_creation_policy = @import("delete_automatic_tape_creation_policy.zig");
const delete_bandwidth_rate_limit = @import("delete_bandwidth_rate_limit.zig");
const delete_cache_report = @import("delete_cache_report.zig");
const delete_chap_credentials = @import("delete_chap_credentials.zig");
const delete_file_share = @import("delete_file_share.zig");
const delete_gateway = @import("delete_gateway.zig");
const delete_snapshot_schedule = @import("delete_snapshot_schedule.zig");
const delete_tape = @import("delete_tape.zig");
const delete_tape_archive = @import("delete_tape_archive.zig");
const delete_tape_pool = @import("delete_tape_pool.zig");
const delete_volume = @import("delete_volume.zig");
const describe_availability_monitor_test = @import("describe_availability_monitor_test.zig");
const describe_bandwidth_rate_limit = @import("describe_bandwidth_rate_limit.zig");
const describe_bandwidth_rate_limit_schedule = @import("describe_bandwidth_rate_limit_schedule.zig");
const describe_cache = @import("describe_cache.zig");
const describe_cache_report = @import("describe_cache_report.zig");
const describe_cachedi_scsi_volumes = @import("describe_cachedi_scsi_volumes.zig");
const describe_chap_credentials = @import("describe_chap_credentials.zig");
const describe_file_system_associations = @import("describe_file_system_associations.zig");
const describe_gateway_information = @import("describe_gateway_information.zig");
const describe_maintenance_start_time = @import("describe_maintenance_start_time.zig");
const describe_nfs_file_shares = @import("describe_nfs_file_shares.zig");
const describe_smb_file_shares = @import("describe_smb_file_shares.zig");
const describe_smb_settings = @import("describe_smb_settings.zig");
const describe_snapshot_schedule = @import("describe_snapshot_schedule.zig");
const describe_storedi_scsi_volumes = @import("describe_storedi_scsi_volumes.zig");
const describe_tape_archives = @import("describe_tape_archives.zig");
const describe_tape_recovery_points = @import("describe_tape_recovery_points.zig");
const describe_tapes = @import("describe_tapes.zig");
const describe_upload_buffer = @import("describe_upload_buffer.zig");
const describe_vtl_devices = @import("describe_vtl_devices.zig");
const describe_working_storage = @import("describe_working_storage.zig");
const detach_volume = @import("detach_volume.zig");
const disable_gateway = @import("disable_gateway.zig");
const disassociate_file_system = @import("disassociate_file_system.zig");
const evict_files_failing_upload = @import("evict_files_failing_upload.zig");
const join_domain = @import("join_domain.zig");
const list_automatic_tape_creation_policies = @import("list_automatic_tape_creation_policies.zig");
const list_cache_reports = @import("list_cache_reports.zig");
const list_file_shares = @import("list_file_shares.zig");
const list_file_system_associations = @import("list_file_system_associations.zig");
const list_gateways = @import("list_gateways.zig");
const list_local_disks = @import("list_local_disks.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_tape_pools = @import("list_tape_pools.zig");
const list_tapes = @import("list_tapes.zig");
const list_volume_initiators = @import("list_volume_initiators.zig");
const list_volume_recovery_points = @import("list_volume_recovery_points.zig");
const list_volumes = @import("list_volumes.zig");
const notify_when_uploaded = @import("notify_when_uploaded.zig");
const refresh_cache = @import("refresh_cache.zig");
const remove_tags_from_resource = @import("remove_tags_from_resource.zig");
const reset_cache = @import("reset_cache.zig");
const retrieve_tape_archive = @import("retrieve_tape_archive.zig");
const retrieve_tape_recovery_point = @import("retrieve_tape_recovery_point.zig");
const set_local_console_password = @import("set_local_console_password.zig");
const set_smb_guest_password = @import("set_smb_guest_password.zig");
const shutdown_gateway = @import("shutdown_gateway.zig");
const start_availability_monitor_test = @import("start_availability_monitor_test.zig");
const start_cache_report = @import("start_cache_report.zig");
const start_gateway = @import("start_gateway.zig");
const update_automatic_tape_creation_policy = @import("update_automatic_tape_creation_policy.zig");
const update_bandwidth_rate_limit = @import("update_bandwidth_rate_limit.zig");
const update_bandwidth_rate_limit_schedule = @import("update_bandwidth_rate_limit_schedule.zig");
const update_chap_credentials = @import("update_chap_credentials.zig");
const update_file_system_association = @import("update_file_system_association.zig");
const update_gateway_information = @import("update_gateway_information.zig");
const update_gateway_software_now = @import("update_gateway_software_now.zig");
const update_maintenance_start_time = @import("update_maintenance_start_time.zig");
const update_nfs_file_share = @import("update_nfs_file_share.zig");
const update_smb_file_share = @import("update_smb_file_share.zig");
const update_smb_file_share_visibility = @import("update_smb_file_share_visibility.zig");
const update_smb_local_groups = @import("update_smb_local_groups.zig");
const update_smb_security_strategy = @import("update_smb_security_strategy.zig");
const update_snapshot_schedule = @import("update_snapshot_schedule.zig");
const update_vtl_device_type = @import("update_vtl_device_type.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Storage Gateway";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Activates the gateway you previously deployed on your host. In the
    /// activation process,
    /// you specify information such as the Amazon Web Services Region that you want
    /// to use for
    /// storing snapshots or tapes, the time zone for scheduled snapshots the
    /// gateway snapshot
    /// schedule window, an activation key, and a name for your gateway. The
    /// activation process
    /// also associates your gateway with your account. For more information, see
    /// UpdateGatewayInformation.
    ///
    /// You must turn on the gateway VM before you can activate your gateway.
    pub fn activateGateway(self: *Self, allocator: std.mem.Allocator, input: activate_gateway.ActivateGatewayInput, options: activate_gateway.Options) !activate_gateway.ActivateGatewayOutput {
        return activate_gateway.execute(self, allocator, input, options);
    }

    /// Configures one or more gateway local disks as cache for a gateway. This
    /// operation is
    /// only supported in the cached volume, tape, and file gateway type (see [How
    /// Storage Gateway works
    /// (architecture)](https://docs.aws.amazon.com/storagegateway/latest/userguide/StorageGatewayConcepts.html).
    ///
    /// In the request, you specify the gateway Amazon Resource Name (ARN) to which
    /// you want to
    /// add cache, and one or more disk IDs that you want to configure as cache.
    pub fn addCache(self: *Self, allocator: std.mem.Allocator, input: add_cache.AddCacheInput, options: add_cache.Options) !add_cache.AddCacheOutput {
        return add_cache.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to the specified resource. You use tags to add
    /// metadata to
    /// resources, which you can use to categorize these resources. For example, you
    /// can categorize
    /// resources by purpose, owner, environment, or team. Each tag consists of a
    /// key and a value,
    /// which you define. You can add tags to the following Storage Gateway
    /// resources:
    ///
    /// * Storage gateways of all types
    ///
    /// * Storage volumes
    ///
    /// * Virtual tapes
    ///
    /// * NFS and SMB file shares
    ///
    /// * File System associations
    ///
    /// You can create a maximum of 50 tags for each resource. Virtual tapes and
    /// storage volumes
    /// that are recovered to a new gateway maintain their tags.
    pub fn addTagsToResource(self: *Self, allocator: std.mem.Allocator, input: add_tags_to_resource.AddTagsToResourceInput, options: add_tags_to_resource.Options) !add_tags_to_resource.AddTagsToResourceOutput {
        return add_tags_to_resource.execute(self, allocator, input, options);
    }

    /// Configures one or more gateway local disks as upload buffer for a specified
    /// gateway.
    /// This operation is supported for the stored volume, cached volume, and tape
    /// gateway
    /// types.
    ///
    /// In the request, you specify the gateway Amazon Resource Name (ARN) to which
    /// you want to
    /// add upload buffer, and one or more disk IDs that you want to configure as
    /// upload
    /// buffer.
    pub fn addUploadBuffer(self: *Self, allocator: std.mem.Allocator, input: add_upload_buffer.AddUploadBufferInput, options: add_upload_buffer.Options) !add_upload_buffer.AddUploadBufferOutput {
        return add_upload_buffer.execute(self, allocator, input, options);
    }

    /// Configures one or more gateway local disks as working storage for a gateway.
    /// This
    /// operation is only supported in the stored volume gateway type. This
    /// operation is deprecated
    /// in cached volume API version 20120630. Use AddUploadBuffer
    /// instead.
    ///
    /// Working storage is also referred to as upload buffer. You can also use the
    /// AddUploadBuffer operation to add upload buffer to a stored volume
    /// gateway.
    ///
    /// In the request, you specify the gateway Amazon Resource Name (ARN) to which
    /// you want to
    /// add working storage, and one or more disk IDs that you want to configure as
    /// working
    /// storage.
    pub fn addWorkingStorage(self: *Self, allocator: std.mem.Allocator, input: add_working_storage.AddWorkingStorageInput, options: add_working_storage.Options) !add_working_storage.AddWorkingStorageOutput {
        return add_working_storage.execute(self, allocator, input, options);
    }

    /// Assigns a tape to a tape pool for archiving. The tape assigned to a pool is
    /// archived in
    /// the S3 storage class that is associated with the pool. When you use your
    /// backup application
    /// to eject the tape, the tape is archived directly into the S3 storage class
    /// (S3 Glacier or
    /// S3 Glacier Deep Archive) that corresponds to the pool.
    pub fn assignTapePool(self: *Self, allocator: std.mem.Allocator, input: assign_tape_pool.AssignTapePoolInput, options: assign_tape_pool.Options) !assign_tape_pool.AssignTapePoolOutput {
        return assign_tape_pool.execute(self, allocator, input, options);
    }

    /// Associate an Amazon FSx file system with the FSx File Gateway. After the
    /// association process is complete, the file shares on the Amazon FSx file
    /// system are
    /// available for access through the gateway. This operation only supports the
    /// FSx File Gateway
    /// type.
    pub fn associateFileSystem(self: *Self, allocator: std.mem.Allocator, input: associate_file_system.AssociateFileSystemInput, options: associate_file_system.Options) !associate_file_system.AssociateFileSystemOutput {
        return associate_file_system.execute(self, allocator, input, options);
    }

    /// Connects a volume to an iSCSI connection and then attaches the volume to the
    /// specified
    /// gateway. Detaching and attaching a volume enables you to recover your data
    /// from one gateway
    /// to a different gateway without creating a snapshot. It also makes it easier
    /// to move your
    /// volumes from an on-premises gateway to a gateway hosted on an Amazon EC2
    /// instance.
    pub fn attachVolume(self: *Self, allocator: std.mem.Allocator, input: attach_volume.AttachVolumeInput, options: attach_volume.Options) !attach_volume.AttachVolumeOutput {
        return attach_volume.execute(self, allocator, input, options);
    }

    /// Cancels archiving of a virtual tape to the virtual tape shelf (VTS) after
    /// the archiving
    /// process is initiated. This operation is only supported in the tape gateway
    /// type.
    pub fn cancelArchival(self: *Self, allocator: std.mem.Allocator, input: cancel_archival.CancelArchivalInput, options: cancel_archival.Options) !cancel_archival.CancelArchivalOutput {
        return cancel_archival.execute(self, allocator, input, options);
    }

    /// Cancels generation of a specified cache report. You can use this operation
    /// to manually
    /// cancel an IN-PROGRESS report for any reason. This action changes the report
    /// status from
    /// IN-PROGRESS to CANCELLED. You can only cancel in-progress reports. If the
    /// the report you
    /// attempt to cancel is in FAILED, ERROR, or COMPLETED state, the cancel
    /// operation returns an
    /// error.
    pub fn cancelCacheReport(self: *Self, allocator: std.mem.Allocator, input: cancel_cache_report.CancelCacheReportInput, options: cancel_cache_report.Options) !cancel_cache_report.CancelCacheReportOutput {
        return cancel_cache_report.execute(self, allocator, input, options);
    }

    /// Cancels retrieval of a virtual tape from the virtual tape shelf (VTS) to a
    /// gateway after
    /// the retrieval process is initiated. The virtual tape is returned to the VTS.
    /// This operation
    /// is only supported in the tape gateway type.
    pub fn cancelRetrieval(self: *Self, allocator: std.mem.Allocator, input: cancel_retrieval.CancelRetrievalInput, options: cancel_retrieval.Options) !cancel_retrieval.CancelRetrievalOutput {
        return cancel_retrieval.execute(self, allocator, input, options);
    }

    /// Creates a cached volume on a specified cached volume gateway. This operation
    /// is only
    /// supported in the cached volume gateway type.
    ///
    /// Cache storage must be allocated to the gateway before you can create a
    /// cached volume.
    /// Use the AddCache operation to add cache storage to a gateway.
    ///
    /// In the request, you must specify the gateway, size of the volume in bytes,
    /// the iSCSI
    /// target name, an IP address on which to expose the target, and a unique
    /// client token. In
    /// response, the gateway creates the volume and returns information about it.
    /// This information
    /// includes the volume Amazon Resource Name (ARN), its size, and the iSCSI
    /// target ARN that
    /// initiators can use to connect to the volume target.
    ///
    /// Optionally, you can provide the ARN for an existing volume as the
    /// `SourceVolumeARN` for this cached volume, which creates an exact copy of the
    /// existing volume’s latest recovery point. The `VolumeSizeInBytes` value must
    /// be
    /// equal to or larger than the size of the copied volume, in bytes.
    pub fn createCachediScsiVolume(self: *Self, allocator: std.mem.Allocator, input: create_cachedi_scsi_volume.CreateCachediSCSIVolumeInput, options: create_cachedi_scsi_volume.Options) !create_cachedi_scsi_volume.CreateCachediSCSIVolumeOutput {
        return create_cachedi_scsi_volume.execute(self, allocator, input, options);
    }

    /// Creates a Network File System (NFS) file share on an existing S3 File
    /// Gateway. In
    /// Storage Gateway, a file share is a file system mount point backed by Amazon
    /// S3
    /// cloud storage. Storage Gateway exposes file shares using an NFS interface.
    /// This operation
    /// is only supported for S3 File Gateways.
    ///
    /// S3 File gateway requires Security Token Service (Amazon Web Services STS) to
    /// be
    /// activated to enable you to create a file share. Make sure Amazon Web
    /// Services STS is
    /// activated in the Amazon Web Services Region you are creating your S3 File
    /// Gateway in. If
    /// Amazon Web Services STS is not activated in the Amazon Web Services Region,
    /// activate
    /// it. For information about how to activate Amazon Web Services STS, see
    /// [Activating and
    /// deactivating Amazon Web Services STS in an Amazon Web Services
    /// Region](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_enable-regions.html) in the
    /// *Identity and Access Management User Guide*.
    ///
    /// S3 File Gateways do not support creating hard or symbolic links on a file
    /// share.
    pub fn createNfsFileShare(self: *Self, allocator: std.mem.Allocator, input: create_nfs_file_share.CreateNFSFileShareInput, options: create_nfs_file_share.Options) !create_nfs_file_share.CreateNFSFileShareOutput {
        return create_nfs_file_share.execute(self, allocator, input, options);
    }

    /// Creates a Server Message Block (SMB) file share on an existing S3 File
    /// Gateway. In
    /// Storage Gateway, a file share is a file system mount point backed by Amazon
    /// S3
    /// cloud storage. Storage Gateway exposes file shares using an SMB interface.
    /// This operation
    /// is only supported for S3 File Gateways.
    ///
    /// S3 File Gateways require Security Token Service (Amazon Web Services STS) to
    /// be
    /// activated to enable you to create a file share. Make sure that Amazon Web
    /// Services STS
    /// is activated in the Amazon Web Services Region you are creating your S3 File
    /// Gateway in.
    /// If Amazon Web Services STS is not activated in this Amazon Web Services
    /// Region, activate
    /// it. For information about how to activate Amazon Web Services STS, see
    /// [Activating and
    /// deactivating Amazon Web Services STS in an Amazon Web Services
    /// Region](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_enable-regions.html) in the
    /// *Identity and Access Management User Guide*.
    ///
    /// File gateways don't support creating hard or symbolic links on a file
    /// share.
    pub fn createSmbFileShare(self: *Self, allocator: std.mem.Allocator, input: create_smb_file_share.CreateSMBFileShareInput, options: create_smb_file_share.Options) !create_smb_file_share.CreateSMBFileShareOutput {
        return create_smb_file_share.execute(self, allocator, input, options);
    }

    /// Initiates a snapshot of a volume.
    ///
    /// Storage Gateway provides the ability to back up point-in-time snapshots of
    /// your
    /// data to Amazon Simple Storage (Amazon S3) for durable off-site recovery, and
    /// also
    /// import the data to an Amazon Elastic Block Store (EBS) volume in Amazon
    /// Elastic Compute
    /// Cloud (EC2). You can take snapshots of your gateway volume on a scheduled or
    /// ad hoc basis.
    /// This API enables you to take an ad hoc snapshot. For more information, see
    /// [Editing a
    /// snapshot
    /// schedule](https://docs.aws.amazon.com/storagegateway/latest/userguide/managing-volumes.html#SchedulingSnapshot).
    ///
    /// In the `CreateSnapshot` request, you identify the volume by providing its
    /// Amazon Resource Name (ARN). You must also provide description for the
    /// snapshot. When
    /// Storage Gateway takes the snapshot of specified volume, the snapshot and
    /// description appears in the Storage Gateway console. In response, Storage
    /// Gateway
    /// returns you a snapshot ID. You can use this snapshot ID to check the
    /// snapshot progress or
    /// later use it when you want to create a volume from a snapshot. This
    /// operation is only
    /// supported in stored and cached volume gateway type.
    ///
    /// To list or delete a snapshot, you must use the Amazon EC2 API. For more
    /// information,
    /// see
    /// [DescribeSnapshots](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeSnapshots.html)
    /// or
    /// [DeleteSnapshot](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DeleteSnapshot.html) in the *Amazon Elastic Compute Cloud API
    /// Reference*.
    ///
    /// Volume and snapshot IDs are changing to a longer length ID format. For more
    /// information, see the important note on the
    /// [Welcome](https://docs.aws.amazon.com/storagegateway/latest/APIReference/Welcome.html) page.
    pub fn createSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_snapshot.CreateSnapshotInput, options: create_snapshot.Options) !create_snapshot.CreateSnapshotOutput {
        return create_snapshot.execute(self, allocator, input, options);
    }

    /// Initiates a snapshot of a gateway from a volume recovery point. This
    /// operation is only
    /// supported in the cached volume gateway type.
    ///
    /// A volume recovery point is a point in time at which all data of the volume
    /// is consistent
    /// and from which you can create a snapshot. To get a list of volume recovery
    /// point for cached
    /// volume gateway, use ListVolumeRecoveryPoints.
    ///
    /// In the `CreateSnapshotFromVolumeRecoveryPoint` request, you identify the
    /// volume by providing its Amazon Resource Name (ARN). You must also provide a
    /// description for
    /// the snapshot. When the gateway takes a snapshot of the specified volume, the
    /// snapshot and
    /// its description appear in the Storage Gateway console.
    /// In response, the gateway returns
    /// you a snapshot ID. You can use this snapshot ID to check the snapshot
    /// progress or later use
    /// it when you want to create a volume from a snapshot.
    ///
    /// To list or delete a snapshot, you must use the Amazon EC2 API. For more
    /// information,
    /// see
    /// [DescribeSnapshots](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeSnapshots.html)
    /// or
    /// [DeleteSnapshot](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DeleteSnapshot.html) in the *Amazon Elastic Compute Cloud API
    /// Reference*.
    pub fn createSnapshotFromVolumeRecoveryPoint(self: *Self, allocator: std.mem.Allocator, input: create_snapshot_from_volume_recovery_point.CreateSnapshotFromVolumeRecoveryPointInput, options: create_snapshot_from_volume_recovery_point.Options) !create_snapshot_from_volume_recovery_point.CreateSnapshotFromVolumeRecoveryPointOutput {
        return create_snapshot_from_volume_recovery_point.execute(self, allocator, input, options);
    }

    /// Creates a volume on a specified gateway. This operation is only supported in
    /// the stored
    /// volume gateway type.
    ///
    /// The size of the volume to create is inferred from the disk size. You can
    /// choose to
    /// preserve existing data on the disk, create volume from an existing snapshot,
    /// or create an
    /// empty volume. If you choose to create an empty gateway volume, then any
    /// existing data on
    /// the disk is erased.
    ///
    /// In the request, you must specify the gateway and the disk information on
    /// which you are
    /// creating the volume. In response, the gateway creates the volume and returns
    /// volume
    /// information such as the volume Amazon Resource Name (ARN), its size, and the
    /// iSCSI target
    /// ARN that initiators can use to connect to the volume target.
    pub fn createStorediScsiVolume(self: *Self, allocator: std.mem.Allocator, input: create_storedi_scsi_volume.CreateStorediSCSIVolumeInput, options: create_storedi_scsi_volume.Options) !create_storedi_scsi_volume.CreateStorediSCSIVolumeOutput {
        return create_storedi_scsi_volume.execute(self, allocator, input, options);
    }

    /// Creates a new custom tape pool. You can use custom tape pool to enable tape
    /// retention
    /// lock on tapes that are archived in the custom pool.
    pub fn createTapePool(self: *Self, allocator: std.mem.Allocator, input: create_tape_pool.CreateTapePoolInput, options: create_tape_pool.Options) !create_tape_pool.CreateTapePoolOutput {
        return create_tape_pool.execute(self, allocator, input, options);
    }

    /// Creates a virtual tape by using your own barcode. You write data to the
    /// virtual tape and
    /// then archive the tape. A barcode is unique and cannot be reused if it has
    /// already been used
    /// on a tape. This applies to barcodes used on deleted tapes. This operation is
    /// only supported
    /// in the tape gateway type.
    ///
    /// Cache storage must be allocated to the gateway before you can create a
    /// virtual tape.
    /// Use the AddCache operation to add cache storage to a gateway.
    pub fn createTapeWithBarcode(self: *Self, allocator: std.mem.Allocator, input: create_tape_with_barcode.CreateTapeWithBarcodeInput, options: create_tape_with_barcode.Options) !create_tape_with_barcode.CreateTapeWithBarcodeOutput {
        return create_tape_with_barcode.execute(self, allocator, input, options);
    }

    /// Creates one or more virtual tapes. You write data to the virtual tapes and
    /// then archive
    /// the tapes. This operation is only supported in the tape gateway type.
    ///
    /// Cache storage must be allocated to the gateway before you can create virtual
    /// tapes.
    /// Use the AddCache operation to add cache storage to a gateway.
    pub fn createTapes(self: *Self, allocator: std.mem.Allocator, input: create_tapes.CreateTapesInput, options: create_tapes.Options) !create_tapes.CreateTapesOutput {
        return create_tapes.execute(self, allocator, input, options);
    }

    /// Deletes the automatic tape creation policy of a gateway. If you delete this
    /// policy, new
    /// virtual tapes must be created manually. Use the Amazon Resource Name (ARN)
    /// of the gateway
    /// in your request to remove the policy.
    pub fn deleteAutomaticTapeCreationPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_automatic_tape_creation_policy.DeleteAutomaticTapeCreationPolicyInput, options: delete_automatic_tape_creation_policy.Options) !delete_automatic_tape_creation_policy.DeleteAutomaticTapeCreationPolicyOutput {
        return delete_automatic_tape_creation_policy.execute(self, allocator, input, options);
    }

    /// Deletes the bandwidth rate limits of a gateway. You can delete either the
    /// upload and
    /// download bandwidth rate limit, or you can delete both. If you delete only
    /// one of the
    /// limits, the other limit remains unchanged. To specify which gateway to work
    /// with, use the
    /// Amazon Resource Name (ARN) of the gateway in your request. This operation is
    /// supported only
    /// for the stored volume, cached volume, and tape gateway types.
    pub fn deleteBandwidthRateLimit(self: *Self, allocator: std.mem.Allocator, input: delete_bandwidth_rate_limit.DeleteBandwidthRateLimitInput, options: delete_bandwidth_rate_limit.Options) !delete_bandwidth_rate_limit.DeleteBandwidthRateLimitOutput {
        return delete_bandwidth_rate_limit.execute(self, allocator, input, options);
    }

    /// Deletes the specified cache report and any associated tags from the Storage
    /// Gateway database. You can only delete completed reports. If the status of
    /// the
    /// report you attempt to delete still IN-PROGRESS, the delete operation returns
    /// an error. You
    /// can use `CancelCacheReport` to cancel an IN-PROGRESS report.
    ///
    /// `DeleteCacheReport` does not delete the report object from your Amazon S3
    /// bucket.
    pub fn deleteCacheReport(self: *Self, allocator: std.mem.Allocator, input: delete_cache_report.DeleteCacheReportInput, options: delete_cache_report.Options) !delete_cache_report.DeleteCacheReportOutput {
        return delete_cache_report.execute(self, allocator, input, options);
    }

    /// Deletes Challenge-Handshake Authentication Protocol (CHAP) credentials for a
    /// specified
    /// iSCSI target and initiator pair. This operation is supported in volume and
    /// tape gateway
    /// types.
    pub fn deleteChapCredentials(self: *Self, allocator: std.mem.Allocator, input: delete_chap_credentials.DeleteChapCredentialsInput, options: delete_chap_credentials.Options) !delete_chap_credentials.DeleteChapCredentialsOutput {
        return delete_chap_credentials.execute(self, allocator, input, options);
    }

    /// Deletes a file share from an S3 File Gateway. This operation is only
    /// supported for S3
    /// File Gateways.
    pub fn deleteFileShare(self: *Self, allocator: std.mem.Allocator, input: delete_file_share.DeleteFileShareInput, options: delete_file_share.Options) !delete_file_share.DeleteFileShareOutput {
        return delete_file_share.execute(self, allocator, input, options);
    }

    /// Deletes a gateway. To specify which gateway to delete, use the Amazon
    /// Resource Name
    /// (ARN) of the gateway in your request. The operation deletes the gateway;
    /// however, it does
    /// not delete the gateway virtual machine (VM) from your host computer.
    ///
    /// After you delete a gateway, you cannot reactivate it. Completed snapshots of
    /// the gateway
    /// volumes are not deleted upon deleting the gateway, however, pending
    /// snapshots will not
    /// complete. After you delete a gateway, your next step is to remove it from
    /// your
    /// environment.
    ///
    /// You no longer pay software charges after the gateway is deleted; however,
    /// your
    /// existing Amazon EBS snapshots persist and you will continue to be billed for
    /// these
    /// snapshots. You can choose to remove all remaining Amazon EBS snapshots by
    /// canceling your
    /// Amazon EC2 subscription.  If you prefer not to cancel your Amazon EC2
    /// subscription, you
    /// can delete your snapshots using the Amazon EC2 console. For more
    /// information, see the
    /// [Storage Gateway detail
    /// page](http://aws.amazon.com/storagegateway).
    pub fn deleteGateway(self: *Self, allocator: std.mem.Allocator, input: delete_gateway.DeleteGatewayInput, options: delete_gateway.Options) !delete_gateway.DeleteGatewayOutput {
        return delete_gateway.execute(self, allocator, input, options);
    }

    /// Deletes a snapshot of a volume.
    ///
    /// You can take snapshots of your gateway volumes on a scheduled or ad hoc
    /// basis. This API
    /// action enables you to delete a snapshot schedule for a volume. For more
    /// information, see
    /// [Backing up your
    /// volumes](https://docs.aws.amazon.com/storagegateway/latest/userguide/backing-up-volumes.html). In the `DeleteSnapshotSchedule` request, you identify the
    /// volume by providing its Amazon Resource Name (ARN). This operation is only
    /// supported for
    /// cached volume gateway types.
    ///
    /// To list or delete a snapshot, you must use the Amazon EC2 API. For more
    /// information,
    /// go to
    /// [DescribeSnapshots](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeSnapshots.html)
    /// in the *Amazon Elastic Compute Cloud API Reference*.
    pub fn deleteSnapshotSchedule(self: *Self, allocator: std.mem.Allocator, input: delete_snapshot_schedule.DeleteSnapshotScheduleInput, options: delete_snapshot_schedule.Options) !delete_snapshot_schedule.DeleteSnapshotScheduleOutput {
        return delete_snapshot_schedule.execute(self, allocator, input, options);
    }

    /// Deletes the specified virtual tape. This operation is only supported in the
    /// tape gateway
    /// type.
    pub fn deleteTape(self: *Self, allocator: std.mem.Allocator, input: delete_tape.DeleteTapeInput, options: delete_tape.Options) !delete_tape.DeleteTapeOutput {
        return delete_tape.execute(self, allocator, input, options);
    }

    /// Deletes the specified virtual tape from the virtual tape shelf (VTS). This
    /// operation is
    /// only supported in the tape gateway type.
    pub fn deleteTapeArchive(self: *Self, allocator: std.mem.Allocator, input: delete_tape_archive.DeleteTapeArchiveInput, options: delete_tape_archive.Options) !delete_tape_archive.DeleteTapeArchiveOutput {
        return delete_tape_archive.execute(self, allocator, input, options);
    }

    /// Delete a custom tape pool. A custom tape pool can only be deleted if there
    /// are no tapes
    /// in the pool and if there are no automatic tape creation policies that
    /// reference the custom
    /// tape pool.
    pub fn deleteTapePool(self: *Self, allocator: std.mem.Allocator, input: delete_tape_pool.DeleteTapePoolInput, options: delete_tape_pool.Options) !delete_tape_pool.DeleteTapePoolOutput {
        return delete_tape_pool.execute(self, allocator, input, options);
    }

    /// Deletes the specified storage volume that you previously created using the
    /// CreateCachediSCSIVolume or CreateStorediSCSIVolume API.
    /// This operation is only supported in the cached volume and stored volume
    /// types. For stored
    /// volume gateways, the local disk that was configured as the storage volume is
    /// not deleted.
    /// You can reuse the local disk to create another storage volume.
    ///
    /// Before you delete a volume, make sure there are no iSCSI connections to the
    /// volume you
    /// are deleting. You should also make sure there is no snapshot in progress.
    /// You can use the
    /// Amazon Elastic Compute Cloud (Amazon EC2) API to query snapshots on the
    /// volume you are
    /// deleting and check the snapshot status. For more information, go to
    /// [DescribeSnapshots](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/ApiReference-query-DescribeSnapshots.html) in the *Amazon Elastic Compute Cloud API
    /// Reference*.
    ///
    /// In the request, you must provide the Amazon Resource Name (ARN) of the
    /// storage volume
    /// you want to delete.
    pub fn deleteVolume(self: *Self, allocator: std.mem.Allocator, input: delete_volume.DeleteVolumeInput, options: delete_volume.Options) !delete_volume.DeleteVolumeOutput {
        return delete_volume.execute(self, allocator, input, options);
    }

    /// Returns information about the most recent high availability monitoring test
    /// that was
    /// performed on the host in a cluster. If a test isn't performed, the status
    /// and start
    /// time in the response would be null.
    pub fn describeAvailabilityMonitorTest(self: *Self, allocator: std.mem.Allocator, input: describe_availability_monitor_test.DescribeAvailabilityMonitorTestInput, options: describe_availability_monitor_test.Options) !describe_availability_monitor_test.DescribeAvailabilityMonitorTestOutput {
        return describe_availability_monitor_test.execute(self, allocator, input, options);
    }

    /// Returns the bandwidth rate limits of a gateway. By default, these limits are
    /// not set,
    /// which means no bandwidth rate limiting is in effect. This operation is
    /// supported only for
    /// the stored volume, cached volume, and tape gateway types. To describe
    /// bandwidth rate limits
    /// for S3 file gateways, use DescribeBandwidthRateLimitSchedule.
    ///
    /// This operation returns a value for a bandwidth rate limit only if the limit
    /// is set. If
    /// no limits are set for the gateway, then this operation returns only the
    /// gateway ARN in the
    /// response body. To specify which gateway to describe, use the Amazon Resource
    /// Name (ARN) of
    /// the gateway in your request.
    pub fn describeBandwidthRateLimit(self: *Self, allocator: std.mem.Allocator, input: describe_bandwidth_rate_limit.DescribeBandwidthRateLimitInput, options: describe_bandwidth_rate_limit.Options) !describe_bandwidth_rate_limit.DescribeBandwidthRateLimitOutput {
        return describe_bandwidth_rate_limit.execute(self, allocator, input, options);
    }

    /// Returns information about the bandwidth rate limit schedule of a gateway. By
    /// default,
    /// gateways do not have bandwidth rate limit schedules, which means no
    /// bandwidth rate limiting
    /// is in effect. This operation is supported only for volume, tape and S3 file
    /// gateways. FSx
    /// file gateways do not support bandwidth rate limits.
    ///
    /// This operation returns information about a gateway's bandwidth rate limit
    /// schedule. A
    /// bandwidth rate limit schedule consists of one or more bandwidth rate limit
    /// intervals. A
    /// bandwidth rate limit interval defines a period of time on one or more days
    /// of the week,
    /// during which bandwidth rate limits are specified for uploading, downloading,
    /// or both.
    ///
    /// A bandwidth rate limit interval consists of one or more days of the week, a
    /// start hour
    /// and minute, an ending hour and minute, and bandwidth rate limits for
    /// uploading and
    /// downloading
    ///
    /// If no bandwidth rate limit schedule intervals are set for the gateway, this
    /// operation
    /// returns an empty response. To specify which gateway to describe, use the
    /// Amazon Resource
    /// Name (ARN) of the gateway in your request.
    pub fn describeBandwidthRateLimitSchedule(self: *Self, allocator: std.mem.Allocator, input: describe_bandwidth_rate_limit_schedule.DescribeBandwidthRateLimitScheduleInput, options: describe_bandwidth_rate_limit_schedule.Options) !describe_bandwidth_rate_limit_schedule.DescribeBandwidthRateLimitScheduleOutput {
        return describe_bandwidth_rate_limit_schedule.execute(self, allocator, input, options);
    }

    /// Returns information about the cache of a gateway. This operation is only
    /// supported in
    /// the cached volume, tape, and file gateway types.
    ///
    /// The response includes disk IDs that are configured as cache, and it includes
    /// the amount
    /// of cache allocated and used.
    pub fn describeCache(self: *Self, allocator: std.mem.Allocator, input: describe_cache.DescribeCacheInput, options: describe_cache.Options) !describe_cache.DescribeCacheOutput {
        return describe_cache.execute(self, allocator, input, options);
    }

    /// Returns information about the specified cache report, including completion
    /// status and
    /// generation progress.
    pub fn describeCacheReport(self: *Self, allocator: std.mem.Allocator, input: describe_cache_report.DescribeCacheReportInput, options: describe_cache_report.Options) !describe_cache_report.DescribeCacheReportOutput {
        return describe_cache_report.execute(self, allocator, input, options);
    }

    /// Returns a description of the gateway volumes specified in the request. This
    /// operation is
    /// only supported in the cached volume gateway types.
    ///
    /// The list of gateway volumes in the request must be from one gateway. In the
    /// response,
    /// Storage Gateway returns volume information sorted by volume Amazon Resource
    /// Name
    /// (ARN).
    pub fn describeCachediScsiVolumes(self: *Self, allocator: std.mem.Allocator, input: describe_cachedi_scsi_volumes.DescribeCachediSCSIVolumesInput, options: describe_cachedi_scsi_volumes.Options) !describe_cachedi_scsi_volumes.DescribeCachediSCSIVolumesOutput {
        return describe_cachedi_scsi_volumes.execute(self, allocator, input, options);
    }

    /// Returns an array of Challenge-Handshake Authentication Protocol (CHAP)
    /// credentials
    /// information for a specified iSCSI target, one for each target-initiator
    /// pair. This
    /// operation is supported in the volume and tape gateway types.
    pub fn describeChapCredentials(self: *Self, allocator: std.mem.Allocator, input: describe_chap_credentials.DescribeChapCredentialsInput, options: describe_chap_credentials.Options) !describe_chap_credentials.DescribeChapCredentialsOutput {
        return describe_chap_credentials.execute(self, allocator, input, options);
    }

    /// Gets the file system association information. This operation is only
    /// supported for FSx
    /// File Gateways.
    pub fn describeFileSystemAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_file_system_associations.DescribeFileSystemAssociationsInput, options: describe_file_system_associations.Options) !describe_file_system_associations.DescribeFileSystemAssociationsOutput {
        return describe_file_system_associations.execute(self, allocator, input, options);
    }

    /// Returns metadata about a gateway such as its name, network interfaces, time
    /// zone,
    /// status, and software version. To specify which gateway to describe, use the
    /// Amazon Resource
    /// Name (ARN) of the gateway in your request.
    pub fn describeGatewayInformation(self: *Self, allocator: std.mem.Allocator, input: describe_gateway_information.DescribeGatewayInformationInput, options: describe_gateway_information.Options) !describe_gateway_information.DescribeGatewayInformationOutput {
        return describe_gateway_information.execute(self, allocator, input, options);
    }

    /// Returns your gateway's maintenance window schedule information, with values
    /// for
    /// monthly or weekly cadence, specific day and time to begin maintenance, and
    /// which types of
    /// updates to apply. Time values returned are for the gateway's time zone.
    pub fn describeMaintenanceStartTime(self: *Self, allocator: std.mem.Allocator, input: describe_maintenance_start_time.DescribeMaintenanceStartTimeInput, options: describe_maintenance_start_time.Options) !describe_maintenance_start_time.DescribeMaintenanceStartTimeOutput {
        return describe_maintenance_start_time.execute(self, allocator, input, options);
    }

    /// Gets a description for one or more Network File System (NFS) file shares
    /// from an S3 File
    /// Gateway. This operation is only supported for S3 File Gateways.
    pub fn describeNfsFileShares(self: *Self, allocator: std.mem.Allocator, input: describe_nfs_file_shares.DescribeNFSFileSharesInput, options: describe_nfs_file_shares.Options) !describe_nfs_file_shares.DescribeNFSFileSharesOutput {
        return describe_nfs_file_shares.execute(self, allocator, input, options);
    }

    /// Gets a description for one or more Server Message Block (SMB) file shares
    /// from a S3 File
    /// Gateway. This operation is only supported for S3 File Gateways.
    pub fn describeSmbFileShares(self: *Self, allocator: std.mem.Allocator, input: describe_smb_file_shares.DescribeSMBFileSharesInput, options: describe_smb_file_shares.Options) !describe_smb_file_shares.DescribeSMBFileSharesOutput {
        return describe_smb_file_shares.execute(self, allocator, input, options);
    }

    /// Gets a description of a Server Message Block (SMB) file share settings from
    /// a file
    /// gateway. This operation is only supported for file gateways.
    pub fn describeSmbSettings(self: *Self, allocator: std.mem.Allocator, input: describe_smb_settings.DescribeSMBSettingsInput, options: describe_smb_settings.Options) !describe_smb_settings.DescribeSMBSettingsOutput {
        return describe_smb_settings.execute(self, allocator, input, options);
    }

    /// Describes the snapshot schedule for the specified gateway volume. The
    /// snapshot schedule
    /// information includes intervals at which snapshots are automatically
    /// initiated on the
    /// volume. This operation is only supported in the cached volume and stored
    /// volume
    /// types.
    pub fn describeSnapshotSchedule(self: *Self, allocator: std.mem.Allocator, input: describe_snapshot_schedule.DescribeSnapshotScheduleInput, options: describe_snapshot_schedule.Options) !describe_snapshot_schedule.DescribeSnapshotScheduleOutput {
        return describe_snapshot_schedule.execute(self, allocator, input, options);
    }

    /// Returns the description of the gateway volumes specified in the request. The
    /// list of
    /// gateway volumes in the request must be from one gateway. In the response,
    /// Storage Gateway returns volume information sorted by volume ARNs. This
    /// operation is only
    /// supported in stored volume gateway type.
    pub fn describeStorediScsiVolumes(self: *Self, allocator: std.mem.Allocator, input: describe_storedi_scsi_volumes.DescribeStorediSCSIVolumesInput, options: describe_storedi_scsi_volumes.Options) !describe_storedi_scsi_volumes.DescribeStorediSCSIVolumesOutput {
        return describe_storedi_scsi_volumes.execute(self, allocator, input, options);
    }

    /// Returns a description of specified virtual tapes in the virtual tape shelf
    /// (VTS). This
    /// operation is only supported in the tape gateway type.
    ///
    /// If a specific `TapeARN` is not specified, Storage Gateway returns a
    /// description of all virtual tapes found in the VTS associated with your
    /// account.
    pub fn describeTapeArchives(self: *Self, allocator: std.mem.Allocator, input: describe_tape_archives.DescribeTapeArchivesInput, options: describe_tape_archives.Options) !describe_tape_archives.DescribeTapeArchivesOutput {
        return describe_tape_archives.execute(self, allocator, input, options);
    }

    /// Returns a list of virtual tape recovery points that are available for the
    /// specified tape
    /// gateway.
    ///
    /// A recovery point is a point-in-time view of a virtual tape at which all the
    /// data on the
    /// virtual tape is consistent. If your gateway crashes, virtual tapes that have
    /// recovery
    /// points can be recovered to a new gateway. This operation is only supported
    /// in the tape
    /// gateway type.
    pub fn describeTapeRecoveryPoints(self: *Self, allocator: std.mem.Allocator, input: describe_tape_recovery_points.DescribeTapeRecoveryPointsInput, options: describe_tape_recovery_points.Options) !describe_tape_recovery_points.DescribeTapeRecoveryPointsOutput {
        return describe_tape_recovery_points.execute(self, allocator, input, options);
    }

    /// Returns a description of virtual tapes that correspond to the specified
    /// Amazon Resource
    /// Names (ARNs). If `TapeARN` is not specified, returns a description of the
    /// virtual tapes associated with the specified gateway. This operation is only
    /// supported for
    /// the tape gateway type.
    ///
    /// The operation supports pagination. By default, the operation returns a
    /// maximum of up to
    /// 100 tapes. You can optionally specify the `Limit` field in the body to limit
    /// the
    /// number of tapes in the response. If the number of tapes returned in the
    /// response is
    /// truncated, the response includes a `Marker` field. You can use this
    /// `Marker` value in your subsequent request to retrieve the next set of
    /// tapes.
    pub fn describeTapes(self: *Self, allocator: std.mem.Allocator, input: describe_tapes.DescribeTapesInput, options: describe_tapes.Options) !describe_tapes.DescribeTapesOutput {
        return describe_tapes.execute(self, allocator, input, options);
    }

    /// Returns information about the upload buffer of a gateway. This operation is
    /// supported
    /// for the stored volume, cached volume, and tape gateway types.
    ///
    /// The response includes disk IDs that are configured as upload buffer space,
    /// and it
    /// includes the amount of upload buffer space allocated and used.
    pub fn describeUploadBuffer(self: *Self, allocator: std.mem.Allocator, input: describe_upload_buffer.DescribeUploadBufferInput, options: describe_upload_buffer.Options) !describe_upload_buffer.DescribeUploadBufferOutput {
        return describe_upload_buffer.execute(self, allocator, input, options);
    }

    /// Returns a description of virtual tape library (VTL) devices for the
    /// specified tape
    /// gateway. In the response, Storage Gateway returns VTL device information.
    ///
    /// This operation is only supported in the tape gateway type.
    pub fn describeVtlDevices(self: *Self, allocator: std.mem.Allocator, input: describe_vtl_devices.DescribeVTLDevicesInput, options: describe_vtl_devices.Options) !describe_vtl_devices.DescribeVTLDevicesOutput {
        return describe_vtl_devices.execute(self, allocator, input, options);
    }

    /// Returns information about the working storage of a gateway. This operation
    /// is only
    /// supported in the stored volumes gateway type. This operation is deprecated
    /// in cached
    /// volumes API version (20120630). Use DescribeUploadBuffer instead.
    ///
    /// Working storage is also referred to as upload buffer. You can also use the
    /// DescribeUploadBuffer operation to add upload buffer to a stored volume
    /// gateway.
    ///
    /// The response includes disk IDs that are configured as working storage, and
    /// it includes
    /// the amount of working storage allocated and used.
    pub fn describeWorkingStorage(self: *Self, allocator: std.mem.Allocator, input: describe_working_storage.DescribeWorkingStorageInput, options: describe_working_storage.Options) !describe_working_storage.DescribeWorkingStorageOutput {
        return describe_working_storage.execute(self, allocator, input, options);
    }

    /// Disconnects a volume from an iSCSI connection and then detaches the volume
    /// from the
    /// specified gateway. Detaching and attaching a volume enables you to recover
    /// your data from
    /// one gateway to a different gateway without creating a snapshot. It also
    /// makes it easier to
    /// move your volumes from an on-premises gateway to a gateway hosted on an
    /// Amazon EC2
    /// instance. This operation is only supported in the volume gateway type.
    pub fn detachVolume(self: *Self, allocator: std.mem.Allocator, input: detach_volume.DetachVolumeInput, options: detach_volume.Options) !detach_volume.DetachVolumeOutput {
        return detach_volume.execute(self, allocator, input, options);
    }

    /// Disables a tape gateway when the gateway is no longer functioning. For
    /// example, if your
    /// gateway VM is damaged, you can disable the gateway so you can recover
    /// virtual tapes.
    ///
    /// Use this operation for a tape gateway that is not reachable or not
    /// functioning. This
    /// operation is only supported in the tape gateway type.
    ///
    /// After a gateway is disabled, it cannot be enabled.
    pub fn disableGateway(self: *Self, allocator: std.mem.Allocator, input: disable_gateway.DisableGatewayInput, options: disable_gateway.Options) !disable_gateway.DisableGatewayOutput {
        return disable_gateway.execute(self, allocator, input, options);
    }

    /// Disassociates an Amazon FSx file system from the specified gateway. After
    /// the
    /// disassociation process finishes, the gateway can no longer access the Amazon
    /// FSx
    /// file system. This operation is only supported in the FSx File Gateway type.
    pub fn disassociateFileSystem(self: *Self, allocator: std.mem.Allocator, input: disassociate_file_system.DisassociateFileSystemInput, options: disassociate_file_system.Options) !disassociate_file_system.DisassociateFileSystemOutput {
        return disassociate_file_system.execute(self, allocator, input, options);
    }

    /// Starts a process that cleans the specified file share's cache of file
    /// entries that are
    /// failing upload to Amazon S3. This API operation reports success if the
    /// request is
    /// received with valid arguments, and there are no other cache clean operations
    /// currently
    /// in-progress for the specified file share. After a successful request, the
    /// cache clean
    /// operation occurs asynchronously and reports progress using CloudWatch logs
    /// and
    /// notifications.
    ///
    /// If `ForceRemove` is set to `True`, the cache clean operation
    /// will delete file data from the gateway which might otherwise be recoverable.
    /// We
    /// recommend using this operation only after all other methods to clear files
    /// failing
    /// upload have been exhausted, and if your business need outweighs the
    /// potential data
    /// loss.
    pub fn evictFilesFailingUpload(self: *Self, allocator: std.mem.Allocator, input: evict_files_failing_upload.EvictFilesFailingUploadInput, options: evict_files_failing_upload.Options) !evict_files_failing_upload.EvictFilesFailingUploadOutput {
        return evict_files_failing_upload.execute(self, allocator, input, options);
    }

    /// Adds a file gateway to an Active Directory domain. This operation is only
    /// supported for
    /// file gateways that support the SMB file protocol.
    ///
    /// Joining a domain creates an Active Directory computer account in the default
    /// organizational unit, using the gateway's **Gateway ID** as
    /// the account name (for example, SGW-1234ADE). If your Active Directory
    /// environment
    /// requires that you pre-stage accounts to facilitate the join domain process,
    /// you will
    /// need to create this account ahead of time.
    ///
    /// To create the gateway's computer account in an organizational unit other
    /// than the
    /// default, you must specify the organizational unit when joining the domain.
    pub fn joinDomain(self: *Self, allocator: std.mem.Allocator, input: join_domain.JoinDomainInput, options: join_domain.Options) !join_domain.JoinDomainOutput {
        return join_domain.execute(self, allocator, input, options);
    }

    /// Lists the automatic tape creation policies for a gateway. If there are no
    /// automatic tape
    /// creation policies for the gateway, it returns an empty list.
    ///
    /// This operation is only supported for tape gateways.
    pub fn listAutomaticTapeCreationPolicies(self: *Self, allocator: std.mem.Allocator, input: list_automatic_tape_creation_policies.ListAutomaticTapeCreationPoliciesInput, options: list_automatic_tape_creation_policies.Options) !list_automatic_tape_creation_policies.ListAutomaticTapeCreationPoliciesOutput {
        return list_automatic_tape_creation_policies.execute(self, allocator, input, options);
    }

    /// Returns a list of existing cache reports for all file shares associated with
    /// your
    /// Amazon Web Services account. This list includes all information provided by
    /// the
    /// `DescribeCacheReport` action, such as report name, status, completion
    /// progress, start time, end time, filters, and tags.
    pub fn listCacheReports(self: *Self, allocator: std.mem.Allocator, input: list_cache_reports.ListCacheReportsInput, options: list_cache_reports.Options) !list_cache_reports.ListCacheReportsOutput {
        return list_cache_reports.execute(self, allocator, input, options);
    }

    /// Gets a list of the file shares for a specific S3 File Gateway, or the list
    /// of file
    /// shares that belong to the calling Amazon Web Services account. This
    /// operation is only
    /// supported for S3 File Gateways.
    pub fn listFileShares(self: *Self, allocator: std.mem.Allocator, input: list_file_shares.ListFileSharesInput, options: list_file_shares.Options) !list_file_shares.ListFileSharesOutput {
        return list_file_shares.execute(self, allocator, input, options);
    }

    /// Gets a list of `FileSystemAssociationSummary` objects. Each object contains
    /// a
    /// summary of a file system association. This operation is only supported for
    /// FSx File
    /// Gateways.
    pub fn listFileSystemAssociations(self: *Self, allocator: std.mem.Allocator, input: list_file_system_associations.ListFileSystemAssociationsInput, options: list_file_system_associations.Options) !list_file_system_associations.ListFileSystemAssociationsOutput {
        return list_file_system_associations.execute(self, allocator, input, options);
    }

    /// Lists gateways owned by an Amazon Web Services account in an Amazon Web
    /// Services Region
    /// specified in the request. The returned list is ordered by gateway Amazon
    /// Resource Name
    /// (ARN).
    ///
    /// By default, the operation returns a maximum of 100 gateways. This operation
    /// supports
    /// pagination that allows you to optionally reduce the number of gateways
    /// returned in a
    /// response.
    ///
    /// If you have more gateways than are returned in a response (that is, the
    /// response returns
    /// only a truncated list of your gateways), the response contains a marker that
    /// you can
    /// specify in your next request to fetch the next page of gateways.
    pub fn listGateways(self: *Self, allocator: std.mem.Allocator, input: list_gateways.ListGatewaysInput, options: list_gateways.Options) !list_gateways.ListGatewaysOutput {
        return list_gateways.execute(self, allocator, input, options);
    }

    /// Returns a list of the gateway's local disks. To specify which gateway to
    /// describe,
    /// you use the Amazon Resource Name (ARN) of the gateway in the body of the
    /// request.
    ///
    /// The request returns a list of all disks, specifying which are configured as
    /// working
    /// storage, cache storage, or stored volume or not configured at all. The
    /// response includes a
    /// `DiskStatus` field. This field can have a value of present (the disk is
    /// available to use), missing (the disk is no longer connected to the gateway),
    /// or mismatch
    /// (the disk node is occupied by a disk that has incorrect metadata or the disk
    /// content is
    /// corrupted).
    pub fn listLocalDisks(self: *Self, allocator: std.mem.Allocator, input: list_local_disks.ListLocalDisksInput, options: list_local_disks.Options) !list_local_disks.ListLocalDisksOutput {
        return list_local_disks.execute(self, allocator, input, options);
    }

    /// Lists the tags that have been added to the specified resource. This
    /// operation is
    /// supported in storage gateways of all types.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists custom tape pools. You specify custom tape pools to list by specifying
    /// one or more
    /// custom tape pool Amazon Resource Names (ARNs). If you don't specify a custom
    /// tape pool ARN,
    /// the operation lists all custom tape pools.
    ///
    /// This operation supports pagination. You can optionally specify the `Limit`
    /// parameter in the body to limit the number of tape pools in the response. If
    /// the number of
    /// tape pools returned in the response is truncated, the response includes a
    /// `Marker` element that you can use in your subsequent request to retrieve the
    /// next set of tape pools.
    pub fn listTapePools(self: *Self, allocator: std.mem.Allocator, input: list_tape_pools.ListTapePoolsInput, options: list_tape_pools.Options) !list_tape_pools.ListTapePoolsOutput {
        return list_tape_pools.execute(self, allocator, input, options);
    }

    /// Lists virtual tapes in your virtual tape library (VTL) and your virtual tape
    /// shelf
    /// (VTS). You specify the tapes to list by specifying one or more tape Amazon
    /// Resource Names
    /// (ARNs). If you don't specify a tape ARN, the operation lists all virtual
    /// tapes in both
    /// your VTL and VTS.
    ///
    /// This operation supports pagination. By default, the operation returns a
    /// maximum of up to
    /// 100 tapes. You can optionally specify the `Limit` parameter in the body to
    /// limit
    /// the number of tapes in the response. If the number of tapes returned in the
    /// response is
    /// truncated, the response includes a `Marker` element that you can use in your
    /// subsequent request to retrieve the next set of tapes. This operation is only
    /// supported in
    /// the tape gateway type.
    pub fn listTapes(self: *Self, allocator: std.mem.Allocator, input: list_tapes.ListTapesInput, options: list_tapes.Options) !list_tapes.ListTapesOutput {
        return list_tapes.execute(self, allocator, input, options);
    }

    /// Lists iSCSI initiators that are connected to a volume. You can use this
    /// operation to
    /// determine whether a volume is being used or not. This operation is only
    /// supported in the
    /// cached volume and stored volume gateway types.
    pub fn listVolumeInitiators(self: *Self, allocator: std.mem.Allocator, input: list_volume_initiators.ListVolumeInitiatorsInput, options: list_volume_initiators.Options) !list_volume_initiators.ListVolumeInitiatorsOutput {
        return list_volume_initiators.execute(self, allocator, input, options);
    }

    /// Lists the recovery points for a specified gateway. This operation is only
    /// supported in
    /// the cached volume gateway type.
    ///
    /// Each cache volume has one recovery point. A volume recovery point is a point
    /// in time at
    /// which all data of the volume is consistent and from which you can create a
    /// snapshot or
    /// clone a new cached volume from a source volume. To create a snapshot from a
    /// volume recovery
    /// point use the CreateSnapshotFromVolumeRecoveryPoint operation.
    pub fn listVolumeRecoveryPoints(self: *Self, allocator: std.mem.Allocator, input: list_volume_recovery_points.ListVolumeRecoveryPointsInput, options: list_volume_recovery_points.Options) !list_volume_recovery_points.ListVolumeRecoveryPointsOutput {
        return list_volume_recovery_points.execute(self, allocator, input, options);
    }

    /// Lists the iSCSI stored volumes of a gateway. Results are sorted by volume
    /// ARN. The
    /// response includes only the volume ARNs. If you want additional volume
    /// information, use the
    /// DescribeStorediSCSIVolumes or the DescribeCachediSCSIVolumes API.
    ///
    /// The operation supports pagination. By default, the operation returns a
    /// maximum of up to
    /// 100 volumes. You can optionally specify the `Limit` field in the body to
    /// limit
    /// the number of volumes in the response. If the number of volumes returned in
    /// the response is
    /// truncated, the response includes a Marker field. You can use this Marker
    /// value in your
    /// subsequent request to retrieve the next set of volumes. This operation is
    /// only supported in
    /// the cached volume and stored volume gateway types.
    pub fn listVolumes(self: *Self, allocator: std.mem.Allocator, input: list_volumes.ListVolumesInput, options: list_volumes.Options) !list_volumes.ListVolumesOutput {
        return list_volumes.execute(self, allocator, input, options);
    }

    /// Sends you notification through Amazon EventBridge when all files written to
    /// your file
    /// share have been uploaded to Amazon S3.
    ///
    /// Storage Gateway can send a notification through Amazon EventBridge when all
    /// files written to your file share up to that point in time have been uploaded
    /// to Amazon S3. These files include files written to the file share up to the
    /// time that you
    /// make a request for notification. When the upload is done, Storage Gateway
    /// sends you
    /// notification through EventBridge. You can configure EventBridge to send the
    /// notification through event targets such as Amazon SNS or Lambda
    /// function. This operation is only supported for S3 File Gateways.
    ///
    /// For more information, see [Getting
    /// file upload
    /// notification](https://docs.aws.amazon.com/filegateway/latest/files3/monitoring-file-gateway.html#get-notification) in the *Amazon S3 File Gateway User
    /// Guide*.
    pub fn notifyWhenUploaded(self: *Self, allocator: std.mem.Allocator, input: notify_when_uploaded.NotifyWhenUploadedInput, options: notify_when_uploaded.Options) !notify_when_uploaded.NotifyWhenUploadedOutput {
        return notify_when_uploaded.execute(self, allocator, input, options);
    }

    /// Refreshes the cached inventory of objects for the specified file share. This
    /// operation
    /// finds objects in the Amazon S3 bucket that were added, removed, or replaced
    /// since
    /// the gateway last listed the bucket's contents and cached the results. This
    /// operation
    /// does not import files into the S3 File Gateway cache storage. It only
    /// updates the cached
    /// inventory to reflect changes in the inventory of the objects in the S3
    /// bucket. This
    /// operation is only supported in the S3 File Gateway types.
    ///
    /// You can subscribe to be notified through an Amazon CloudWatch event when
    /// your
    /// `RefreshCache` operation completes. For more information, see [Getting
    /// notified about file
    /// operations](https://docs.aws.amazon.com/filegateway/latest/files3/monitoring-file-gateway.html#get-notification) in the *Amazon S3 File Gateway User
    /// Guide*. This operation is Only supported for S3 File Gateways.
    ///
    /// When this API is called, it only initiates the refresh operation. When the
    /// API call
    /// completes and returns a success code, it doesn't necessarily mean that the
    /// file
    /// refresh has completed. You should use the refresh-complete notification to
    /// determine that
    /// the operation has completed before you check for new files on the gateway
    /// file share. You
    /// can subscribe to be notified through a CloudWatch event when your
    /// `RefreshCache`
    /// operation completes.
    ///
    /// Throttle limit: This API is asynchronous, so the gateway will accept no more
    /// than two
    /// refreshes at any time. We recommend using the refresh-complete CloudWatch
    /// event
    /// notification before issuing additional requests. For more information, see
    /// [Getting
    /// notified about file
    /// operations](https://docs.aws.amazon.com/filegateway/latest/files3/monitoring-file-gateway.html#get-notification) in the *Amazon S3 File Gateway User
    /// Guide*.
    ///
    /// * Wait at least 60 seconds between consecutive RefreshCache API requests.
    ///
    /// * If you invoke the RefreshCache API when two requests are already being
    /// processed, any new request will cause an
    /// `InvalidGatewayRequestException` error because too many requests
    /// were sent to the server.
    ///
    /// The S3 bucket name does not need to be included when entering the list of
    /// folders in
    /// the FolderList parameter.
    ///
    /// For more information, see [Getting
    /// notified about file
    /// operations](https://docs.aws.amazon.com/filegateway/latest/files3/monitoring-file-gateway.html#get-notification) in the *Amazon S3 File Gateway User
    /// Guide*.
    pub fn refreshCache(self: *Self, allocator: std.mem.Allocator, input: refresh_cache.RefreshCacheInput, options: refresh_cache.Options) !refresh_cache.RefreshCacheOutput {
        return refresh_cache.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified resource. This operation is
    /// supported in
    /// storage gateways of all types.
    pub fn removeTagsFromResource(self: *Self, allocator: std.mem.Allocator, input: remove_tags_from_resource.RemoveTagsFromResourceInput, options: remove_tags_from_resource.Options) !remove_tags_from_resource.RemoveTagsFromResourceOutput {
        return remove_tags_from_resource.execute(self, allocator, input, options);
    }

    /// Resets all cache disks that have encountered an error and makes the disks
    /// available for
    /// reconfiguration as cache storage. If your cache disk encounters an error,
    /// the gateway
    /// prevents read and write operations on virtual tapes in the gateway. For
    /// example, an error
    /// can occur when a disk is corrupted or removed from the gateway. When a cache
    /// is reset, the
    /// gateway loses its cache storage. At this point, you can reconfigure the
    /// disks as cache
    /// disks. This operation is only supported in the cached volume and tape types.
    ///
    /// If the cache disk you are resetting contains data that has not been uploaded
    /// to
    /// Amazon S3 yet, that data can be lost. After you reset cache disks, there
    /// will
    /// be no configured cache disks left in the gateway, so you must configure at
    /// least one new
    /// cache disk for your gateway to function properly.
    pub fn resetCache(self: *Self, allocator: std.mem.Allocator, input: reset_cache.ResetCacheInput, options: reset_cache.Options) !reset_cache.ResetCacheOutput {
        return reset_cache.execute(self, allocator, input, options);
    }

    /// Retrieves an archived virtual tape from the virtual tape shelf (VTS) to a
    /// tape gateway.
    /// Virtual tapes archived in the VTS are not associated with any gateway.
    /// However after a tape
    /// is retrieved, it is associated with a gateway, even though it is also listed
    /// in the VTS,
    /// that is, archive. This operation is only supported in the tape gateway type.
    ///
    /// Once a tape is successfully retrieved to a gateway, it cannot be retrieved
    /// again to
    /// another gateway. You must archive the tape again before you can retrieve it
    /// to another
    /// gateway. This operation is only supported in the tape gateway type.
    pub fn retrieveTapeArchive(self: *Self, allocator: std.mem.Allocator, input: retrieve_tape_archive.RetrieveTapeArchiveInput, options: retrieve_tape_archive.Options) !retrieve_tape_archive.RetrieveTapeArchiveOutput {
        return retrieve_tape_archive.execute(self, allocator, input, options);
    }

    /// Retrieves the recovery point for the specified virtual tape. This operation
    /// is only
    /// supported in the tape gateway type.
    ///
    /// A recovery point is a point in time view of a virtual tape at which all the
    /// data on the
    /// tape is consistent. If your gateway crashes, virtual tapes that have
    /// recovery points can be
    /// recovered to a new gateway.
    ///
    /// The virtual tape can be retrieved to only one gateway. The retrieved tape is
    /// read-only. The virtual tape can be retrieved to only a tape gateway. There
    /// is no charge
    /// for retrieving recovery points.
    pub fn retrieveTapeRecoveryPoint(self: *Self, allocator: std.mem.Allocator, input: retrieve_tape_recovery_point.RetrieveTapeRecoveryPointInput, options: retrieve_tape_recovery_point.Options) !retrieve_tape_recovery_point.RetrieveTapeRecoveryPointOutput {
        return retrieve_tape_recovery_point.execute(self, allocator, input, options);
    }

    /// Sets the password for your VM local console. When you log in to the local
    /// console for
    /// the first time, you log in to the VM with the default credentials. We
    /// recommend that you
    /// set a new password. You don't need to know the default password to set a new
    /// password.
    pub fn setLocalConsolePassword(self: *Self, allocator: std.mem.Allocator, input: set_local_console_password.SetLocalConsolePasswordInput, options: set_local_console_password.Options) !set_local_console_password.SetLocalConsolePasswordOutput {
        return set_local_console_password.execute(self, allocator, input, options);
    }

    /// Sets the password for the guest user `smbguest`. The `smbguest`
    /// user is the user when the authentication method for the file share is set to
    /// `GuestAccess`. This operation only supported for S3 File Gateways
    pub fn setSmbGuestPassword(self: *Self, allocator: std.mem.Allocator, input: set_smb_guest_password.SetSMBGuestPasswordInput, options: set_smb_guest_password.Options) !set_smb_guest_password.SetSMBGuestPasswordOutput {
        return set_smb_guest_password.execute(self, allocator, input, options);
    }

    /// Shuts down a Tape Gateway or Volume Gateway. To specify which gateway to
    /// shut down, use
    /// the Amazon Resource Name (ARN) of the gateway in the body of your request.
    ///
    /// This API action cannot be used to shut down S3 File Gateway or FSx File
    /// Gateway.
    ///
    /// The operation shuts down the gateway service component running in the
    /// gateway's
    /// virtual machine (VM) and not the host VM.
    ///
    /// If you want to shut down the VM, it is recommended that you first shut down
    /// the
    /// gateway component in the VM to avoid unpredictable conditions.
    ///
    /// After the gateway is shutdown, you cannot call any other API except
    /// StartGateway, DescribeGatewayInformation, and ListGateways. For more
    /// information, see ActivateGateway.
    /// Your applications cannot read from or write to the gateway's storage
    /// volumes, and
    /// there are no snapshots taken.
    ///
    /// When you make a shutdown request, you will get a `200 OK` success response
    /// immediately. However, it might take some time for the gateway to shut down.
    /// You can call
    /// the DescribeGatewayInformation API to check the status. For more
    /// information, see ActivateGateway.
    ///
    /// If do not intend to use the gateway again, you must delete the gateway
    /// (using DeleteGateway) to no longer pay software charges associated with the
    /// gateway.
    pub fn shutdownGateway(self: *Self, allocator: std.mem.Allocator, input: shutdown_gateway.ShutdownGatewayInput, options: shutdown_gateway.Options) !shutdown_gateway.ShutdownGatewayOutput {
        return shutdown_gateway.execute(self, allocator, input, options);
    }

    /// Start a test that verifies that the specified gateway is configured for High
    /// Availability monitoring in your host environment. This request only
    /// initiates the test and
    /// that a successful response only indicates that the test was started. It
    /// doesn't
    /// indicate that the test passed. For the status of the test, invoke the
    /// `DescribeAvailabilityMonitorTest` API.
    ///
    /// Starting this test will cause your gateway to go offline for a brief period.
    pub fn startAvailabilityMonitorTest(self: *Self, allocator: std.mem.Allocator, input: start_availability_monitor_test.StartAvailabilityMonitorTestInput, options: start_availability_monitor_test.Options) !start_availability_monitor_test.StartAvailabilityMonitorTestOutput {
        return start_availability_monitor_test.execute(self, allocator, input, options);
    }

    /// Starts generating a report of the file metadata currently cached by an S3
    /// File Gateway for a specific file share. You can use this report to identify
    /// and resolve
    /// issues if you have files failing upload from your gateway to Amazon S3. The
    /// report
    /// is a CSV file containing a list of files which match the set of filter
    /// parameters you
    /// specify in the request.
    ///
    /// The **Files Failing Upload** flag is reset every 24
    /// hours and during gateway reboot. If this report captures the files after the
    /// reset, but
    /// before they become flagged again, they will not be reported as **Files
    /// Failing Upload**.
    ///
    /// The following requirements must be met to successfully generate a cache
    /// report:
    ///
    /// * You must have `s3:PutObject` and `s3:AbortMultipartUpload`
    /// permissions for the Amazon S3 bucket where you want to store the cache
    /// report.
    ///
    /// * No other cache reports can currently be in-progress for the specified file
    /// share.
    ///
    /// * There must be fewer than 10 existing cache reports for the specified file
    /// share.
    ///
    /// * The gateway must be online and connected to Amazon Web Services.
    ///
    /// * The root disk must have at least 20GB of free space when report generation
    /// starts.
    ///
    /// * You must specify at least one value for `InclusionFilters` or
    /// `ExclusionFilters` in the request.
    pub fn startCacheReport(self: *Self, allocator: std.mem.Allocator, input: start_cache_report.StartCacheReportInput, options: start_cache_report.Options) !start_cache_report.StartCacheReportOutput {
        return start_cache_report.execute(self, allocator, input, options);
    }

    /// Starts a gateway that you previously shut down (see ShutdownGateway).
    /// After the gateway starts, you can then make other API calls, your
    /// applications can read
    /// from or write to the gateway's storage volumes and you will be able to take
    /// snapshot
    /// backups.
    ///
    /// When you make a request, you will get a 200 OK success response immediately.
    /// However,
    /// it might take some time for the gateway to be ready. You should call
    /// DescribeGatewayInformation and check the status before making any
    /// additional API calls. For more information, see ActivateGateway.
    ///
    /// To specify which gateway to start, use the Amazon Resource Name (ARN) of the
    /// gateway in
    /// your request.
    pub fn startGateway(self: *Self, allocator: std.mem.Allocator, input: start_gateway.StartGatewayInput, options: start_gateway.Options) !start_gateway.StartGatewayOutput {
        return start_gateway.execute(self, allocator, input, options);
    }

    /// Updates the automatic tape creation policy of a gateway. Use this to update
    /// the policy
    /// with a new set of automatic tape creation rules. This is only supported for
    /// tape
    /// gateways.
    ///
    /// By default, there is no automatic tape creation policy.
    ///
    /// A gateway can have only one automatic tape creation policy.
    pub fn updateAutomaticTapeCreationPolicy(self: *Self, allocator: std.mem.Allocator, input: update_automatic_tape_creation_policy.UpdateAutomaticTapeCreationPolicyInput, options: update_automatic_tape_creation_policy.Options) !update_automatic_tape_creation_policy.UpdateAutomaticTapeCreationPolicyOutput {
        return update_automatic_tape_creation_policy.execute(self, allocator, input, options);
    }

    /// Updates the bandwidth rate limits of a gateway. You can update both the
    /// upload and
    /// download bandwidth rate limit or specify only one of the two. If you don't
    /// set a
    /// bandwidth rate limit, the existing rate limit remains. This operation is
    /// supported only for
    /// the stored volume, cached volume, and tape gateway types. To update
    /// bandwidth rate limits
    /// for S3 file gateways, use UpdateBandwidthRateLimitSchedule.
    ///
    /// By default, a gateway's bandwidth rate limits are not set. If you don't set
    /// any limit, the gateway does not have any limitations on its bandwidth usage
    /// and could
    /// potentially use the maximum available bandwidth.
    ///
    /// To specify which gateway to update, use the Amazon Resource Name (ARN) of
    /// the gateway in
    /// your request.
    pub fn updateBandwidthRateLimit(self: *Self, allocator: std.mem.Allocator, input: update_bandwidth_rate_limit.UpdateBandwidthRateLimitInput, options: update_bandwidth_rate_limit.Options) !update_bandwidth_rate_limit.UpdateBandwidthRateLimitOutput {
        return update_bandwidth_rate_limit.execute(self, allocator, input, options);
    }

    /// Updates the bandwidth rate limit schedule for a specified gateway. By
    /// default, gateways
    /// do not have bandwidth rate limit schedules, which means no bandwidth rate
    /// limiting is in
    /// effect. Use this to initiate or update a gateway's bandwidth rate limit
    /// schedule. This
    /// operation is supported for volume, tape, and S3 file gateways. S3 file
    /// gateways support
    /// bandwidth rate limits for upload only. FSx file gateways do not support
    /// bandwidth rate
    /// limits.
    pub fn updateBandwidthRateLimitSchedule(self: *Self, allocator: std.mem.Allocator, input: update_bandwidth_rate_limit_schedule.UpdateBandwidthRateLimitScheduleInput, options: update_bandwidth_rate_limit_schedule.Options) !update_bandwidth_rate_limit_schedule.UpdateBandwidthRateLimitScheduleOutput {
        return update_bandwidth_rate_limit_schedule.execute(self, allocator, input, options);
    }

    /// Updates the Challenge-Handshake Authentication Protocol (CHAP) credentials
    /// for a
    /// specified iSCSI target. By default, a gateway does not have CHAP enabled;
    /// however, for
    /// added security, you might use it. This operation is supported in the volume
    /// and tape
    /// gateway types.
    ///
    /// When you update CHAP credentials, all existing connections on the target are
    /// closed
    /// and initiators must reconnect with the new credentials.
    pub fn updateChapCredentials(self: *Self, allocator: std.mem.Allocator, input: update_chap_credentials.UpdateChapCredentialsInput, options: update_chap_credentials.Options) !update_chap_credentials.UpdateChapCredentialsOutput {
        return update_chap_credentials.execute(self, allocator, input, options);
    }

    /// Updates a file system association. This operation is only supported in the
    /// FSx File
    /// Gateways.
    pub fn updateFileSystemAssociation(self: *Self, allocator: std.mem.Allocator, input: update_file_system_association.UpdateFileSystemAssociationInput, options: update_file_system_association.Options) !update_file_system_association.UpdateFileSystemAssociationOutput {
        return update_file_system_association.execute(self, allocator, input, options);
    }

    /// Updates a gateway's metadata, which includes the gateway's name, time zone,
    /// and metadata cache size. To specify which gateway to update, use the Amazon
    /// Resource Name
    /// (ARN) of the gateway in your request.
    ///
    /// For gateways activated after September 2, 2015, the gateway's ARN contains
    /// the
    /// gateway ID rather than the gateway name. However, changing the name of the
    /// gateway has
    /// no effect on the gateway's ARN.
    pub fn updateGatewayInformation(self: *Self, allocator: std.mem.Allocator, input: update_gateway_information.UpdateGatewayInformationInput, options: update_gateway_information.Options) !update_gateway_information.UpdateGatewayInformationOutput {
        return update_gateway_information.execute(self, allocator, input, options);
    }

    /// Updates the gateway virtual machine (VM) software. The request immediately
    /// triggers the
    /// software update.
    ///
    /// When you make this request, you get a `200 OK` success response
    /// immediately. However, it might take some time for the update to complete.
    /// You can call
    /// DescribeGatewayInformation to verify the gateway is in the
    /// `STATE_RUNNING` state.
    ///
    /// A software update forces a system restart of your gateway. You can minimize
    /// the
    /// chance of any disruption to your applications by increasing your iSCSI
    /// Initiators'
    /// timeouts. For more information about increasing iSCSI Initiator timeouts for
    /// Windows and
    /// Linux, see [Customizing your Windows iSCSI
    /// settings](https://docs.aws.amazon.com/storagegateway/latest/userguide/ConfiguringiSCSIClientInitiatorWindowsClient.html#CustomizeWindowsiSCSISettings) and [Customizing your Linux iSCSI settings](https://docs.aws.amazon.com/storagegateway/latest/userguide/ConfiguringiSCSIClientInitiatorRedHatClient.html#CustomizeLinuxiSCSISettings), respectively.
    pub fn updateGatewaySoftwareNow(self: *Self, allocator: std.mem.Allocator, input: update_gateway_software_now.UpdateGatewaySoftwareNowInput, options: update_gateway_software_now.Options) !update_gateway_software_now.UpdateGatewaySoftwareNowOutput {
        return update_gateway_software_now.execute(self, allocator, input, options);
    }

    /// Updates a gateway's maintenance window schedule, with settings for monthly
    /// or
    /// weekly cadence, specific day and time to begin maintenance, and which types
    /// of updates to
    /// apply. Time configuration uses the gateway's time zone. You can pass values
    /// for a complete
    /// maintenance schedule, or update policy, or both. Previous values will
    /// persist for whichever
    /// setting you choose not to modify. If an incomplete or invalid maintenance
    /// schedule is
    /// passed, the entire request will be rejected with an error and no changes
    /// will occur.
    ///
    /// A complete maintenance schedule must include values for *both*
    /// `MinuteOfHour` and `HourOfDay`, and *either*
    /// `DayOfMonth`
    /// *or*
    /// `DayOfWeek`.
    ///
    /// We recommend keeping maintenance updates turned on, except in specific use
    /// cases
    /// where the brief disruptions caused by updating the gateway could critically
    /// impact your
    /// deployment.
    pub fn updateMaintenanceStartTime(self: *Self, allocator: std.mem.Allocator, input: update_maintenance_start_time.UpdateMaintenanceStartTimeInput, options: update_maintenance_start_time.Options) !update_maintenance_start_time.UpdateMaintenanceStartTimeOutput {
        return update_maintenance_start_time.execute(self, allocator, input, options);
    }

    /// Updates a Network File System (NFS) file share. This operation is only
    /// supported in S3
    /// File Gateways.
    ///
    /// To leave a file share field unchanged, set the corresponding input field to
    /// null.
    ///
    /// Updates the following file share settings:
    ///
    /// * Default storage class for your S3 bucket
    ///
    /// * Metadata defaults for your S3 bucket
    ///
    /// * Allowed NFS clients for your file share
    ///
    /// * Squash settings
    ///
    /// * Write status of your file share
    pub fn updateNfsFileShare(self: *Self, allocator: std.mem.Allocator, input: update_nfs_file_share.UpdateNFSFileShareInput, options: update_nfs_file_share.Options) !update_nfs_file_share.UpdateNFSFileShareOutput {
        return update_nfs_file_share.execute(self, allocator, input, options);
    }

    /// Updates a Server Message Block (SMB) file share. This operation is only
    /// supported for S3
    /// File Gateways.
    ///
    /// To leave a file share field unchanged, set the corresponding input field to
    /// null.
    ///
    /// File gateways require Security Token Service (Amazon Web Services STS) to be
    /// activated to enable you to create a file share. Make sure that Amazon Web
    /// Services STS
    /// is activated in the Amazon Web Services Region you are creating your file
    /// gateway in. If
    /// Amazon Web Services STS is not activated in this Amazon Web Services Region,
    /// activate
    /// it. For information about how to activate Amazon Web Services STS, see
    /// [Activating and
    /// deactivating Amazon Web Services STS in an Amazon Web Services
    /// Region](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_enable-regions.html) in the
    /// *Identity and Access Management User Guide*.
    ///
    /// File gateways don't support creating hard or symbolic links on a file
    /// share.
    pub fn updateSmbFileShare(self: *Self, allocator: std.mem.Allocator, input: update_smb_file_share.UpdateSMBFileShareInput, options: update_smb_file_share.Options) !update_smb_file_share.UpdateSMBFileShareOutput {
        return update_smb_file_share.execute(self, allocator, input, options);
    }

    /// Controls whether the shares on an S3 File Gateway are visible in a net view
    /// or browse
    /// list. The operation is only supported for S3 File Gateways.
    pub fn updateSmbFileShareVisibility(self: *Self, allocator: std.mem.Allocator, input: update_smb_file_share_visibility.UpdateSMBFileShareVisibilityInput, options: update_smb_file_share_visibility.Options) !update_smb_file_share_visibility.UpdateSMBFileShareVisibilityOutput {
        return update_smb_file_share_visibility.execute(self, allocator, input, options);
    }

    /// Updates the list of Active Directory users and groups that have special
    /// permissions for
    /// SMB file shares on the gateway.
    pub fn updateSmbLocalGroups(self: *Self, allocator: std.mem.Allocator, input: update_smb_local_groups.UpdateSMBLocalGroupsInput, options: update_smb_local_groups.Options) !update_smb_local_groups.UpdateSMBLocalGroupsOutput {
        return update_smb_local_groups.execute(self, allocator, input, options);
    }

    /// Updates the SMB security strategy level for an Amazon S3 file gateway. This
    /// action is only supported for Amazon S3 file gateways.
    ///
    /// For information about configuring this setting using the Amazon Web Services
    /// console,
    /// see [Setting a security level for your
    /// gateway](https://docs.aws.amazon.com/filegateway/latest/files3/security-strategy.html) in the *Amazon S3
    /// File Gateway User Guide*.
    ///
    /// A higher security strategy level can affect performance of the gateway.
    pub fn updateSmbSecurityStrategy(self: *Self, allocator: std.mem.Allocator, input: update_smb_security_strategy.UpdateSMBSecurityStrategyInput, options: update_smb_security_strategy.Options) !update_smb_security_strategy.UpdateSMBSecurityStrategyOutput {
        return update_smb_security_strategy.execute(self, allocator, input, options);
    }

    /// Updates a snapshot schedule configured for a gateway volume. This operation
    /// is only
    /// supported in the cached volume and stored volume gateway types.
    ///
    /// The default snapshot schedule for volume is once every 24 hours, starting at
    /// the
    /// creation time of the volume. You can use this API to change the snapshot
    /// schedule
    /// configured for the volume.
    ///
    /// In the request you must identify the gateway volume whose snapshot schedule
    /// you want to
    /// update, and the schedule information, including when you want the snapshot
    /// to begin on a
    /// day and the frequency (in hours) of snapshots.
    pub fn updateSnapshotSchedule(self: *Self, allocator: std.mem.Allocator, input: update_snapshot_schedule.UpdateSnapshotScheduleInput, options: update_snapshot_schedule.Options) !update_snapshot_schedule.UpdateSnapshotScheduleOutput {
        return update_snapshot_schedule.execute(self, allocator, input, options);
    }

    /// Updates the type of medium changer in a tape gateway. When you activate a
    /// tape gateway,
    /// you select a medium changer type for the tape gateway. This operation
    /// enables you to select
    /// a different type of medium changer after a tape gateway is activated. This
    /// operation is
    /// only supported in the tape gateway type.
    pub fn updateVtlDeviceType(self: *Self, allocator: std.mem.Allocator, input: update_vtl_device_type.UpdateVTLDeviceTypeInput, options: update_vtl_device_type.Options) !update_vtl_device_type.UpdateVTLDeviceTypeOutput {
        return update_vtl_device_type.execute(self, allocator, input, options);
    }

    pub fn describeTapeArchivesPaginator(self: *Self, params: describe_tape_archives.DescribeTapeArchivesInput) paginator.DescribeTapeArchivesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTapeRecoveryPointsPaginator(self: *Self, params: describe_tape_recovery_points.DescribeTapeRecoveryPointsInput) paginator.DescribeTapeRecoveryPointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTapesPaginator(self: *Self, params: describe_tapes.DescribeTapesInput) paginator.DescribeTapesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVtlDevicesPaginator(self: *Self, params: describe_vtl_devices.DescribeVTLDevicesInput) paginator.DescribeVTLDevicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCacheReportsPaginator(self: *Self, params: list_cache_reports.ListCacheReportsInput) paginator.ListCacheReportsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFileSharesPaginator(self: *Self, params: list_file_shares.ListFileSharesInput) paginator.ListFileSharesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFileSystemAssociationsPaginator(self: *Self, params: list_file_system_associations.ListFileSystemAssociationsInput) paginator.ListFileSystemAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGatewaysPaginator(self: *Self, params: list_gateways.ListGatewaysInput) paginator.ListGatewaysPaginator {
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

    pub fn listTapePoolsPaginator(self: *Self, params: list_tape_pools.ListTapePoolsInput) paginator.ListTapePoolsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTapesPaginator(self: *Self, params: list_tapes.ListTapesInput) paginator.ListTapesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVolumesPaginator(self: *Self, params: list_volumes.ListVolumesInput) paginator.ListVolumesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
