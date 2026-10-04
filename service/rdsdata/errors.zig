const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        bad_request_exception: BadRequestException,
        database_error_exception: DatabaseErrorException,
        database_not_found_exception: DatabaseNotFoundException,
        database_resuming_exception: DatabaseResumingException,
        database_unavailable_exception: DatabaseUnavailableException,
        forbidden_exception: ForbiddenException,
        http_endpoint_not_enabled_exception: HttpEndpointNotEnabledException,
        internal_server_error_exception: InternalServerErrorException,
        invalid_resource_state_exception: InvalidResourceStateException,
        invalid_secret_exception: InvalidSecretException,
        not_found_exception: NotFoundException,
        secrets_error_exception: SecretsErrorException,
        service_unavailable_error: ServiceUnavailableError,
        statement_timeout_exception: StatementTimeoutException,
        transaction_not_found_exception: TransactionNotFoundException,
        unsupported_result_exception: UnsupportedResultException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .bad_request_exception => "BadRequestException",
                .database_error_exception => "DatabaseErrorException",
                .database_not_found_exception => "DatabaseNotFoundException",
                .database_resuming_exception => "DatabaseResumingException",
                .database_unavailable_exception => "DatabaseUnavailableException",
                .forbidden_exception => "ForbiddenException",
                .http_endpoint_not_enabled_exception => "HttpEndpointNotEnabledException",
                .internal_server_error_exception => "InternalServerErrorException",
                .invalid_resource_state_exception => "InvalidResourceStateException",
                .invalid_secret_exception => "InvalidSecretException",
                .not_found_exception => "NotFoundException",
                .secrets_error_exception => "SecretsErrorException",
                .service_unavailable_error => "ServiceUnavailableError",
                .statement_timeout_exception => "StatementTimeoutException",
                .transaction_not_found_exception => "TransactionNotFoundException",
                .unsupported_result_exception => "UnsupportedResultException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .bad_request_exception => |e| e.message,
                .database_error_exception => |e| e.message,
                .database_not_found_exception => |e| e.message,
                .database_resuming_exception => |e| e.message,
                .database_unavailable_exception => |e| e.message,
                .forbidden_exception => |e| e.message,
                .http_endpoint_not_enabled_exception => |e| e.message,
                .internal_server_error_exception => |e| e.message,
                .invalid_resource_state_exception => |e| e.message,
                .invalid_secret_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .secrets_error_exception => |e| e.message,
                .service_unavailable_error => |e| e.message,
                .statement_timeout_exception => |e| e.message,
                .transaction_not_found_exception => |e| e.message,
                .unsupported_result_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .bad_request_exception => 400,
                .database_error_exception => 400,
                .database_not_found_exception => 404,
                .database_resuming_exception => 400,
                .database_unavailable_exception => 504,
                .forbidden_exception => 403,
                .http_endpoint_not_enabled_exception => 400,
                .internal_server_error_exception => 500,
                .invalid_resource_state_exception => 400,
                .invalid_secret_exception => 400,
                .not_found_exception => 404,
                .secrets_error_exception => 400,
                .service_unavailable_error => 503,
                .statement_timeout_exception => 400,
                .transaction_not_found_exception => 404,
                .unsupported_result_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .bad_request_exception => |e| e.request_id,
                .database_error_exception => |e| e.request_id,
                .database_not_found_exception => |e| e.request_id,
                .database_resuming_exception => |e| e.request_id,
                .database_unavailable_exception => |e| e.request_id,
                .forbidden_exception => |e| e.request_id,
                .http_endpoint_not_enabled_exception => |e| e.request_id,
                .internal_server_error_exception => |e| e.request_id,
                .invalid_resource_state_exception => |e| e.request_id,
                .invalid_secret_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .secrets_error_exception => |e| e.request_id,
                .service_unavailable_error => |e| e.request_id,
                .statement_timeout_exception => |e| e.request_id,
                .transaction_not_found_exception => |e| e.request_id,
                .unsupported_result_exception => |e| e.request_id,
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

pub const BadRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DatabaseErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DatabaseNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DatabaseResumingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DatabaseUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ForbiddenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HttpEndpointNotEnabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidResourceStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSecretException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SecretsErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceUnavailableError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StatementTimeoutException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TransactionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedResultException = struct {
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
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DatabaseErrorException")) {
        return .{ .arena = arena, .kind = .{ .database_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DatabaseNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .database_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DatabaseResumingException")) {
        return .{ .arena = arena, .kind = .{ .database_resuming_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DatabaseUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .database_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HttpEndpointNotEnabledException")) {
        return .{ .arena = arena, .kind = .{ .http_endpoint_not_enabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecretException")) {
        return .{ .arena = arena, .kind = .{ .invalid_secret_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SecretsErrorException")) {
        return .{ .arena = arena, .kind = .{ .secrets_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableError")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StatementTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .statement_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TransactionNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .transaction_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedResultException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_result_exception = .{
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
