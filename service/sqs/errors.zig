const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        batch_entry_ids_not_distinct: BatchEntryIdsNotDistinct,
        batch_request_too_long: BatchRequestTooLong,
        empty_batch_request: EmptyBatchRequest,
        invalid_address: InvalidAddress,
        invalid_attribute_name: InvalidAttributeName,
        invalid_attribute_value: InvalidAttributeValue,
        invalid_batch_entry_id: InvalidBatchEntryId,
        invalid_id_format: InvalidIdFormat,
        invalid_message_contents: InvalidMessageContents,
        invalid_security: InvalidSecurity,
        kms_access_denied: KmsAccessDenied,
        kms_disabled: KmsDisabled,
        kms_invalid_key_usage: KmsInvalidKeyUsage,
        kms_invalid_state: KmsInvalidState,
        kms_not_found: KmsNotFound,
        kms_opt_in_required: KmsOptInRequired,
        kms_throttled: KmsThrottled,
        message_not_inflight: MessageNotInflight,
        over_limit: OverLimit,
        purge_queue_in_progress: PurgeQueueInProgress,
        queue_deleted_recently: QueueDeletedRecently,
        queue_does_not_exist: QueueDoesNotExist,
        queue_name_exists: QueueNameExists,
        receipt_handle_is_invalid: ReceiptHandleIsInvalid,
        request_throttled: RequestThrottled,
        resource_not_found_exception: ResourceNotFoundException,
        too_many_entries_in_batch_request: TooManyEntriesInBatchRequest,
        unsupported_operation: UnsupportedOperation,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .batch_entry_ids_not_distinct => "BatchEntryIdsNotDistinct",
                .batch_request_too_long => "BatchRequestTooLong",
                .empty_batch_request => "EmptyBatchRequest",
                .invalid_address => "InvalidAddress",
                .invalid_attribute_name => "InvalidAttributeName",
                .invalid_attribute_value => "InvalidAttributeValue",
                .invalid_batch_entry_id => "InvalidBatchEntryId",
                .invalid_id_format => "InvalidIdFormat",
                .invalid_message_contents => "InvalidMessageContents",
                .invalid_security => "InvalidSecurity",
                .kms_access_denied => "KmsAccessDenied",
                .kms_disabled => "KmsDisabled",
                .kms_invalid_key_usage => "KmsInvalidKeyUsage",
                .kms_invalid_state => "KmsInvalidState",
                .kms_not_found => "KmsNotFound",
                .kms_opt_in_required => "KmsOptInRequired",
                .kms_throttled => "KmsThrottled",
                .message_not_inflight => "MessageNotInflight",
                .over_limit => "OverLimit",
                .purge_queue_in_progress => "PurgeQueueInProgress",
                .queue_deleted_recently => "QueueDeletedRecently",
                .queue_does_not_exist => "QueueDoesNotExist",
                .queue_name_exists => "QueueNameExists",
                .receipt_handle_is_invalid => "ReceiptHandleIsInvalid",
                .request_throttled => "RequestThrottled",
                .resource_not_found_exception => "ResourceNotFoundException",
                .too_many_entries_in_batch_request => "TooManyEntriesInBatchRequest",
                .unsupported_operation => "UnsupportedOperation",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .batch_entry_ids_not_distinct => |e| e.message,
                .batch_request_too_long => |e| e.message,
                .empty_batch_request => |e| e.message,
                .invalid_address => |e| e.message,
                .invalid_attribute_name => |e| e.message,
                .invalid_attribute_value => |e| e.message,
                .invalid_batch_entry_id => |e| e.message,
                .invalid_id_format => |e| e.message,
                .invalid_message_contents => |e| e.message,
                .invalid_security => |e| e.message,
                .kms_access_denied => |e| e.message,
                .kms_disabled => |e| e.message,
                .kms_invalid_key_usage => |e| e.message,
                .kms_invalid_state => |e| e.message,
                .kms_not_found => |e| e.message,
                .kms_opt_in_required => |e| e.message,
                .kms_throttled => |e| e.message,
                .message_not_inflight => |e| e.message,
                .over_limit => |e| e.message,
                .purge_queue_in_progress => |e| e.message,
                .queue_deleted_recently => |e| e.message,
                .queue_does_not_exist => |e| e.message,
                .queue_name_exists => |e| e.message,
                .receipt_handle_is_invalid => |e| e.message,
                .request_throttled => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .too_many_entries_in_batch_request => |e| e.message,
                .unsupported_operation => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .batch_entry_ids_not_distinct => 400,
                .batch_request_too_long => 400,
                .empty_batch_request => 400,
                .invalid_address => 404,
                .invalid_attribute_name => 400,
                .invalid_attribute_value => 400,
                .invalid_batch_entry_id => 400,
                .invalid_id_format => 400,
                .invalid_message_contents => 400,
                .invalid_security => 403,
                .kms_access_denied => 400,
                .kms_disabled => 400,
                .kms_invalid_key_usage => 400,
                .kms_invalid_state => 400,
                .kms_not_found => 400,
                .kms_opt_in_required => 403,
                .kms_throttled => 400,
                .message_not_inflight => 400,
                .over_limit => 403,
                .purge_queue_in_progress => 403,
                .queue_deleted_recently => 400,
                .queue_does_not_exist => 400,
                .queue_name_exists => 400,
                .receipt_handle_is_invalid => 404,
                .request_throttled => 403,
                .resource_not_found_exception => 404,
                .too_many_entries_in_batch_request => 400,
                .unsupported_operation => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .batch_entry_ids_not_distinct => |e| e.request_id,
                .batch_request_too_long => |e| e.request_id,
                .empty_batch_request => |e| e.request_id,
                .invalid_address => |e| e.request_id,
                .invalid_attribute_name => |e| e.request_id,
                .invalid_attribute_value => |e| e.request_id,
                .invalid_batch_entry_id => |e| e.request_id,
                .invalid_id_format => |e| e.request_id,
                .invalid_message_contents => |e| e.request_id,
                .invalid_security => |e| e.request_id,
                .kms_access_denied => |e| e.request_id,
                .kms_disabled => |e| e.request_id,
                .kms_invalid_key_usage => |e| e.request_id,
                .kms_invalid_state => |e| e.request_id,
                .kms_not_found => |e| e.request_id,
                .kms_opt_in_required => |e| e.request_id,
                .kms_throttled => |e| e.request_id,
                .message_not_inflight => |e| e.request_id,
                .over_limit => |e| e.request_id,
                .purge_queue_in_progress => |e| e.request_id,
                .queue_deleted_recently => |e| e.request_id,
                .queue_does_not_exist => |e| e.request_id,
                .queue_name_exists => |e| e.request_id,
                .receipt_handle_is_invalid => |e| e.request_id,
                .request_throttled => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .too_many_entries_in_batch_request => |e| e.request_id,
                .unsupported_operation => |e| e.request_id,
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

