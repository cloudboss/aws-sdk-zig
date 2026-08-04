const aws = @import("aws");
const std = @import("std");

const AttributeValue = @import("attribute_value.zig").AttributeValue;
const CancellationReason = @import("cancellation_reason.zig").CancellationReason;
const ThrottlingReason = @import("throttling_reason.zig").ThrottlingReason;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
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

        pub fn code(self: Kind) []const u8 {
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

        pub fn message(self: Kind) []const u8 {
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

        pub fn httpStatus(self: Kind) u16 {
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

        pub fn requestId(self: Kind) []const u8 {
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

/// There is another ongoing conflicting backup control plane operation on the
/// table.
/// The backup is either being created, deleted or restored to a table.
pub const BackupInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Backup not found for the given BackupARN.
pub const BackupNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A condition specified in the operation failed to be evaluated.
pub const ConditionalCheckFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Item which caused the `ConditionalCheckFailedException`.
    item: ?[]const aws.map.MapEntry(AttributeValue) = null,

    pub const json_field_names = .{
        .item = "Item",
        .message = "message",
    };
};

/// Backups have not yet been enabled for this table.
pub const ContinuousBackupsUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// There was an attempt to insert an item with the same primary key as an item
/// that
/// already exists in the DynamoDB table.
pub const DuplicateItemException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// There was a conflict when writing to the specified S3 bucket.
pub const ExportConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified export was not found.
pub const ExportNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified global table already exists.
pub const GlobalTableAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified global table does not exist.
pub const GlobalTableNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// DynamoDB rejected the request because you retried a request with a
/// different payload but with an idempotent token that was already used.
pub const IdempotentParameterMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// There was a conflict when importing from the specified S3 source. This can
/// occur when
/// the current import conflicts with a previous import request that had the
/// same client
/// token.
pub const ImportConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified import was not found.
pub const ImportNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation tried to access a nonexistent index.
pub const IndexNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An error occurred on the server side.
pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

pub const InvalidEndpointException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified `ExportTime` is outside of the point in time recovery
/// window.
pub const InvalidExportTimeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An invalid restore time was specified. RestoreDateTime must be between
/// EarliestRestorableDateTime and LatestRestorableDateTime.
pub const InvalidRestoreTimeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An item collection is too large. This exception is only returned for tables
/// that
/// have one or more local secondary indexes.
pub const ItemCollectionSizeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// There is no limit to the number of daily on-demand backups that can be
/// taken.
///
/// For most purposes, up to 500 simultaneous table operations are allowed per
/// account.
/// These operations include `CreateTable`, `UpdateTable`,
/// `DeleteTable`,`UpdateTimeToLive`,
/// `RestoreTableFromBackup`, and `RestoreTableToPointInTime`.
///
/// When you are creating a table with one or more secondary indexes, you can
/// have up
/// to 250 such requests running at a time. However, if the table or index
/// specifications
/// are complex, then DynamoDB might temporarily reduce the number of concurrent
/// operations.
///
/// When importing into DynamoDB, up to 50 simultaneous import table operations
/// are
/// allowed per account.
///
/// There is a soft account quota of 2,500 tables.
///
/// GetRecords was called with a value of more than 1000 for the limit request
/// parameter.
///
/// More than 2 processes are reading from the same streams shard at the same
/// time.
/// Exceeding this limit may result in request throttling.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Point in time recovery has not yet been enabled for this source table.
pub const PointInTimeRecoveryUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation tried to access a nonexistent resource-based policy.
///
/// If you specified an `ExpectedRevisionId`, it's possible that a policy is
/// present for the resource but its revision ID didn't match the expected
/// value.
pub const PolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was denied due to request throttling. For detailed information
/// about
/// why the request was throttled and the ARN of the impacted resource, find the
/// [ThrottlingReason](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_ThrottlingReason.html) field in the returned exception. The Amazon Web Services
/// SDKs for DynamoDB automatically retry requests that receive this exception.
/// Your request is eventually successful, unless your retry queue is too large
/// to finish.
/// Reduce the frequency of requests and use exponential backoff. For more
/// information, go
/// to [Error Retries and Exponential
/// Backoff](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html#Programming.Errors.RetryAndBackoff) in the *Amazon DynamoDB Developer Guide*.
pub const ProvisionedThroughputExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// A list of
    /// [ThrottlingReason](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_ThrottlingReason.html) that
    /// provide detailed diagnostic information about why the request was throttled.
    throttling_reasons: ?[]const ThrottlingReason = null,

    pub const json_field_names = .{
        .message = "message",
        .throttling_reasons = "ThrottlingReasons",
    };
};

/// The specified replica is already part of the global table.
pub const ReplicaAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified replica is no longer part of the global table.
pub const ReplicaNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because one or more items in the request are being
/// modified
/// by a request in another Region.
pub const ReplicatedWriteConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Throughput exceeds the current throughput quota for your account. For
/// detailed
/// information about why the request was throttled and the ARN of the impacted
/// resource,
/// find the
/// [ThrottlingReason](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_ThrottlingReason.html) field in the returned exception. Contact [Amazon Web Services Support](https://aws.amazon.com/support) to request a quota
/// increase.
pub const RequestLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// A list of
    /// [ThrottlingReason](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_ThrottlingReason.html) that
    /// provide detailed diagnostic information about why the request was throttled.
    throttling_reasons: ?[]const ThrottlingReason = null,

    pub const json_field_names = .{
        .message = "message",
        .throttling_reasons = "ThrottlingReasons",
    };
};

/// The operation conflicts with the resource's availability. For example:
///
/// * You attempted to recreate an existing table.
///
/// * You tried to delete a table currently in the `CREATING`
/// state.
///
/// * You tried to update a resource that was already being updated.
///
/// When appropriate, wait for the ongoing update to complete and attempt the
/// request
/// again.
pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation tried to access a nonexistent table or index. The resource
/// might not
/// be specified correctly, or its status might not be `ACTIVE`.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A target table with the specified name already exists.
pub const TableAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A target table with the specified name is either being created or deleted.
pub const TableInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A source table with the name `TableName` does not currently exist within
/// the subscriber's account or the subscriber is operating in the wrong Amazon
/// Web Services
/// Region.
pub const TableNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was denied due to request throttling. For detailed information
/// about why
/// the request was throttled and the ARN of the impacted resource, find the
/// [ThrottlingReason](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_ThrottlingReason.html) field in the returned exception.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// A list of
    /// [ThrottlingReason](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_ThrottlingReason.html) that
    /// provide detailed diagnostic information about why the request was throttled.
    throttling_reasons: ?[]const ThrottlingReason = null,

    pub const json_field_names = .{
        .message = "message",
        .throttling_reasons = "throttlingReasons",
    };
};

