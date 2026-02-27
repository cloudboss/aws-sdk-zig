const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        already_exists_exception: AlreadyExistsException,
        concurrent_modification_exception: ConcurrentModificationException,
        conflict_exception: ConflictException,
        entity_not_found_exception: EntityNotFoundException,
        expired_exception: ExpiredException,
        glue_encryption_exception: GlueEncryptionException,
        internal_service_exception: InternalServiceException,
        invalid_input_exception: InvalidInputException,
        operation_timeout_exception: OperationTimeoutException,
        permission_type_mismatch_exception: PermissionTypeMismatchException,
        resource_not_ready_exception: ResourceNotReadyException,
        resource_number_limit_exceeded_exception: ResourceNumberLimitExceededException,
        statistics_not_ready_yet_exception: StatisticsNotReadyYetException,
        throttled_exception: ThrottledException,
        transaction_canceled_exception: TransactionCanceledException,
        transaction_commit_in_progress_exception: TransactionCommitInProgressException,
        transaction_committed_exception: TransactionCommittedException,
        work_units_not_ready_yet_exception: WorkUnitsNotReadyYetException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .already_exists_exception => "AlreadyExistsException",
                .concurrent_modification_exception => "ConcurrentModificationException",
                .conflict_exception => "ConflictException",
                .entity_not_found_exception => "EntityNotFoundException",
                .expired_exception => "ExpiredException",
                .glue_encryption_exception => "GlueEncryptionException",
                .internal_service_exception => "InternalServiceException",
                .invalid_input_exception => "InvalidInputException",
                .operation_timeout_exception => "OperationTimeoutException",
                .permission_type_mismatch_exception => "PermissionTypeMismatchException",
                .resource_not_ready_exception => "ResourceNotReadyException",
                .resource_number_limit_exceeded_exception => "ResourceNumberLimitExceededException",
                .statistics_not_ready_yet_exception => "StatisticsNotReadyYetException",
                .throttled_exception => "ThrottledException",
                .transaction_canceled_exception => "TransactionCanceledException",
                .transaction_commit_in_progress_exception => "TransactionCommitInProgressException",
                .transaction_committed_exception => "TransactionCommittedException",
                .work_units_not_ready_yet_exception => "WorkUnitsNotReadyYetException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .already_exists_exception => |e| e.message,
                .concurrent_modification_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .entity_not_found_exception => |e| e.message,
                .expired_exception => |e| e.message,
                .glue_encryption_exception => |e| e.message,
                .internal_service_exception => |e| e.message,
                .invalid_input_exception => |e| e.message,
                .operation_timeout_exception => |e| e.message,
                .permission_type_mismatch_exception => |e| e.message,
                .resource_not_ready_exception => |e| e.message,
                .resource_number_limit_exceeded_exception => |e| e.message,
                .statistics_not_ready_yet_exception => |e| e.message,
                .throttled_exception => |e| e.message,
                .transaction_canceled_exception => |e| e.message,
                .transaction_commit_in_progress_exception => |e| e.message,
                .transaction_committed_exception => |e| e.message,
                .work_units_not_ready_yet_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .already_exists_exception => 400,
                .concurrent_modification_exception => 400,
                .conflict_exception => 400,
                .entity_not_found_exception => 400,
                .expired_exception => 410,
                .glue_encryption_exception => 400,
                .internal_service_exception => 500,
                .invalid_input_exception => 400,
                .operation_timeout_exception => 400,
                .permission_type_mismatch_exception => 400,
                .resource_not_ready_exception => 400,
                .resource_number_limit_exceeded_exception => 400,
                .statistics_not_ready_yet_exception => 420,
                .throttled_exception => 429,
                .transaction_canceled_exception => 400,
                .transaction_commit_in_progress_exception => 400,
                .transaction_committed_exception => 400,
                .work_units_not_ready_yet_exception => 420,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .already_exists_exception => |e| e.request_id,
                .concurrent_modification_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .entity_not_found_exception => |e| e.request_id,
                .expired_exception => |e| e.request_id,
                .glue_encryption_exception => |e| e.request_id,
                .internal_service_exception => |e| e.request_id,
                .invalid_input_exception => |e| e.request_id,
                .operation_timeout_exception => |e| e.request_id,
                .permission_type_mismatch_exception => |e| e.request_id,
                .resource_not_ready_exception => |e| e.request_id,
                .resource_number_limit_exceeded_exception => |e| e.request_id,
                .statistics_not_ready_yet_exception => |e| e.request_id,
                .throttled_exception => |e| e.request_id,
                .transaction_canceled_exception => |e| e.request_id,
                .transaction_commit_in_progress_exception => |e| e.request_id,
                .transaction_committed_exception => |e| e.request_id,
                .work_units_not_ready_yet_exception => |e| e.request_id,
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

pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EntityNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ExpiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GlueEncryptionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidInputException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationTimeoutException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PermissionTypeMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotReadyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNumberLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StatisticsNotReadyYetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TransactionCanceledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TransactionCommitInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TransactionCommittedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WorkUnitsNotReadyYetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
