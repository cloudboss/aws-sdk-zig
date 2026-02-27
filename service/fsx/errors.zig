const std = @import("std");

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

pub const AccessPointAlreadyOwnedByYou = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ActiveDirectoryError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BackupBeingCopied = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BackupInProgress = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BackupNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BackupRestoring = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BadRequest = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DataRepositoryAssociationNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DataRepositoryTaskEnded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DataRepositoryTaskExecuting = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DataRepositoryTaskNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FileCacheNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FileSystemNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IncompatibleParameterError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IncompatibleRegionForMultiAZ = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAccessPoint = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDataRepositoryType = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDestinationKmsKey = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidExportPath = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidImportPath = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNetworkSettings = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPerUnitStorageThroughput = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRegion = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequest = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSourceKmsKey = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MissingFileCacheConfiguration = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MissingFileSystemConfiguration = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MissingVolumeConfiguration = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotServiceResourceError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceDoesNotSupportTagging = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const S3AccessPointAttachmentNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SnapshotNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SourceBackupUnavailable = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StorageVirtualMachineNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyAccessPoints = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedOperation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const VolumeNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
