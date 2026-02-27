const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        concurrent_modification_exception: ConcurrentModificationException,
        conflicting_operation_exception: ConflictingOperationException,
        custom_metadata_limit_exceeded_exception: CustomMetadataLimitExceededException,
        deactivating_last_system_user_exception: DeactivatingLastSystemUserException,
        document_locked_for_comments_exception: DocumentLockedForCommentsException,
        draft_upload_out_of_sync_exception: DraftUploadOutOfSyncException,
        entity_already_exists_exception: EntityAlreadyExistsException,
        entity_not_exists_exception: EntityNotExistsException,
        failed_dependency_exception: FailedDependencyException,
        illegal_user_state_exception: IllegalUserStateException,
        invalid_argument_exception: InvalidArgumentException,
        invalid_comment_operation_exception: InvalidCommentOperationException,
        invalid_operation_exception: InvalidOperationException,
        invalid_password_exception: InvalidPasswordException,
        limit_exceeded_exception: LimitExceededException,
        prohibited_state_exception: ProhibitedStateException,
        requested_entity_too_large_exception: RequestedEntityTooLargeException,
        resource_already_checked_out_exception: ResourceAlreadyCheckedOutException,
        service_unavailable_exception: ServiceUnavailableException,
        storage_limit_exceeded_exception: StorageLimitExceededException,
        storage_limit_will_exceed_exception: StorageLimitWillExceedException,
        too_many_labels_exception: TooManyLabelsException,
        too_many_subscriptions_exception: TooManySubscriptionsException,
        unauthorized_operation_exception: UnauthorizedOperationException,
        unauthorized_resource_access_exception: UnauthorizedResourceAccessException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => "ConcurrentModificationException",
                .conflicting_operation_exception => "ConflictingOperationException",
                .custom_metadata_limit_exceeded_exception => "CustomMetadataLimitExceededException",
                .deactivating_last_system_user_exception => "DeactivatingLastSystemUserException",
                .document_locked_for_comments_exception => "DocumentLockedForCommentsException",
                .draft_upload_out_of_sync_exception => "DraftUploadOutOfSyncException",
                .entity_already_exists_exception => "EntityAlreadyExistsException",
                .entity_not_exists_exception => "EntityNotExistsException",
                .failed_dependency_exception => "FailedDependencyException",
                .illegal_user_state_exception => "IllegalUserStateException",
                .invalid_argument_exception => "InvalidArgumentException",
                .invalid_comment_operation_exception => "InvalidCommentOperationException",
                .invalid_operation_exception => "InvalidOperationException",
                .invalid_password_exception => "InvalidPasswordException",
                .limit_exceeded_exception => "LimitExceededException",
                .prohibited_state_exception => "ProhibitedStateException",
                .requested_entity_too_large_exception => "RequestedEntityTooLargeException",
                .resource_already_checked_out_exception => "ResourceAlreadyCheckedOutException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .storage_limit_exceeded_exception => "StorageLimitExceededException",
                .storage_limit_will_exceed_exception => "StorageLimitWillExceedException",
                .too_many_labels_exception => "TooManyLabelsException",
                .too_many_subscriptions_exception => "TooManySubscriptionsException",
                .unauthorized_operation_exception => "UnauthorizedOperationException",
                .unauthorized_resource_access_exception => "UnauthorizedResourceAccessException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.message,
                .conflicting_operation_exception => |e| e.message,
                .custom_metadata_limit_exceeded_exception => |e| e.message,
                .deactivating_last_system_user_exception => |e| e.message,
                .document_locked_for_comments_exception => |e| e.message,
                .draft_upload_out_of_sync_exception => |e| e.message,
                .entity_already_exists_exception => |e| e.message,
                .entity_not_exists_exception => |e| e.message,
                .failed_dependency_exception => |e| e.message,
                .illegal_user_state_exception => |e| e.message,
                .invalid_argument_exception => |e| e.message,
                .invalid_comment_operation_exception => |e| e.message,
                .invalid_operation_exception => |e| e.message,
                .invalid_password_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .prohibited_state_exception => |e| e.message,
                .requested_entity_too_large_exception => |e| e.message,
                .resource_already_checked_out_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .storage_limit_exceeded_exception => |e| e.message,
                .storage_limit_will_exceed_exception => |e| e.message,
                .too_many_labels_exception => |e| e.message,
                .too_many_subscriptions_exception => |e| e.message,
                .unauthorized_operation_exception => |e| e.message,
                .unauthorized_resource_access_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .concurrent_modification_exception => 409,
                .conflicting_operation_exception => 409,
                .custom_metadata_limit_exceeded_exception => 429,
                .deactivating_last_system_user_exception => 409,
                .document_locked_for_comments_exception => 409,
                .draft_upload_out_of_sync_exception => 409,
                .entity_already_exists_exception => 409,
                .entity_not_exists_exception => 404,
                .failed_dependency_exception => 424,
                .illegal_user_state_exception => 409,
                .invalid_argument_exception => 400,
                .invalid_comment_operation_exception => 409,
                .invalid_operation_exception => 405,
                .invalid_password_exception => 401,
                .limit_exceeded_exception => 409,
                .prohibited_state_exception => 409,
                .requested_entity_too_large_exception => 413,
                .resource_already_checked_out_exception => 409,
                .service_unavailable_exception => 503,
                .storage_limit_exceeded_exception => 409,
                .storage_limit_will_exceed_exception => 413,
                .too_many_labels_exception => 429,
                .too_many_subscriptions_exception => 429,
                .unauthorized_operation_exception => 403,
                .unauthorized_resource_access_exception => 404,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.request_id,
                .conflicting_operation_exception => |e| e.request_id,
                .custom_metadata_limit_exceeded_exception => |e| e.request_id,
                .deactivating_last_system_user_exception => |e| e.request_id,
                .document_locked_for_comments_exception => |e| e.request_id,
                .draft_upload_out_of_sync_exception => |e| e.request_id,
                .entity_already_exists_exception => |e| e.request_id,
                .entity_not_exists_exception => |e| e.request_id,
                .failed_dependency_exception => |e| e.request_id,
                .illegal_user_state_exception => |e| e.request_id,
                .invalid_argument_exception => |e| e.request_id,
                .invalid_comment_operation_exception => |e| e.request_id,
                .invalid_operation_exception => |e| e.request_id,
                .invalid_password_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .prohibited_state_exception => |e| e.request_id,
                .requested_entity_too_large_exception => |e| e.request_id,
                .resource_already_checked_out_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .storage_limit_exceeded_exception => |e| e.request_id,
                .storage_limit_will_exceed_exception => |e| e.request_id,
                .too_many_labels_exception => |e| e.request_id,
                .too_many_subscriptions_exception => |e| e.request_id,
                .unauthorized_operation_exception => |e| e.request_id,
                .unauthorized_resource_access_exception => |e| e.request_id,
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

pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictingOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CustomMetadataLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeactivatingLastSystemUserException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DocumentLockedForCommentsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DraftUploadOutOfSyncException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EntityAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EntityNotExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FailedDependencyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IllegalUserStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidArgumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCommentOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPasswordException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ProhibitedStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RequestedEntityTooLargeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceAlreadyCheckedOutException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StorageLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StorageLimitWillExceedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyLabelsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManySubscriptionsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnauthorizedOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnauthorizedResourceAccessException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
