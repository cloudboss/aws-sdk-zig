const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        billing_view_health_status_exception: BillingViewHealthStatusException,
        creation_limit_exceeded_exception: CreationLimitExceededException,
        duplicate_record_exception: DuplicateRecordException,
        expired_next_token_exception: ExpiredNextTokenException,
        internal_error_exception: InternalErrorException,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_parameter_exception: InvalidParameterException,
        not_found_exception: NotFoundException,
        resource_locked_exception: ResourceLockedException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        throttling_exception: ThrottlingException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .billing_view_health_status_exception => "BillingViewHealthStatusException",
                .creation_limit_exceeded_exception => "CreationLimitExceededException",
                .duplicate_record_exception => "DuplicateRecordException",
                .expired_next_token_exception => "ExpiredNextTokenException",
                .internal_error_exception => "InternalErrorException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_parameter_exception => "InvalidParameterException",
                .not_found_exception => "NotFoundException",
                .resource_locked_exception => "ResourceLockedException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .throttling_exception => "ThrottlingException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .billing_view_health_status_exception => |e| e.message,
                .creation_limit_exceeded_exception => |e| e.message,
                .duplicate_record_exception => |e| e.message,
                .expired_next_token_exception => |e| e.message,
                .internal_error_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .resource_locked_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .billing_view_health_status_exception => 400,
                .creation_limit_exceeded_exception => 405,
                .duplicate_record_exception => 409,
                .expired_next_token_exception => 400,
                .internal_error_exception => 500,
                .invalid_next_token_exception => 400,
                .invalid_parameter_exception => 400,
                .not_found_exception => 404,
                .resource_locked_exception => 423,
                .service_quota_exceeded_exception => 402,
                .throttling_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .billing_view_health_status_exception => |e| e.request_id,
                .creation_limit_exceeded_exception => |e| e.request_id,
                .duplicate_record_exception => |e| e.request_id,
                .expired_next_token_exception => |e| e.request_id,
                .internal_error_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .resource_locked_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
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

/// You are not authorized to use this operation with the given parameters.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The billing view status must be HEALTHY to perform this action. Try again
/// when the status is HEALTHY.
pub const BillingViewHealthStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You've exceeded the notification or subscriber limit.
pub const CreationLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The budget name already exists. Budget names must be unique within an
/// account.
pub const DuplicateRecordException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The pagination token expired.
pub const ExpiredNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// An error on the server occurred during the processing of your request. Try
/// again later.
pub const InternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The pagination token is invalid.
pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// An error on the client occurred. Typically, the cause is an invalid input
/// value.
pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// We can’t locate the resource that you specified.
pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request was received and recognized by the server, but the server
/// rejected that
/// particular method for the requested resource.
pub const ResourceLockedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You've reached a Service Quota limit on this resource.
pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The number of API requests has exceeded the maximum allowed API request
/// throttling limit
/// for the account.
pub const ThrottlingException = struct {
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
    if (std.mem.eql(u8, error_code, "BillingViewHealthStatusException")) {
        const parsed_error: ?BillingViewHealthStatusException = aws.json.parseJsonObject(BillingViewHealthStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .billing_view_health_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CreationLimitExceededException")) {
        const parsed_error: ?CreationLimitExceededException = aws.json.parseJsonObject(CreationLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .creation_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateRecordException")) {
        const parsed_error: ?DuplicateRecordException = aws.json.parseJsonObject(DuplicateRecordException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_record_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ExpiredNextTokenException")) {
        const parsed_error: ?ExpiredNextTokenException = aws.json.parseJsonObject(ExpiredNextTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .expired_next_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalErrorException")) {
        const parsed_error: ?InternalErrorException = aws.json.parseJsonObject(InternalErrorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_error_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        const parsed_error: ?InvalidParameterException = aws.json.parseJsonObject(InvalidParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        const parsed_error: ?NotFoundException = aws.json.parseJsonObject(NotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceLockedException")) {
        const parsed_error: ?ResourceLockedException = aws.json.parseJsonObject(ResourceLockedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_locked_exception = typed_error } };
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
