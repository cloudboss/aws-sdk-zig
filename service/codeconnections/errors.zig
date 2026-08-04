const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        concurrent_modification_exception: ConcurrentModificationException,
        conditional_check_failed_exception: ConditionalCheckFailedException,
        conflict_exception: ConflictException,
        internal_server_exception: InternalServerException,
        invalid_input_exception: InvalidInputException,
        limit_exceeded_exception: LimitExceededException,
        resource_already_exists_exception: ResourceAlreadyExistsException,
        resource_not_found_exception: ResourceNotFoundException,
        resource_unavailable_exception: ResourceUnavailableException,
        retry_latest_commit_failed_exception: RetryLatestCommitFailedException,
        sync_blocker_does_not_exist_exception: SyncBlockerDoesNotExistException,
        sync_configuration_still_exists_exception: SyncConfigurationStillExistsException,
        throttling_exception: ThrottlingException,
        unsupported_operation_exception: UnsupportedOperationException,
        unsupported_provider_type_exception: UnsupportedProviderTypeException,
        update_out_of_sync_exception: UpdateOutOfSyncException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .concurrent_modification_exception => "ConcurrentModificationException",
                .conditional_check_failed_exception => "ConditionalCheckFailedException",
                .conflict_exception => "ConflictException",
                .internal_server_exception => "InternalServerException",
                .invalid_input_exception => "InvalidInputException",
                .limit_exceeded_exception => "LimitExceededException",
                .resource_already_exists_exception => "ResourceAlreadyExistsException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .resource_unavailable_exception => "ResourceUnavailableException",
                .retry_latest_commit_failed_exception => "RetryLatestCommitFailedException",
                .sync_blocker_does_not_exist_exception => "SyncBlockerDoesNotExistException",
                .sync_configuration_still_exists_exception => "SyncConfigurationStillExistsException",
                .throttling_exception => "ThrottlingException",
                .unsupported_operation_exception => "UnsupportedOperationException",
                .unsupported_provider_type_exception => "UnsupportedProviderTypeException",
                .update_out_of_sync_exception => "UpdateOutOfSyncException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .concurrent_modification_exception => |e| e.message,
                .conditional_check_failed_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .invalid_input_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .resource_already_exists_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .resource_unavailable_exception => |e| e.message,
                .retry_latest_commit_failed_exception => |e| e.message,
                .sync_blocker_does_not_exist_exception => |e| e.message,
                .sync_configuration_still_exists_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unsupported_operation_exception => |e| e.message,
                .unsupported_provider_type_exception => |e| e.message,
                .update_out_of_sync_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .concurrent_modification_exception => 409,
                .conditional_check_failed_exception => 409,
                .conflict_exception => 409,
                .internal_server_exception => 503,
                .invalid_input_exception => 400,
                .limit_exceeded_exception => 429,
                .resource_already_exists_exception => 409,
                .resource_not_found_exception => 404,
                .resource_unavailable_exception => 400,
                .retry_latest_commit_failed_exception => 503,
                .sync_blocker_does_not_exist_exception => 404,
                .sync_configuration_still_exists_exception => 409,
                .throttling_exception => 429,
                .unsupported_operation_exception => 400,
                .unsupported_provider_type_exception => 400,
                .update_out_of_sync_exception => 409,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .concurrent_modification_exception => |e| e.request_id,
                .conditional_check_failed_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .invalid_input_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .resource_already_exists_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .resource_unavailable_exception => |e| e.request_id,
                .retry_latest_commit_failed_exception => |e| e.request_id,
                .sync_blocker_does_not_exist_exception => |e| e.request_id,
                .sync_configuration_still_exists_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .unsupported_operation_exception => |e| e.request_id,
                .unsupported_provider_type_exception => |e| e.request_id,
                .update_out_of_sync_exception => |e| e.request_id,
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

/// You do not have sufficient access to perform this action.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Exception thrown as a result of concurrent modification to an application.
/// For example, two individuals attempting to edit the same application at the
/// same time.
pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The conditional check failed. Try again later.
pub const ConditionalCheckFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Two conflicting operations have been made on the same resource.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Received an internal server exception. Try again later.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The input is not valid. Verify that the action is typed correctly.
pub const InvalidInputException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Exceeded the maximum limit for connections.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Unable to create resource. Resource already exists.
pub const ResourceAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Resource not found. Verify the connection resource ARN and try again.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Resource not found. Verify the ARN for the host resource and try again.
pub const ResourceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Retrying the latest commit failed. Try again later.
pub const RetryLatestCommitFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Unable to continue. The sync blocker does not exist.
pub const SyncBlockerDoesNotExistException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Unable to continue. The sync blocker still exists.
pub const SyncConfigurationStillExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was denied due to request throttling.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The operation is not supported. Check the connection status and try again.
pub const UnsupportedOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified provider type is not supported for connections.
pub const UnsupportedProviderTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The update is out of sync. Try syncing again.
pub const UpdateOutOfSyncException = struct {
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
