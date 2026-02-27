const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        active_sessions_exceeded_exception: ActiveSessionsExceededException,
        active_statements_exceeded_exception: ActiveStatementsExceededException,
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

pub const ActiveSessionsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ActiveStatementsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BatchExecuteStatementException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DatabaseConnectionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ExecuteStatementException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const QueryTimeoutException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
