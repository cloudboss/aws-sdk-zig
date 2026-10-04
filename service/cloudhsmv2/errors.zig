const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        cloud_hsm_access_denied_exception: CloudHsmAccessDeniedException,
        cloud_hsm_internal_failure_exception: CloudHsmInternalFailureException,
        cloud_hsm_invalid_request_exception: CloudHsmInvalidRequestException,
        cloud_hsm_resource_limit_exceeded_exception: CloudHsmResourceLimitExceededException,
        cloud_hsm_resource_not_found_exception: CloudHsmResourceNotFoundException,
        cloud_hsm_service_exception: CloudHsmServiceException,
        cloud_hsm_tag_exception: CloudHsmTagException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .cloud_hsm_access_denied_exception => "CloudHsmAccessDeniedException",
                .cloud_hsm_internal_failure_exception => "CloudHsmInternalFailureException",
                .cloud_hsm_invalid_request_exception => "CloudHsmInvalidRequestException",
                .cloud_hsm_resource_limit_exceeded_exception => "CloudHsmResourceLimitExceededException",
                .cloud_hsm_resource_not_found_exception => "CloudHsmResourceNotFoundException",
                .cloud_hsm_service_exception => "CloudHsmServiceException",
                .cloud_hsm_tag_exception => "CloudHsmTagException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .cloud_hsm_access_denied_exception => |e| e.message,
                .cloud_hsm_internal_failure_exception => |e| e.message,
                .cloud_hsm_invalid_request_exception => |e| e.message,
                .cloud_hsm_resource_limit_exceeded_exception => |e| e.message,
                .cloud_hsm_resource_not_found_exception => |e| e.message,
                .cloud_hsm_service_exception => |e| e.message,
                .cloud_hsm_tag_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .cloud_hsm_access_denied_exception => 400,
                .cloud_hsm_internal_failure_exception => 500,
                .cloud_hsm_invalid_request_exception => 400,
                .cloud_hsm_resource_limit_exceeded_exception => 400,
                .cloud_hsm_resource_not_found_exception => 400,
                .cloud_hsm_service_exception => 400,
                .cloud_hsm_tag_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .cloud_hsm_access_denied_exception => |e| e.request_id,
                .cloud_hsm_internal_failure_exception => |e| e.request_id,
                .cloud_hsm_invalid_request_exception => |e| e.request_id,
                .cloud_hsm_resource_limit_exceeded_exception => |e| e.request_id,
                .cloud_hsm_resource_not_found_exception => |e| e.request_id,
                .cloud_hsm_service_exception => |e| e.request_id,
                .cloud_hsm_tag_exception => |e| e.request_id,
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

/// The request was rejected because the requester does not have permission to
/// perform the
/// requested operation.
pub const CloudHsmAccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was rejected because of an CloudHSM internal failure. The
/// request can
/// be retried.
pub const CloudHsmInternalFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was rejected because it is not a valid request.
pub const CloudHsmInvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was rejected because it exceeds an CloudHSM limit.
pub const CloudHsmResourceLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was rejected because it refers to a resource that cannot be
/// found.
pub const CloudHsmResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was rejected because an error occurred.
pub const CloudHsmServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was rejected because of a tagging failure. Verify the tag
/// conditions in all applicable policies, and then retry the request.
pub const CloudHsmTagException = struct {
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

    if (std.mem.eql(u8, error_code, "CloudHsmAccessDeniedException")) {
        const parsed_error: ?CloudHsmAccessDeniedException = aws.json.parseJsonObject(CloudHsmAccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_hsm_access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CloudHsmInternalFailureException")) {
        const parsed_error: ?CloudHsmInternalFailureException = aws.json.parseJsonObject(CloudHsmInternalFailureException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_hsm_internal_failure_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CloudHsmInvalidRequestException")) {
        const parsed_error: ?CloudHsmInvalidRequestException = aws.json.parseJsonObject(CloudHsmInvalidRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_hsm_invalid_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CloudHsmResourceLimitExceededException")) {
        const parsed_error: ?CloudHsmResourceLimitExceededException = aws.json.parseJsonObject(CloudHsmResourceLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_hsm_resource_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CloudHsmResourceNotFoundException")) {
        const parsed_error: ?CloudHsmResourceNotFoundException = aws.json.parseJsonObject(CloudHsmResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_hsm_resource_not_found_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "CloudHsmTagException")) {
        const parsed_error: ?CloudHsmTagException = aws.json.parseJsonObject(CloudHsmTagException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_hsm_tag_exception = typed_error } };
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
