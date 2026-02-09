const std = @import("std");

pub const ServiceError = union(enum) {
    backup_in_use_exception: BackupInUseException,
    backup_not_found_exception: BackupNotFoundException,
    conditional_check_failed_exception: ConditionalCheckFailedException,
    continuous_backups_unavailable_exception: ContinuousBackupsUnavailableException,
    duplicate_item_exception: DuplicateItemException,
    export_conflict_exception: ExportConflictException,
    export_not_found_exception: ExportNotFoundException,
    global_table_already_exists_exception: GlobalTableAlreadyExistsException,
    global_table_not_found_exception: GlobalTableNotFoundException,
    idempotent_parameter_mismatch_exception: IdempotentParameterMismatchException,
    import_conflict_exception: ImportConflictException,
    import_not_found_exception: ImportNotFoundException,
    index_not_found_exception: IndexNotFoundException,
    internal_server_error: InternalServerError,
    invalid_endpoint_exception: InvalidEndpointException,
    invalid_export_time_exception: InvalidExportTimeException,
    invalid_restore_time_exception: InvalidRestoreTimeException,
    item_collection_size_limit_exceeded_exception: ItemCollectionSizeLimitExceededException,
    limit_exceeded_exception: LimitExceededException,
    point_in_time_recovery_unavailable_exception: PointInTimeRecoveryUnavailableException,
    policy_not_found_exception: PolicyNotFoundException,
    provisioned_throughput_exceeded_exception: ProvisionedThroughputExceededException,
    replica_already_exists_exception: ReplicaAlreadyExistsException,
    replica_not_found_exception: ReplicaNotFoundException,
    replicated_write_conflict_exception: ReplicatedWriteConflictException,
    request_limit_exceeded: RequestLimitExceeded,
    resource_in_use_exception: ResourceInUseException,
    resource_not_found_exception: ResourceNotFoundException,
    table_already_exists_exception: TableAlreadyExistsException,
    table_in_use_exception: TableInUseException,
    table_not_found_exception: TableNotFoundException,
    throttling_exception: ThrottlingException,
    transaction_canceled_exception: TransactionCanceledException,
    transaction_conflict_exception: TransactionConflictException,
    transaction_in_progress_exception: TransactionInProgressException,
    unknown: UnknownServiceError,

    pub fn code(self: ServiceError) []const u8 {
        return switch (self) {
            .backup_in_use_exception => "BackupInUseException",
            .backup_not_found_exception => "BackupNotFoundException",
            .conditional_check_failed_exception => "ConditionalCheckFailedException",
            .continuous_backups_unavailable_exception => "ContinuousBackupsUnavailableException",
            .duplicate_item_exception => "DuplicateItemException",
            .export_conflict_exception => "ExportConflictException",
            .export_not_found_exception => "ExportNotFoundException",
            .global_table_already_exists_exception => "GlobalTableAlreadyExistsException",
            .global_table_not_found_exception => "GlobalTableNotFoundException",
            .idempotent_parameter_mismatch_exception => "IdempotentParameterMismatchException",
            .import_conflict_exception => "ImportConflictException",
            .import_not_found_exception => "ImportNotFoundException",
            .index_not_found_exception => "IndexNotFoundException",
            .internal_server_error => "InternalServerError",
            .invalid_endpoint_exception => "InvalidEndpointException",
            .invalid_export_time_exception => "InvalidExportTimeException",
            .invalid_restore_time_exception => "InvalidRestoreTimeException",
            .item_collection_size_limit_exceeded_exception => "ItemCollectionSizeLimitExceededException",
            .limit_exceeded_exception => "LimitExceededException",
            .point_in_time_recovery_unavailable_exception => "PointInTimeRecoveryUnavailableException",
            .policy_not_found_exception => "PolicyNotFoundException",
            .provisioned_throughput_exceeded_exception => "ProvisionedThroughputExceededException",
            .replica_already_exists_exception => "ReplicaAlreadyExistsException",
            .replica_not_found_exception => "ReplicaNotFoundException",
            .replicated_write_conflict_exception => "ReplicatedWriteConflictException",
            .request_limit_exceeded => "RequestLimitExceeded",
            .resource_in_use_exception => "ResourceInUseException",
            .resource_not_found_exception => "ResourceNotFoundException",
            .table_already_exists_exception => "TableAlreadyExistsException",
            .table_in_use_exception => "TableInUseException",
            .table_not_found_exception => "TableNotFoundException",
            .throttling_exception => "ThrottlingException",
            .transaction_canceled_exception => "TransactionCanceledException",
            .transaction_conflict_exception => "TransactionConflictException",
            .transaction_in_progress_exception => "TransactionInProgressException",
            .unknown => |e| e.code,
        };
    }

    pub fn message(self: ServiceError) []const u8 {
        return switch (self) {
            .backup_in_use_exception => |e| e.message,
            .backup_not_found_exception => |e| e.message,
            .conditional_check_failed_exception => |e| e.message,
            .continuous_backups_unavailable_exception => |e| e.message,
            .duplicate_item_exception => |e| e.message,
            .export_conflict_exception => |e| e.message,
            .export_not_found_exception => |e| e.message,
            .global_table_already_exists_exception => |e| e.message,
            .global_table_not_found_exception => |e| e.message,
            .idempotent_parameter_mismatch_exception => |e| e.message,
            .import_conflict_exception => |e| e.message,
            .import_not_found_exception => |e| e.message,
            .index_not_found_exception => |e| e.message,
            .internal_server_error => |e| e.message,
            .invalid_endpoint_exception => |e| e.message,
            .invalid_export_time_exception => |e| e.message,
            .invalid_restore_time_exception => |e| e.message,
            .item_collection_size_limit_exceeded_exception => |e| e.message,
            .limit_exceeded_exception => |e| e.message,
            .point_in_time_recovery_unavailable_exception => |e| e.message,
            .policy_not_found_exception => |e| e.message,
            .provisioned_throughput_exceeded_exception => |e| e.message,
            .replica_already_exists_exception => |e| e.message,
            .replica_not_found_exception => |e| e.message,
            .replicated_write_conflict_exception => |e| e.message,
            .request_limit_exceeded => |e| e.message,
            .resource_in_use_exception => |e| e.message,
            .resource_not_found_exception => |e| e.message,
            .table_already_exists_exception => |e| e.message,
            .table_in_use_exception => |e| e.message,
            .table_not_found_exception => |e| e.message,
            .throttling_exception => |e| e.message,
            .transaction_canceled_exception => |e| e.message,
            .transaction_conflict_exception => |e| e.message,
            .transaction_in_progress_exception => |e| e.message,
            .unknown => |e| e.message,
        };
    }

    pub fn httpStatus(self: ServiceError) u16 {
        return switch (self) {
            .backup_in_use_exception => 400,
            .backup_not_found_exception => 400,
            .conditional_check_failed_exception => 400,
            .continuous_backups_unavailable_exception => 400,
            .duplicate_item_exception => 400,
            .export_conflict_exception => 400,
            .export_not_found_exception => 400,
            .global_table_already_exists_exception => 400,
            .global_table_not_found_exception => 400,
            .idempotent_parameter_mismatch_exception => 400,
            .import_conflict_exception => 400,
            .import_not_found_exception => 400,
            .index_not_found_exception => 400,
            .internal_server_error => 500,
            .invalid_endpoint_exception => 421,
            .invalid_export_time_exception => 400,
            .invalid_restore_time_exception => 400,
            .item_collection_size_limit_exceeded_exception => 400,
            .limit_exceeded_exception => 400,
            .point_in_time_recovery_unavailable_exception => 400,
            .policy_not_found_exception => 400,
            .provisioned_throughput_exceeded_exception => 400,
            .replica_already_exists_exception => 400,
            .replica_not_found_exception => 400,
            .replicated_write_conflict_exception => 400,
            .request_limit_exceeded => 400,
            .resource_in_use_exception => 400,
            .resource_not_found_exception => 400,
            .table_already_exists_exception => 400,
            .table_in_use_exception => 400,
            .table_not_found_exception => 400,
            .throttling_exception => 400,
            .transaction_canceled_exception => 400,
            .transaction_conflict_exception => 400,
            .transaction_in_progress_exception => 400,
            .unknown => |e| e.http_status,
        };
    }

    pub fn requestId(self: ServiceError) []const u8 {
        return switch (self) {
            .backup_in_use_exception => |e| e.request_id,
            .backup_not_found_exception => |e| e.request_id,
            .conditional_check_failed_exception => |e| e.request_id,
            .continuous_backups_unavailable_exception => |e| e.request_id,
            .duplicate_item_exception => |e| e.request_id,
            .export_conflict_exception => |e| e.request_id,
            .export_not_found_exception => |e| e.request_id,
            .global_table_already_exists_exception => |e| e.request_id,
            .global_table_not_found_exception => |e| e.request_id,
            .idempotent_parameter_mismatch_exception => |e| e.request_id,
            .import_conflict_exception => |e| e.request_id,
            .import_not_found_exception => |e| e.request_id,
            .index_not_found_exception => |e| e.request_id,
            .internal_server_error => |e| e.request_id,
            .invalid_endpoint_exception => |e| e.request_id,
            .invalid_export_time_exception => |e| e.request_id,
            .invalid_restore_time_exception => |e| e.request_id,
            .item_collection_size_limit_exceeded_exception => |e| e.request_id,
            .limit_exceeded_exception => |e| e.request_id,
            .point_in_time_recovery_unavailable_exception => |e| e.request_id,
            .policy_not_found_exception => |e| e.request_id,
            .provisioned_throughput_exceeded_exception => |e| e.request_id,
            .replica_already_exists_exception => |e| e.request_id,
            .replica_not_found_exception => |e| e.request_id,
            .replicated_write_conflict_exception => |e| e.request_id,
            .request_limit_exceeded => |e| e.request_id,
            .resource_in_use_exception => |e| e.request_id,
            .resource_not_found_exception => |e| e.request_id,
            .table_already_exists_exception => |e| e.request_id,
            .table_in_use_exception => |e| e.request_id,
            .table_not_found_exception => |e| e.request_id,
            .throttling_exception => |e| e.request_id,
            .transaction_canceled_exception => |e| e.request_id,
            .transaction_conflict_exception => |e| e.request_id,
            .transaction_in_progress_exception => |e| e.request_id,
            .unknown => |e| e.request_id,
        };
    }
};

pub const BackupInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BackupNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConditionalCheckFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ContinuousBackupsUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateItemException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ExportConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ExportNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GlobalTableAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GlobalTableNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IdempotentParameterMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ImportConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ImportNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IndexNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidEndpointException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidExportTimeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRestoreTimeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ItemCollectionSizeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PointInTimeRecoveryUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ProvisionedThroughputExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReplicaAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReplicaNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReplicatedWriteConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RequestLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TableAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TableInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TableNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TransactionCanceledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TransactionConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TransactionInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
