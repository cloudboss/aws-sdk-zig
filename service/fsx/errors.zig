const aws = @import("aws");
const std = @import("std");

const ActiveDirectoryErrorType = @import("active_directory_error_type.zig").ActiveDirectoryErrorType;
const ServiceLimit = @import("service_limit.zig").ServiceLimit;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_point_already_owned_by_you: AccessPointAlreadyOwnedByYou,
        active_directory_error: ActiveDirectoryError,
        backup_being_copied: BackupBeingCopied,
        backup_in_progress: BackupInProgress,
        backup_not_found: BackupNotFound,
        backup_restoring: BackupRestoring,
        bad_request: BadRequest,
        data_repository_association_not_found: DataRepositoryAssociationNotFound,
        data_repository_task_ended: DataRepositoryTaskEnded,
        data_repository_task_executing: DataRepositoryTaskExecuting,
        data_repository_task_not_found: DataRepositoryTaskNotFound,
        file_cache_not_found: FileCacheNotFound,
        file_system_not_found: FileSystemNotFound,
        incompatible_parameter_error: IncompatibleParameterError,
        incompatible_region_for_multi_az: IncompatibleRegionForMultiAZ,
        internal_server_error: InternalServerError,
        invalid_access_point: InvalidAccessPoint,
        invalid_data_repository_type: InvalidDataRepositoryType,
        invalid_destination_kms_key: InvalidDestinationKmsKey,
        invalid_export_path: InvalidExportPath,
        invalid_import_path: InvalidImportPath,
        invalid_network_settings: InvalidNetworkSettings,
        invalid_per_unit_storage_throughput: InvalidPerUnitStorageThroughput,
        invalid_region: InvalidRegion,
        invalid_request: InvalidRequest,
        invalid_source_kms_key: InvalidSourceKmsKey,
        missing_file_cache_configuration: MissingFileCacheConfiguration,
        missing_file_system_configuration: MissingFileSystemConfiguration,
        missing_volume_configuration: MissingVolumeConfiguration,
        not_service_resource_error: NotServiceResourceError,
        resource_does_not_support_tagging: ResourceDoesNotSupportTagging,
        resource_not_found: ResourceNotFound,
        s3_access_point_attachment_not_found: S3AccessPointAttachmentNotFound,
        service_limit_exceeded: ServiceLimitExceeded,
        snapshot_not_found: SnapshotNotFound,
        source_backup_unavailable: SourceBackupUnavailable,
        storage_virtual_machine_not_found: StorageVirtualMachineNotFound,
        too_many_access_points: TooManyAccessPoints,
        unsupported_operation: UnsupportedOperation,
        volume_not_found: VolumeNotFound,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_point_already_owned_by_you => "AccessPointAlreadyOwnedByYou",
                .active_directory_error => "ActiveDirectoryError",
                .backup_being_copied => "BackupBeingCopied",
                .backup_in_progress => "BackupInProgress",
                .backup_not_found => "BackupNotFound",
                .backup_restoring => "BackupRestoring",
                .bad_request => "BadRequest",
                .data_repository_association_not_found => "DataRepositoryAssociationNotFound",
                .data_repository_task_ended => "DataRepositoryTaskEnded",
                .data_repository_task_executing => "DataRepositoryTaskExecuting",
                .data_repository_task_not_found => "DataRepositoryTaskNotFound",
                .file_cache_not_found => "FileCacheNotFound",
                .file_system_not_found => "FileSystemNotFound",
                .incompatible_parameter_error => "IncompatibleParameterError",
                .incompatible_region_for_multi_az => "IncompatibleRegionForMultiAZ",
                .internal_server_error => "InternalServerError",
                .invalid_access_point => "InvalidAccessPoint",
                .invalid_data_repository_type => "InvalidDataRepositoryType",
                .invalid_destination_kms_key => "InvalidDestinationKmsKey",
                .invalid_export_path => "InvalidExportPath",
                .invalid_import_path => "InvalidImportPath",
                .invalid_network_settings => "InvalidNetworkSettings",
                .invalid_per_unit_storage_throughput => "InvalidPerUnitStorageThroughput",
                .invalid_region => "InvalidRegion",
                .invalid_request => "InvalidRequest",
                .invalid_source_kms_key => "InvalidSourceKmsKey",
                .missing_file_cache_configuration => "MissingFileCacheConfiguration",
                .missing_file_system_configuration => "MissingFileSystemConfiguration",
                .missing_volume_configuration => "MissingVolumeConfiguration",
                .not_service_resource_error => "NotServiceResourceError",
                .resource_does_not_support_tagging => "ResourceDoesNotSupportTagging",
                .resource_not_found => "ResourceNotFound",
                .s3_access_point_attachment_not_found => "S3AccessPointAttachmentNotFound",
                .service_limit_exceeded => "ServiceLimitExceeded",
                .snapshot_not_found => "SnapshotNotFound",
                .source_backup_unavailable => "SourceBackupUnavailable",
                .storage_virtual_machine_not_found => "StorageVirtualMachineNotFound",
                .too_many_access_points => "TooManyAccessPoints",
                .unsupported_operation => "UnsupportedOperation",
                .volume_not_found => "VolumeNotFound",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_point_already_owned_by_you => |e| e.message,
                .active_directory_error => |e| e.message,
                .backup_being_copied => |e| e.message,
                .backup_in_progress => |e| e.message,
                .backup_not_found => |e| e.message,
                .backup_restoring => |e| e.message,
                .bad_request => |e| e.message,
                .data_repository_association_not_found => |e| e.message,
                .data_repository_task_ended => |e| e.message,
                .data_repository_task_executing => |e| e.message,
                .data_repository_task_not_found => |e| e.message,
                .file_cache_not_found => |e| e.message,
                .file_system_not_found => |e| e.message,
                .incompatible_parameter_error => |e| e.message,
                .incompatible_region_for_multi_az => |e| e.message,
                .internal_server_error => |e| e.message,
                .invalid_access_point => |e| e.message,
                .invalid_data_repository_type => |e| e.message,
                .invalid_destination_kms_key => |e| e.message,
                .invalid_export_path => |e| e.message,
                .invalid_import_path => |e| e.message,
                .invalid_network_settings => |e| e.message,
                .invalid_per_unit_storage_throughput => |e| e.message,
                .invalid_region => |e| e.message,
                .invalid_request => |e| e.message,
                .invalid_source_kms_key => |e| e.message,
                .missing_file_cache_configuration => |e| e.message,
                .missing_file_system_configuration => |e| e.message,
                .missing_volume_configuration => |e| e.message,
                .not_service_resource_error => |e| e.message,
                .resource_does_not_support_tagging => |e| e.message,
                .resource_not_found => |e| e.message,
                .s3_access_point_attachment_not_found => |e| e.message,
                .service_limit_exceeded => |e| e.message,
                .snapshot_not_found => |e| e.message,
                .source_backup_unavailable => |e| e.message,
                .storage_virtual_machine_not_found => |e| e.message,
                .too_many_access_points => |e| e.message,
                .unsupported_operation => |e| e.message,
                .volume_not_found => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_point_already_owned_by_you => 409,
                .active_directory_error => 400,
                .backup_being_copied => 400,
                .backup_in_progress => 400,
                .backup_not_found => 400,
                .backup_restoring => 400,
                .bad_request => 400,
                .data_repository_association_not_found => 400,
                .data_repository_task_ended => 400,
                .data_repository_task_executing => 400,
                .data_repository_task_not_found => 400,
                .file_cache_not_found => 400,
                .file_system_not_found => 400,
                .incompatible_parameter_error => 400,
                .incompatible_region_for_multi_az => 400,
                .internal_server_error => 500,
                .invalid_access_point => 400,
                .invalid_data_repository_type => 400,
                .invalid_destination_kms_key => 400,
                .invalid_export_path => 400,
                .invalid_import_path => 400,
                .invalid_network_settings => 400,
                .invalid_per_unit_storage_throughput => 400,
                .invalid_region => 400,
                .invalid_request => 400,
                .invalid_source_kms_key => 400,
                .missing_file_cache_configuration => 400,
                .missing_file_system_configuration => 400,
                .missing_volume_configuration => 400,
                .not_service_resource_error => 400,
                .resource_does_not_support_tagging => 400,
                .resource_not_found => 400,
                .s3_access_point_attachment_not_found => 400,
                .service_limit_exceeded => 400,
                .snapshot_not_found => 400,
                .source_backup_unavailable => 400,
                .storage_virtual_machine_not_found => 400,
                .too_many_access_points => 400,
                .unsupported_operation => 400,
                .volume_not_found => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_point_already_owned_by_you => |e| e.request_id,
                .active_directory_error => |e| e.request_id,
                .backup_being_copied => |e| e.request_id,
                .backup_in_progress => |e| e.request_id,
                .backup_not_found => |e| e.request_id,
                .backup_restoring => |e| e.request_id,
                .bad_request => |e| e.request_id,
                .data_repository_association_not_found => |e| e.request_id,
                .data_repository_task_ended => |e| e.request_id,
                .data_repository_task_executing => |e| e.request_id,
                .data_repository_task_not_found => |e| e.request_id,
                .file_cache_not_found => |e| e.request_id,
                .file_system_not_found => |e| e.request_id,
                .incompatible_parameter_error => |e| e.request_id,
                .incompatible_region_for_multi_az => |e| e.request_id,
                .internal_server_error => |e| e.request_id,
                .invalid_access_point => |e| e.request_id,
                .invalid_data_repository_type => |e| e.request_id,
                .invalid_destination_kms_key => |e| e.request_id,
                .invalid_export_path => |e| e.request_id,
                .invalid_import_path => |e| e.request_id,
                .invalid_network_settings => |e| e.request_id,
                .invalid_per_unit_storage_throughput => |e| e.request_id,
                .invalid_region => |e| e.request_id,
                .invalid_request => |e| e.request_id,
                .invalid_source_kms_key => |e| e.request_id,
                .missing_file_cache_configuration => |e| e.request_id,
                .missing_file_system_configuration => |e| e.request_id,
                .missing_volume_configuration => |e| e.request_id,
                .not_service_resource_error => |e| e.request_id,
                .resource_does_not_support_tagging => |e| e.request_id,
                .resource_not_found => |e| e.request_id,
                .s3_access_point_attachment_not_found => |e| e.request_id,
                .service_limit_exceeded => |e| e.request_id,
                .snapshot_not_found => |e| e.request_id,
                .source_backup_unavailable => |e| e.request_id,
                .storage_virtual_machine_not_found => |e| e.request_id,
                .too_many_access_points => |e| e.request_id,
                .unsupported_operation => |e| e.request_id,
                .volume_not_found => |e| e.request_id,
                .unknown => |e| e.request_id,
            };
        }
    };

    pub fn deinit(self: *ServiceError) void {
        if (self.arena) |*a| a.deinit();
    }

    pub fn code(self: ServiceError) []const u8 {
        return self.kind.code();
    }

    pub fn message(self: ServiceError) []const u8 {
        return self.kind.message();
    }

    pub fn httpStatus(self: ServiceError) u16 {
        return self.kind.httpStatus();
    }

    pub fn requestId(self: ServiceError) []const u8 {
        return self.kind.requestId();
    }
};

