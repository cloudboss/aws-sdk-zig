const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        cloud_hsm_internal_exception: CloudHsmInternalException,
        cloud_hsm_service_exception: CloudHsmServiceException,
        invalid_request_exception: InvalidRequestException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .cloud_hsm_internal_exception => "CloudHsmInternalException",
                .cloud_hsm_service_exception => "CloudHsmServiceException",
                .invalid_request_exception => "InvalidRequestException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .cloud_hsm_internal_exception => |e| e.message,
                .cloud_hsm_service_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .cloud_hsm_internal_exception => 500,
                .cloud_hsm_service_exception => 400,
                .invalid_request_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .cloud_hsm_internal_exception => |e| e.request_id,
                .cloud_hsm_service_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
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

/// Indicates that an internal error occurred.
pub const CloudHsmInternalException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Indicates if the action can be retried.
    retryable: ?bool = null,

    pub const json_field_names = .{
        .message = "message",
        .retryable = "retryable",
    };
};

/// Indicates that an exception occurred in the AWS CloudHSM service.
pub const CloudHsmServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Indicates if the action can be retried.
    retryable: ?bool = null,

    pub const json_field_names = .{
        .message = "message",
        .retryable = "retryable",
    };
};

/// Indicates that one or more of the request parameters are not valid.
pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Indicates if the action can be retried.
    retryable: ?bool = null,

    pub const json_field_names = .{
        .message = "message",
        .retryable = "retryable",
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

    if (std.mem.eql(u8, error_code, "CloudHsmInternalException")) {
        const parsed_error: ?CloudHsmInternalException = aws.json.parseJsonObject(CloudHsmInternalException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_hsm_internal_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CloudHsmServiceException")) {
        const parsed_error: ?CloudHsmServiceException = aws.json.parseJsonObject(CloudHsmServiceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_hsm_service_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        const parsed_error: ?InvalidRequestException = aws.json.parseJsonObject(InvalidRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_request_exception = typed_error } };
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
