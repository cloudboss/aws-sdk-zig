const std = @import("std");

pub const ServiceError = union(enum) {
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

    pub fn code(self: ServiceError) []const u8 {
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

    pub fn message(self: ServiceError) []const u8 {
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

    pub fn httpStatus(self: ServiceError) u16 {
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

    pub fn requestId(self: ServiceError) []const u8 {
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

    pub fn deinit(self: *ServiceError) void {
        switch (self.*) {
            .unknown => |e| {
                if (e._allocator) |a| {
                    a.free(e.code);
                    a.free(e.message);
                    a.free(e.request_id);
                }
            },
            inline else => |e| {
                if (e._allocator) |a| {
                    a.free(e.message);
                    a.free(e.request_id);
                }
            },
        }
    }
};

pub const BatchEntryIdsNotDistinct = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const BatchRequestTooLong = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const EmptyBatchRequest = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const InvalidAddress = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const InvalidAttributeName = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const InvalidAttributeValue = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const InvalidBatchEntryId = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const InvalidIdFormat = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const InvalidMessageContents = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const InvalidSecurity = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const KmsAccessDenied = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const KmsDisabled = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const KmsInvalidKeyUsage = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const KmsInvalidState = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const KmsNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const KmsOptInRequired = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const KmsThrottled = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const MessageNotInflight = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const OverLimit = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const PurgeQueueInProgress = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const QueueDeletedRecently = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const QueueDoesNotExist = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const QueueNameExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const ReceiptHandleIsInvalid = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const RequestThrottled = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const TooManyEntriesInBatchRequest = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const UnsupportedOperation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
    _allocator: ?std.mem.Allocator = null,
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
    _allocator: ?std.mem.Allocator = null,
};