/// An access point with that name already exists in the Amazon Web Services
/// Region in your Amazon Web Services account.
pub const AccessPointAlreadyOwnedByYou = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// An error code indicating that an access point with that name already exists
    /// in the Amazon Web Services Region in your Amazon Web Services account.
    error_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .message = "Message",
    };
};

/// An Active Directory error.
pub const ActiveDirectoryError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The directory ID of the directory that an error pertains to.
    active_directory_id: []const u8,

    /// The type of Active Directory error.
    @"type": ?ActiveDirectoryErrorType = null,

    pub const json_field_names = .{
        .active_directory_id = "ActiveDirectoryId",
        .message = "Message",
        .@"type" = "Type",
    };
};

/// You can't delete a backup while it's being copied.
pub const BackupBeingCopied = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    backup_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_id = "BackupId",
        .message = "Message",
    };
};

/// Another backup is already under way. Wait for completion before initiating
/// additional backups of this file system.
pub const BackupInProgress = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// No Amazon FSx backups were found based upon the supplied parameters.
pub const BackupNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You can't delete a backup while it's being used to restore a file
/// system.
pub const BackupRestoring = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The ID of a file system being restored from the backup.
    file_system_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_system_id = "FileSystemId",
        .message = "Message",
    };
};

/// A generic error indicating a failure with a client request.
pub const BadRequest = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// No data repository associations were found based upon the supplied
/// parameters.
pub const DataRepositoryAssociationNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The data repository task could not be canceled because the task has already
/// ended.
pub const DataRepositoryTaskEnded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// An existing data repository task is currently executing on the file system.
/// Wait until the existing task has completed, then create the new task.
pub const DataRepositoryTaskExecuting = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The data repository task or tasks you specified could not be found.
pub const DataRepositoryTaskNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// No caches were found based upon supplied parameters.
pub const FileCacheNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// No Amazon FSx file systems were found based upon supplied parameters.
pub const FileSystemNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The error returned when a second request is received with the same client
/// request
/// token but different parameters settings. A client request token should
/// always uniquely
/// identify a single request.
pub const IncompatibleParameterError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// A parameter that is incompatible with the earlier request.
    parameter: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .parameter = "Parameter",
    };
};

