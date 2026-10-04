const aws = @import("aws");
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntityNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .entity_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExpiredException")) {
        return .{ .arena = arena, .kind = .{ .expired_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GlueEncryptionException")) {
        return .{ .arena = arena, .kind = .{ .glue_encryption_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .operation_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PermissionTypeMismatchException")) {
        return .{ .arena = arena, .kind = .{ .permission_type_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNumberLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_number_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StatisticsNotReadyYetException")) {
        return .{ .arena = arena, .kind = .{ .statistics_not_ready_yet_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottledException")) {
        return .{ .arena = arena, .kind = .{ .throttled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TransactionCanceledException")) {
        return .{ .arena = arena, .kind = .{ .transaction_canceled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TransactionCommitInProgressException")) {
        return .{ .arena = arena, .kind = .{ .transaction_commit_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TransactionCommittedException")) {
        return .{ .arena = arena, .kind = .{ .transaction_committed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WorkUnitsNotReadyYetException")) {
        return .{ .arena = arena, .kind = .{ .work_units_not_ready_yet_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