/// Two or more batch entries in the request have the same `Id`.
pub const BatchEntryIdsNotDistinct = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The length of all the messages put together is more than the limit.
pub const BatchRequestTooLong = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The batch request doesn't contain any entries.
pub const EmptyBatchRequest = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified ID is invalid.
pub const InvalidAddress = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified attribute doesn't exist.
pub const InvalidAttributeName = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A queue attribute value is invalid.
pub const InvalidAttributeValue = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The `Id` of a batch entry in a batch request doesn't abide by the
/// specification.
pub const InvalidBatchEntryId = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified receipt handle isn't valid for the current version.
pub const InvalidIdFormat = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

/// The message contains characters outside the allowed set.
pub const InvalidMessageContents = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was not made over HTTPS or did not use SigV4 for signing.
pub const InvalidSecurity = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The caller doesn't have the required KMS access.
pub const KmsAccessDenied = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was denied due to request throttling.
pub const KmsDisabled = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected for one of the following reasons:
///
/// * The KeyUsage value of the KMS key is incompatible with the API
/// operation.
///
/// * The encryption algorithm or signing algorithm specified for the operation
///   is
/// incompatible with the type of key material in the KMS key (KeySpec).
pub const KmsInvalidKeyUsage = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the state of the specified resource is not
/// valid for
/// this request.
pub const KmsInvalidState = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the specified entity or resource could not
/// be found.
pub const KmsNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the specified key policy isn't
/// syntactically or
/// semantically correct.
pub const KmsOptInRequired = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Amazon Web Services KMS throttles requests for the following conditions.
pub const KmsThrottled = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified message isn't in flight.
pub const MessageNotInflight = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

/// The specified action violates a limit. For example, `ReceiveMessage`
/// returns this error if the maximum number of in flight messages is reached
/// and
/// `AddPermission` returns this error if the maximum number of permissions
/// for the queue is reached.
pub const OverLimit = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Indicates that the specified queue previously received a `PurgeQueue`
/// request within the last 60 seconds (the time it can take to delete the
/// messages in the
/// queue).
pub const PurgeQueueInProgress = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You must wait 60 seconds after deleting a queue before you can create
/// another queue
/// with the same name.
pub const QueueDeletedRecently = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Ensure that the `QueueUrl` is correct and that the queue has not been
/// deleted.
pub const QueueDoesNotExist = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A queue with this name already exists. Amazon SQS returns this error only if
/// the request
/// includes attributes whose values differ from those of the existing queue.
pub const QueueNameExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified receipt handle isn't valid.
pub const ReceiptHandleIsInvalid = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was denied due to request throttling.
///
/// * Exceeds the permitted request rate for the queue or for the recipient of
///   the
/// request.
///
/// * Ensure that the request rate is within the Amazon SQS limits for
/// sending messages. For more information, see [Amazon SQS
/// quotas](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-quotas.html#quotas-requests) in the *Amazon SQS
/// Developer Guide*.
pub const RequestThrottled = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// One or more specified resources don't exist.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The batch request contains more entries than permissible. For Amazon SQS,
/// the
/// maximum number of entries you can include in a single
/// [SendMessageBatch](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SendMessageBatch.html), [DeleteMessageBatch](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_DeleteMessageBatch.html), or [ChangeMessageVisibilityBatch](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_ChangeMessageVisibilityBatch.html) request is 10.
pub const TooManyEntriesInBatchRequest = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Error code 400. Unsupported operation.
pub const UnsupportedOperation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