/// Amazon FSx doesn't support Multi-AZ Windows File Server copy backup in the
/// destination Region, so the copied backup can't be restored.
pub const IncompatibleRegionForMultiAZ = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A generic error indicating a server-side failure.
pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The access point specified doesn't exist.
pub const InvalidAccessPoint = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// An error code indicating that the access point specified doesn't exist.
    error_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .message = "Message",
    };
};

/// You have filtered the response to a data repository type that is not
/// supported.
pub const InvalidDataRepositoryType = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The Key Management Service (KMS) key of the destination backup is not
/// valid.
pub const InvalidDestinationKmsKey = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The path provided for data repository export isn't valid.
pub const InvalidExportPath = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The path provided for data repository import isn't valid.
pub const InvalidImportPath = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// One or more network settings specified in the request are invalid.
pub const InvalidNetworkSettings = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The route table ID is either invalid or not part of the VPC specified.
    invalid_route_table_id: ?[]const u8 = null,

    /// The security group ID is either invalid or not part of the VPC specified.
    invalid_security_group_id: ?[]const u8 = null,

    /// The subnet ID that is either invalid or not part of the VPC specified.
    invalid_subnet_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .invalid_route_table_id = "InvalidRouteTableId",
        .invalid_security_group_id = "InvalidSecurityGroupId",
        .invalid_subnet_id = "InvalidSubnetId",
        .message = "Message",
    };
};