/// The entire transaction request was canceled.
///
/// DynamoDB cancels a `TransactWriteItems` request under the following
/// circumstances:
///
/// * A condition in one of the condition expressions is not met.
///
/// * A table in the `TransactWriteItems` request is in a different
/// account or region.
///
/// * More than one action in the `TransactWriteItems` operation
/// targets the same item.
///
/// * There is insufficient provisioned capacity for the transaction to be
/// completed.
///
/// * An item size becomes too large (larger than 400 KB), or a local secondary
/// index (LSI) becomes too large, or a similar validation error occurs because
/// of
/// changes made by the transaction.
///
/// * There is a user error, such as an invalid data format.
///
/// * There is an ongoing `TransactWriteItems` operation that
/// conflicts with a concurrent `TransactWriteItems` request. In this
/// case the `TransactWriteItems` operation fails with a
/// `TransactionCanceledException`.
///
/// DynamoDB cancels a `TransactGetItems` request under the
/// following circumstances:
///
/// * There is an ongoing `TransactGetItems` operation that conflicts
/// with a concurrent `PutItem`, `UpdateItem`,
/// `DeleteItem` or `TransactWriteItems` request. In this
/// case the `TransactGetItems` operation fails with a
/// `TransactionCanceledException`.
///
/// * A table in the `TransactGetItems` request is in a different
/// account or region.
///
/// * There is insufficient provisioned capacity for the transaction to be
/// completed.
///
/// * There is a user error, such as an invalid data format.
///
/// DynamoDB lists the cancellation reasons on the
/// `CancellationReasons` property. Transaction cancellation reasons are ordered
/// in the order of requested
/// items, if an item has no error it will have `None` code and
/// `Null` message.
///
/// Cancellation reason codes and possible error messages:
///
/// * No Errors:
///
/// * Code: `None`
///
/// * Message: `null`
///
/// * Conditional Check Failed:
///
/// * Code: `ConditionalCheckFailed`
///
/// * Message: The conditional request failed.
///
/// * Item Collection Size Limit Exceeded:
///
/// * Code: `ItemCollectionSizeLimitExceeded`
///
/// * Message: Collection size exceeded.
///
/// * Transaction Conflict:
///
/// * Code: `TransactionConflict`
///
/// * Message: Transaction is ongoing for the item.
///
/// * Provisioned Throughput Exceeded:
///
/// * Code: `ProvisionedThroughputExceeded`
///
/// * Messages:
///
/// * The level of configured provisioned throughput for the
/// table was exceeded. Consider increasing your provisioning level
/// with the UpdateTable API.
///
/// This Message is received when provisioned throughput is
/// exceeded is on a provisioned DynamoDB
/// table.
///
/// * The level of configured provisioned throughput for one or
/// more global secondary indexes of the table was exceeded.
/// Consider increasing your provisioning level for the
/// under-provisioned global secondary indexes with the UpdateTable
/// API.
///
/// This message is returned when provisioned throughput is
/// exceeded is on a provisioned GSI.
///
/// * Throttling Error:
///
/// * Code: `ThrottlingError`
///
/// * Messages:
///
/// * Throughput exceeds the current capacity of your table or
/// index. DynamoDB is automatically scaling your table or
/// index so please try again shortly. If exceptions persist, check
/// if you have a hot key:
/// https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/bp-partition-key-design.html.
///
/// This message is returned when writes get throttled on an
/// On-Demand table as DynamoDB is automatically
/// scaling the table.
///
/// * Throughput exceeds the current capacity for one or more
/// global secondary indexes. DynamoDB is automatically
/// scaling your index so please try again shortly.
///
/// This message is returned when writes get throttled on an
/// On-Demand GSI as DynamoDB is automatically scaling
/// the GSI.
///
/// * Validation Error:
///
/// * Code: `ValidationError`
///
/// * Messages:
///
/// * One or more parameter values were invalid.
///
/// * The update expression attempted to update the secondary
/// index key beyond allowed size limits.
///
/// * The update expression attempted to update the secondary
/// index key to unsupported type.
///
/// * An operand in the update expression has an incorrect data
/// type.
///
/// * Item size to update has exceeded the maximum allowed
/// size.
///
/// * Number overflow. Attempting to store a number with
/// magnitude larger than supported range.
///
/// * Type mismatch for attribute to update.
///
/// * Nesting Levels have exceeded supported limits.
///
/// * The document path provided in the update expression is
/// invalid for update.
///
/// * The provided expression refers to an attribute that does
/// not exist in the item.
pub const TransactionCanceledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// A list of cancellation reasons.
    cancellation_reasons: ?[]const CancellationReason = null,

    pub const json_field_names = .{
        .cancellation_reasons = "CancellationReasons",
        .message = "Message",
    };
};

