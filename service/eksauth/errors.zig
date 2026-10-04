const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        expired_token_exception: ExpiredTokenException,
        internal_server_exception: InternalServerException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_request_exception: InvalidRequestException,
        invalid_token_exception: InvalidTokenException,
        resource_not_found_exception: ResourceNotFoundException,
        service_unavailable_exception: ServiceUnavailableException,
        throttling_exception: ThrottlingException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .expired_token_exception => "ExpiredTokenException",
                .internal_server_exception => "InternalServerException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_request_exception => "InvalidRequestException",
                .invalid_token_exception => "InvalidTokenException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .throttling_exception => "ThrottlingException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .expired_token_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .invalid_token_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 400,
                .expired_token_exception => 400,
                .internal_server_exception => 500,
                .invalid_parameter_exception => 400,
                .invalid_request_exception => 400,
                .invalid_token_exception => 400,
                .resource_not_found_exception => 404,
                .service_unavailable_exception => 503,
                .throttling_exception => 429,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .expired_token_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .invalid_token_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
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

pub const ExpiredTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
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
    if (std.mem.eql(u8, error_code, "ExpiredTokenException")) {
        return .{ .arena = arena, .kind = .{ .expired_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