/// An invalid value for `PerUnitStorageThroughput` was provided. Please create
/// your file system again, using a valid value.
pub const InvalidPerUnitStorageThroughput = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The Region provided for `SourceRegion` is not valid or is in a different
/// Amazon Web Services partition.
pub const InvalidRegion = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The action or operation requested is invalid. Verify that the action is
/// typed correctly.
pub const InvalidRequest = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// An error code indicating that the action or operation requested is invalid.
    error_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .message = "Message",
    };
};

/// The Key Management Service (KMS) key of the source backup is not
/// valid.
pub const InvalidSourceKmsKey = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A cache configuration is required for this operation.
pub const MissingFileCacheConfiguration = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A file system configuration is required for this operation.
pub const MissingFileSystemConfiguration = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A volume configuration is required for this operation.
pub const MissingVolumeConfiguration = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource specified for the tagging operation is not a resource type
/// owned by
/// Amazon FSx. Use the API of the relevant service to perform the operation.
pub const NotServiceResourceError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The Amazon Resource Name (ARN) of the non-Amazon FSx resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .resource_arn = "ResourceARN",
    };
};

/// The resource specified does not support tagging.
pub const ResourceDoesNotSupportTagging = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The Amazon Resource Name (ARN) of the resource that doesn't support
    /// tagging.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .resource_arn = "ResourceARN",
    };
};

/// The resource specified by the Amazon Resource Name (ARN) can't be found.
pub const ResourceNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The resource ARN of the resource that can't be found.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .resource_arn = "ResourceARN",
    };
};

