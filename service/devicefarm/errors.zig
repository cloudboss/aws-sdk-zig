const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        argument_exception: ArgumentException,
        cannot_delete_exception: CannotDeleteException,
        idempotency_exception: IdempotencyException,
        internal_service_exception: InternalServiceException,
        invalid_operation_exception: InvalidOperationException,
        limit_exceeded_exception: LimitExceededException,
        not_eligible_exception: NotEligibleException,
        not_found_exception: NotFoundException,
        service_account_exception: ServiceAccountException,
        tag_operation_exception: TagOperationException,
        tag_policy_exception: TagPolicyException,
        too_many_tags_exception: TooManyTagsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .argument_exception => "ArgumentException",
                .cannot_delete_exception => "CannotDeleteException",
                .idempotency_exception => "IdempotencyException",
                .internal_service_exception => "InternalServiceException",
                .invalid_operation_exception => "InvalidOperationException",
                .limit_exceeded_exception => "LimitExceededException",
                .not_eligible_exception => "NotEligibleException",
                .not_found_exception => "NotFoundException",
                .service_account_exception => "ServiceAccountException",
                .tag_operation_exception => "TagOperationException",
                .tag_policy_exception => "TagPolicyException",
                .too_many_tags_exception => "TooManyTagsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .argument_exception => |e| e.message,
                .cannot_delete_exception => |e| e.message,
                .idempotency_exception => |e| e.message,
                .internal_service_exception => |e| e.message,
                .invalid_operation_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .not_eligible_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .service_account_exception => |e| e.message,
                .tag_operation_exception => |e| e.message,
                .tag_policy_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .argument_exception => 400,
                .cannot_delete_exception => 409,
                .idempotency_exception => 400,
                .internal_service_exception => 500,
                .invalid_operation_exception => 400,
                .limit_exceeded_exception => 400,
                .not_eligible_exception => 400,
                .not_found_exception => 400,
                .service_account_exception => 400,
                .tag_operation_exception => 400,
                .tag_policy_exception => 400,
                .too_many_tags_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .argument_exception => |e| e.request_id,
                .cannot_delete_exception => |e| e.request_id,
                .idempotency_exception => |e| e.request_id,
                .internal_service_exception => |e| e.request_id,
                .invalid_operation_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .not_eligible_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .service_account_exception => |e| e.request_id,
                .tag_operation_exception => |e| e.request_id,
                .tag_policy_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
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

/// An invalid argument was specified.
pub const ArgumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The requested object could not be deleted.
pub const CannotDeleteException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An entity with the same name already exists.
pub const IdempotencyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An internal exception was raised in the service. Contact
/// [aws-devicefarm-support@amazon.com](mailto:aws-devicefarm-support@amazon.com) if you see this
/// error.
pub const InternalServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// There was an error with the update request, or you do not have sufficient
/// permissions
/// to update this VPC endpoint configuration.
pub const InvalidOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A limit was exceeded.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Exception gets thrown when a user is not eligible to perform the specified
/// transaction.
pub const NotEligibleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified entity was not found.
pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// There was a problem with the service account.
pub const ServiceAccountException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation was not successful. Try again.
pub const TagOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    resource_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .resource_name = "resourceName",
    };
};

/// The request doesn't comply with the AWS Identity and Access Management (IAM)
/// tag
/// policy. Correct your request and then retry it.
pub const TagPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    resource_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .resource_name = "resourceName",
    };
};

/// The list of tags on the repository is over the limit. The maximum number of
/// tags that
/// can be applied to a repository is 50.
pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    resource_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .resource_name = "resourceName",
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

    if (std.mem.eql(u8, error_code, "ArgumentException")) {
        const parsed_error: ?ArgumentException = aws.json.parseJsonObject(ArgumentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .argument_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CannotDeleteException")) {
        const parsed_error: ?CannotDeleteException = aws.json.parseJsonObject(CannotDeleteException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cannot_delete_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IdempotencyException")) {
        const parsed_error: ?IdempotencyException = aws.json.parseJsonObject(IdempotencyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .idempotency_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "InvalidOperationException")) {
        const parsed_error: ?InvalidOperationException = aws.json.parseJsonObject(InvalidOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_operation_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "NotEligibleException")) {
        const parsed_error: ?NotEligibleException = aws.json.parseJsonObject(NotEligibleException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .not_eligible_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "ServiceAccountException")) {
        const parsed_error: ?ServiceAccountException = aws.json.parseJsonObject(ServiceAccountException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_account_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagOperationException")) {
        const parsed_error: ?TagOperationException = aws.json.parseJsonObject(TagOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_operation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagPolicyException")) {
        const parsed_error: ?TagPolicyException = aws.json.parseJsonObject(TagPolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_policy_exception = typed_error } };
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
