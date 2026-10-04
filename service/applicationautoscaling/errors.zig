const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        concurrent_update_exception: ConcurrentUpdateException,
        failed_resource_access_exception: FailedResourceAccessException,
        internal_service_exception: InternalServiceException,
        invalid_next_token_exception: InvalidNextTokenException,
        limit_exceeded_exception: LimitExceededException,
        object_not_found_exception: ObjectNotFoundException,
        resource_not_found_exception: ResourceNotFoundException,
        too_many_tags_exception: TooManyTagsException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_update_exception => "ConcurrentUpdateException",
                .failed_resource_access_exception => "FailedResourceAccessException",
                .internal_service_exception => "InternalServiceException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .limit_exceeded_exception => "LimitExceededException",
                .object_not_found_exception => "ObjectNotFoundException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .too_many_tags_exception => "TooManyTagsException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_update_exception => |e| e.message,
                .failed_resource_access_exception => |e| e.message,
                .internal_service_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .object_not_found_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .concurrent_update_exception => 500,
                .failed_resource_access_exception => 400,
                .internal_service_exception => 500,
                .invalid_next_token_exception => 400,
                .limit_exceeded_exception => 400,
                .object_not_found_exception => 400,
                .resource_not_found_exception => 404,
                .too_many_tags_exception => 400,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_update_exception => |e| e.request_id,
                .failed_resource_access_exception => |e| e.request_id,
                .internal_service_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .object_not_found_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
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

/// Concurrent updates caused an exception, for example, if you request an
/// update to an
/// Application Auto Scaling resource that already has a pending update.
pub const ConcurrentUpdateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Failed access to resources caused an exception. This exception is thrown
/// when Application Auto Scaling
/// is unable to retrieve the alarms associated with a scaling policy due to a
/// client error,
/// for example, if the role ARN specified for a scalable target does not have
/// permission to
/// call the CloudWatch
/// [DescribeAlarms](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_DescribeAlarms.html) on your behalf.
pub const FailedResourceAccessException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The service encountered an internal error.
pub const InternalServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The next token supplied was invalid.
pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A per-account resource limit is exceeded. For more information, see
/// [Application Auto Scaling service
/// quotas](https://docs.aws.amazon.com/autoscaling/application/userguide/application-auto-scaling-limits.html).
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified object could not be found. For any operation that depends on
/// the existence
/// of a scalable target, this exception is thrown if the scalable target with
/// the specified
/// service namespace, resource ID, and scalable dimension does not exist. For
/// any operation
/// that deletes or deregisters a resource, this exception is thrown if the
/// resource cannot be
/// found.
pub const ObjectNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified resource doesn't exist.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The name of the Application Auto Scaling resource. This value is an Amazon
    /// Resource Name (ARN).
    resource_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .resource_name = "ResourceName",
    };
};

/// The request contains too many tags. Try the request again with fewer tags.
pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The name of the Application Auto Scaling resource. This value is an Amazon
    /// Resource Name (ARN).
    resource_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .resource_name = "ResourceName",
    };
};

/// An exception was thrown for a validation issue. Review the available
/// parameters for the
/// API request.
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

    if (std.mem.eql(u8, error_code, "ConcurrentUpdateException")) {
        const parsed_error: ?ConcurrentUpdateException = aws.json.parseJsonObject(ConcurrentUpdateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .concurrent_update_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FailedResourceAccessException")) {
        const parsed_error: ?FailedResourceAccessException = aws.json.parseJsonObject(FailedResourceAccessException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .failed_resource_access_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        const parsed_error: ?InternalServiceException = aws.json.parseJsonObject(InternalServiceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_service_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        const parsed_error: ?InvalidNextTokenException = aws.json.parseJsonObject(InvalidNextTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?LimitExceededException = aws.json.parseJsonObject(LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ObjectNotFoundException")) {
        const parsed_error: ?ObjectNotFoundException = aws.json.parseJsonObject(ObjectNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .object_not_found_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        const parsed_error: ?TooManyTagsException = aws.json.parseJsonObject(TooManyTagsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_exception = typed_error } };
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