/// Operation was rejected because there is an ongoing transaction for the
/// item.
pub const TransactionConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The transaction with the given request token is already in progress.
///
/// Recommended Settings
///
/// This is a general recommendation for handling the
/// `TransactionInProgressException`. These settings help ensure that the
/// client retries will trigger completion of the ongoing
/// `TransactWriteItems` request.
///
/// * Set `clientExecutionTimeout` to a value that allows at least one
/// retry to be processed after 5 seconds have elapsed since the first attempt
/// for
/// the `TransactWriteItems` operation.
///
/// * Set `socketTimeout` to a value a little lower than the
/// `requestTimeout` setting.
///
/// * `requestTimeout` should be set based on the time taken for the
/// individual retries of a single HTTP request for your use case, but setting
/// it to
/// 1 second or higher should work well to reduce chances of retries and
/// `TransactionInProgressException` errors.
///
/// * Use exponential backoff when retrying and tune backoff if needed.
///
/// Assuming [default retry
/// policy](https://github.com/aws/aws-sdk-java/blob/fd409dee8ae23fb8953e0bb4dbde65536a7e0514/aws-java-sdk-core/src/main/java/com/amazonaws/retry/PredefinedRetryPolicies.java#L97), example timeout settings based on the guidelines
/// above are as follows:
///
/// Example timeline:
///
/// * 0-1000 first attempt
///
/// * 1000-1500 first sleep/delay (default retry policy uses 500 ms as base
///   delay
/// for 4xx errors)
///
/// * 1500-2500 second attempt
///
/// * 2500-3500 second sleep/delay (500 * 2, exponential backoff)
///
/// * 3500-4500 third attempt
///
/// * 4500-6500 third sleep/delay (500 * 2^2)
///
/// * 6500-7500 fourth attempt (this can trigger inline recovery since 5 seconds
/// have elapsed since the first attempt reached TC)
pub const TransactionInProgressException = struct {
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
