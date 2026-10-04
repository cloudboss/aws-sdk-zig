const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        conflict_exception: ConflictException,
        internal_server_exception: InternalServerException,
        public_policy_exception: PublicPolicyException,
        resource_not_found_exception: ResourceNotFoundException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        service_unavailable_exception: ServiceUnavailableException,
        throttling_exception: ThrottlingException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .conflict_exception => "ConflictException",
                .internal_server_exception => "InternalServerException",
                .public_policy_exception => "PublicPolicyException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .throttling_exception => "ThrottlingException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .public_policy_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .conflict_exception => 409,
                .internal_server_exception => 500,
                .public_policy_exception => 400,
                .resource_not_found_exception => 404,
                .service_quota_exceeded_exception => 402,
                .service_unavailable_exception => 503,
                .throttling_exception => 429,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .public_policy_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
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

/// You do not have sufficient access to perform this action.
///
/// This exception is thrown when the caller lacks the necessary IAM permissions
/// to perform the requested operation. Verify that your IAM policy includes the
/// required permissions for the specific Amazon Web Services Payment
/// Cryptography action you're attempting.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// This request can cause an inconsistent state for the resource.
///
/// The requested operation conflicts with the current state of the resource.
/// For example, attempting to delete a key that is currently being used, or
/// trying to create a resource that already exists.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request processing has failed because of an unknown error, exception, or
/// failure.
///
/// This indicates a server-side error within the Amazon Web Services Payment
/// Cryptography service. If this error persists, contact support for
/// assistance.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource-based policy would grant public access to the key.
///
/// Modify the policy to restrict access to specific principals and resubmit the
/// request.
pub const PublicPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was denied due to resource not found.
///
/// The specified key, alias, or other resource does not exist in your account
/// or region. Verify that the resource identifier is correct and that the
/// resource exists in the expected region.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The identifier of the resource that was not found.
    ///
    /// This field contains the specific resource identifier (such as a key ARN or
    /// alias name) that could not be located.
    resource_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_id = "ResourceId",
    };
};

/// This request would cause a service quota to be exceeded.
///
/// You have reached the maximum number of keys, aliases, or other resources
/// allowed in your account. Review your current usage and consider deleting
/// unused resources or requesting a quota increase.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The service cannot complete the request.
///
/// The Amazon Web Services Payment Cryptography service is temporarily
/// unavailable. This is typically a temporary condition - retry your request
/// after a brief delay.
pub const ServiceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was denied due to request throttling.
///
/// You have exceeded the rate limits for Amazon Web Services Payment
/// Cryptography API calls. Implement exponential backoff and retry logic in
/// your application to handle throttling gracefully.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was denied due to an invalid request error.
///
/// One or more parameters in your request are invalid. Check the parameter
/// values, formats, and constraints specified in the API documentation.
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        const parsed_error: ?AccessDeniedException = aws.json.parseJsonObject(AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?ConflictException = aws.json.parseJsonObject(ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "PublicPolicyException")) {
        const parsed_error: ?PublicPolicyException = aws.json.parseJsonObject(PublicPolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .public_policy_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        const parsed_error: ?ServiceQuotaExceededException = aws.json.parseJsonObject(ServiceQuotaExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        const parsed_error: ?ServiceUnavailableException = aws.json.parseJsonObject(ServiceUnavailableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_unavailable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?ThrottlingException = aws.json.parseJsonObject(ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
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
