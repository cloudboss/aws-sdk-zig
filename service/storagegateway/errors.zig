const aws = @import("aws");
const std = @import("std");

const StorageGatewayError = @import("storage_gateway_error.zig").StorageGatewayError;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        internal_server_error: InternalServerError,
        invalid_gateway_request_exception: InvalidGatewayRequestException,
        service_unavailable_error: ServiceUnavailableError,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .internal_server_error => "InternalServerError",
                .invalid_gateway_request_exception => "InvalidGatewayRequestException",
                .service_unavailable_error => "ServiceUnavailableError",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .internal_server_error => |e| e.message,
                .invalid_gateway_request_exception => |e| e.message,
                .service_unavailable_error => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .internal_server_error => 500,
                .invalid_gateway_request_exception => 400,
                .service_unavailable_error => 503,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .internal_server_error => |e| e.request_id,
                .invalid_gateway_request_exception => |e| e.request_id,
                .service_unavailable_error => |e| e.request_id,
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

/// An internal server error has occurred during the request. For more
/// information, see the
/// error and message fields.
pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// A StorageGatewayError that provides more information about the cause
    /// of the error.
    @"error": ?StorageGatewayError = null,

    pub const json_field_names = .{
        .@"error" = "error",
        .message = "message",
    };
};

/// An exception occurred because an invalid gateway request was issued to the
/// service. For
/// more information, see the error and message fields.
pub const InvalidGatewayRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// A StorageGatewayError that provides more detail about the cause of the
    /// error.
    @"error": ?StorageGatewayError = null,

    pub const json_field_names = .{
        .@"error" = "error",
        .message = "message",
    };
};

/// An internal server error has occurred because the service is unavailable.
/// For more
/// information, see the error and message fields.
pub const ServiceUnavailableError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// A StorageGatewayError that provides more information about the cause
    /// of the error.
    @"error": ?StorageGatewayError = null,

    pub const json_field_names = .{
        .@"error" = "error",
        .message = "message",
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

    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        const parsed_error: ?InternalServerError = aws.json.parseJsonObject(InternalServerError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidGatewayRequestException")) {
        const parsed_error: ?InvalidGatewayRequestException = aws.json.parseJsonObject(InvalidGatewayRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_gateway_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableError")) {
        const parsed_error: ?ServiceUnavailableError = aws.json.parseJsonObject(ServiceUnavailableError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_unavailable_error = typed_error } };
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
