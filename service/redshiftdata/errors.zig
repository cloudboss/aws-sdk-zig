const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        active_sessions_exceeded_exception: ActiveSessionsExceededException,
        active_statements_exceeded_exception: ActiveStatementsExceededException,
        active_waiting_requests_exceeded_exception: ActiveWaitingRequestsExceededException,
        batch_execute_statement_exception: BatchExecuteStatementException,
        database_connection_exception: DatabaseConnectionException,
        execute_statement_exception: ExecuteStatementException,
        internal_server_exception: InternalServerException,
        query_timeout_exception: QueryTimeoutException,
        resource_not_found_exception: ResourceNotFoundException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .active_sessions_exceeded_exception => "ActiveSessionsExceededException",
                .active_statements_exceeded_exception => "ActiveStatementsExceededException",
                .active_waiting_requests_exceeded_exception => "ActiveWaitingRequestsExceededException",
                .batch_execute_statement_exception => "BatchExecuteStatementException",
                .database_connection_exception => "DatabaseConnectionException",
                .execute_statement_exception => "ExecuteStatementException",
                .internal_server_exception => "InternalServerException",
                .query_timeout_exception => "QueryTimeoutException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .active_sessions_exceeded_exception => |e| e.message,
                .active_statements_exceeded_exception => |e| e.message,
                .active_waiting_requests_exceeded_exception => |e| e.message,
                .batch_execute_statement_exception => |e| e.message,
                .database_connection_exception => |e| e.message,
                .execute_statement_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .query_timeout_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .active_sessions_exceeded_exception => 400,
                .active_statements_exceeded_exception => 400,
                .active_waiting_requests_exceeded_exception => 400,
                .batch_execute_statement_exception => 500,
                .database_connection_exception => 500,
                .execute_statement_exception => 500,
                .internal_server_exception => 500,
                .query_timeout_exception => 400,
                .resource_not_found_exception => 404,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .active_sessions_exceeded_exception => |e| e.request_id,
                .active_statements_exceeded_exception => |e| e.request_id,
                .active_waiting_requests_exceeded_exception => |e| e.request_id,
                .batch_execute_statement_exception => |e| e.request_id,
                .database_connection_exception => |e| e.request_id,
                .execute_statement_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .query_timeout_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .validation_exception => |e| e.request_id,
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

/// The Amazon Redshift Data API operation failed because the maximum number of
/// active sessions exceeded.
pub const ActiveSessionsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The number of active statements exceeds the limit.
pub const ActiveStatementsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The number of active requests with `WaitTimeSeconds` for the same SQL
/// statement exceeds the limit.
pub const ActiveWaitingRequestsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// An SQL statement encountered an environmental error while running.
pub const BatchExecuteStatementException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Statement identifier of the exception.
    statement_id: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .statement_id = "StatementId",
    };
};

/// Connection to a database failed.
pub const DatabaseConnectionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The SQL statement encountered an environmental error while running.
pub const ExecuteStatementException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Statement identifier of the exception.
    statement_id: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .statement_id = "StatementId",
    };
};

/// The Amazon Redshift Data API operation failed due to invalid input.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The Amazon Redshift Data API operation failed due to timeout.
pub const QueryTimeoutException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The Amazon Redshift Data API operation failed due to a missing resource.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Resource identifier associated with the exception.
    resource_id: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .resource_id = "ResourceId",
    };
};

/// The Amazon Redshift Data API operation failed due to invalid input.
pub const ValidationException = struct {
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

    if (std.mem.eql(u8, error_code, "ActiveSessionsExceededException")) {
        const parsed_error: ?ActiveSessionsExceededException = aws.json.parseJsonObject(ActiveSessionsExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .active_sessions_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ActiveStatementsExceededException")) {
        const parsed_error: ?ActiveStatementsExceededException = aws.json.parseJsonObject(ActiveStatementsExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .active_statements_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ActiveWaitingRequestsExceededException")) {
        const parsed_error: ?ActiveWaitingRequestsExceededException = aws.json.parseJsonObject(ActiveWaitingRequestsExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .active_waiting_requests_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BatchExecuteStatementException")) {
        const parsed_error: ?BatchExecuteStatementException = aws.json.parseJsonObject(BatchExecuteStatementException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .batch_execute_statement_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DatabaseConnectionException")) {
        const parsed_error: ?DatabaseConnectionException = aws.json.parseJsonObject(DatabaseConnectionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .database_connection_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ExecuteStatementException")) {
        const parsed_error: ?ExecuteStatementException = aws.json.parseJsonObject(ExecuteStatementException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .execute_statement_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        const parsed_error: ?InternalServerException = aws.json.parseJsonObject(InternalServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "QueryTimeoutException")) {
        const parsed_error: ?QueryTimeoutException = aws.json.parseJsonObject(QueryTimeoutException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .query_timeout_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?ResourceNotFoundException = aws.json.parseJsonObject(ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?ValidationException = aws.json.parseJsonObject(ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
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