/// The access point specified was not found.
pub const S3AccessPointAttachmentNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// An error indicating that a particular service limit was exceeded. You can
/// increase
/// some service limits by contacting Amazon Web Services Support.
pub const ServiceLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Enumeration of the service limit that was exceeded.
    limit: ?ServiceLimit = null,

    pub const json_field_names = .{
        .limit = "Limit",
        .message = "Message",
    };
};

/// No Amazon FSx snapshots were found based on the supplied parameters.
pub const SnapshotNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was rejected because the lifecycle status of the source backup
/// isn't
/// `AVAILABLE`.
pub const SourceBackupUnavailable = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    backup_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_id = "BackupId",
        .message = "Message",
    };
};

/// No FSx for ONTAP SVMs were found based upon the supplied parameters.
pub const StorageVirtualMachineNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You have reached the maximum number of S3 access points attachments allowed
/// for your account in this Amazon Web Services Region, or for the file system.
/// For more information, or to request an increase,
/// see [Service quotas on FSx
/// resources](https://docs.aws.amazon.com/fsx/latest/OpenZFSGuide/limits.html)
/// in the FSx for OpenZFS User Guide.
pub const TooManyAccessPoints = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// An error code indicating that you have reached the maximum number of S3
    /// access points attachments allowed for your account in this Amazon Web
    /// Services Region, or for the file system.
    error_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .message = "Message",
    };
};

/// The requested operation is not supported for this resource or API.
pub const UnsupportedOperation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// No Amazon FSx volumes were found based upon the supplied parameters.
pub const VolumeNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};

/// Parse a service diagnostic. The caller must call deinit on the result.
pub fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) std.mem.Allocator.Error!ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessPointAlreadyOwnedByYou")) {
        const parsed_error: ?AccessPointAlreadyOwnedByYou = aws.json.parseJsonObject(AccessPointAlreadyOwnedByYou, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_point_already_owned_by_you = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ActiveDirectoryError")) {
        const parsed_error: ?ActiveDirectoryError = aws.json.parseJsonObject(ActiveDirectoryError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .active_directory_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BackupBeingCopied")) {
        const parsed_error: ?BackupBeingCopied = aws.json.parseJsonObject(BackupBeingCopied, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .backup_being_copied = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BackupInProgress")) {
        const parsed_error: ?BackupInProgress = aws.json.parseJsonObject(BackupInProgress, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .backup_in_progress = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BackupNotFound")) {
        const parsed_error: ?BackupNotFound = aws.json.parseJsonObject(BackupNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .backup_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BackupRestoring")) {
        const parsed_error: ?BackupRestoring = aws.json.parseJsonObject(BackupRestoring, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .backup_restoring = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BadRequest")) {
        const parsed_error: ?BadRequest = aws.json.parseJsonObject(BadRequest, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .bad_request = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DataRepositoryAssociationNotFound")) {
        const parsed_error: ?DataRepositoryAssociationNotFound = aws.json.parseJsonObject(DataRepositoryAssociationNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .data_repository_association_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DataRepositoryTaskEnded")) {
        const parsed_error: ?DataRepositoryTaskEnded = aws.json.parseJsonObject(DataRepositoryTaskEnded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .data_repository_task_ended = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DataRepositoryTaskExecuting")) {
        const parsed_error: ?DataRepositoryTaskExecuting = aws.json.parseJsonObject(DataRepositoryTaskExecuting, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .data_repository_task_executing = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DataRepositoryTaskNotFound")) {
        const parsed_error: ?DataRepositoryTaskNotFound = aws.json.parseJsonObject(DataRepositoryTaskNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .data_repository_task_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FileCacheNotFound")) {
        const parsed_error: ?FileCacheNotFound = aws.json.parseJsonObject(FileCacheNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .file_cache_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FileSystemNotFound")) {
        const parsed_error: ?FileSystemNotFound = aws.json.parseJsonObject(FileSystemNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .file_system_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IncompatibleParameterError")) {
        const parsed_error: ?IncompatibleParameterError = aws.json.parseJsonObject(IncompatibleParameterError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .incompatible_parameter_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IncompatibleRegionForMultiAZ")) {
        const parsed_error: ?IncompatibleRegionForMultiAZ = aws.json.parseJsonObject(IncompatibleRegionForMultiAZ, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .incompatible_region_for_multi_az = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        const parsed_error: ?InternalServerError = aws.json.parseJsonObject(InternalServerError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAccessPoint")) {
        const parsed_error: ?InvalidAccessPoint = aws.json.parseJsonObject(InvalidAccessPoint, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_access_point = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDataRepositoryType")) {
        const parsed_error: ?InvalidDataRepositoryType = aws.json.parseJsonObject(InvalidDataRepositoryType, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_data_repository_type = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDestinationKmsKey")) {
        const parsed_error: ?InvalidDestinationKmsKey = aws.json.parseJsonObject(InvalidDestinationKmsKey, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_destination_kms_key = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidExportPath")) {
        const parsed_error: ?InvalidExportPath = aws.json.parseJsonObject(InvalidExportPath, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_export_path = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidImportPath")) {
        const parsed_error: ?InvalidImportPath = aws.json.parseJsonObject(InvalidImportPath, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_import_path = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNetworkSettings")) {
        const parsed_error: ?InvalidNetworkSettings = aws.json.parseJsonObject(InvalidNetworkSettings, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_network_settings = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPerUnitStorageThroughput")) {
        const parsed_error: ?InvalidPerUnitStorageThroughput = aws.json.parseJsonObject(InvalidPerUnitStorageThroughput, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_per_unit_storage_throughput = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRegion")) {
        const parsed_error: ?InvalidRegion = aws.json.parseJsonObject(InvalidRegion, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_region = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRequest")) {
        const parsed_error: ?InvalidRequest = aws.json.parseJsonObject(InvalidRequest, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_request = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSourceKmsKey")) {
        const parsed_error: ?InvalidSourceKmsKey = aws.json.parseJsonObject(InvalidSourceKmsKey, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_source_kms_key = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MissingFileCacheConfiguration")) {
        const parsed_error: ?MissingFileCacheConfiguration = aws.json.parseJsonObject(MissingFileCacheConfiguration, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .missing_file_cache_configuration = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MissingFileSystemConfiguration")) {
        const parsed_error: ?MissingFileSystemConfiguration = aws.json.parseJsonObject(MissingFileSystemConfiguration, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .missing_file_system_configuration = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MissingVolumeConfiguration")) {
        const parsed_error: ?MissingVolumeConfiguration = aws.json.parseJsonObject(MissingVolumeConfiguration, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .missing_volume_configuration = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NotServiceResourceError")) {
        const parsed_error: ?NotServiceResourceError = aws.json.parseJsonObject(NotServiceResourceError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .not_service_resource_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceDoesNotSupportTagging")) {
        const parsed_error: ?ResourceDoesNotSupportTagging = aws.json.parseJsonObject(ResourceDoesNotSupportTagging, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_does_not_support_tagging = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        const parsed_error: ?ResourceNotFound = aws.json.parseJsonObject(ResourceNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "S3AccessPointAttachmentNotFound")) {
        const parsed_error: ?S3AccessPointAttachmentNotFound = aws.json.parseJsonObject(S3AccessPointAttachmentNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .s3_access_point_attachment_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceLimitExceeded")) {
        const parsed_error: ?ServiceLimitExceeded = aws.json.parseJsonObject(ServiceLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SnapshotNotFound")) {
        const parsed_error: ?SnapshotNotFound = aws.json.parseJsonObject(SnapshotNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .snapshot_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SourceBackupUnavailable")) {
        const parsed_error: ?SourceBackupUnavailable = aws.json.parseJsonObject(SourceBackupUnavailable, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .source_backup_unavailable = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "StorageVirtualMachineNotFound")) {
        const parsed_error: ?StorageVirtualMachineNotFound = aws.json.parseJsonObject(StorageVirtualMachineNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .storage_virtual_machine_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyAccessPoints")) {
        const parsed_error: ?TooManyAccessPoints = aws.json.parseJsonObject(TooManyAccessPoints, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_access_points = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperation")) {
        const parsed_error: ?UnsupportedOperation = aws.json.parseJsonObject(UnsupportedOperation, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_operation = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "VolumeNotFound")) {
        const parsed_error: ?VolumeNotFound = aws.json.parseJsonObject(VolumeNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .volume_not_found = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
