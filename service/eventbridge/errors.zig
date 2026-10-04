const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        concurrent_modification_exception: ConcurrentModificationException,
        illegal_status_exception: IllegalStatusException,
        internal_exception: InternalException,
        invalid_event_pattern_exception: InvalidEventPatternException,
        invalid_state_exception: InvalidStateException,
        limit_exceeded_exception: LimitExceededException,
        managed_rule_exception: ManagedRuleException,
        operation_disabled_exception: OperationDisabledException,
        policy_length_exceeded_exception: PolicyLengthExceededException,
        resource_already_exists_exception: ResourceAlreadyExistsException,
        resource_not_found_exception: ResourceNotFoundException,
        throttling_exception: ThrottlingException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .concurrent_modification_exception => "ConcurrentModificationException",
                .illegal_status_exception => "IllegalStatusException",
                .internal_exception => "InternalException",
                .invalid_event_pattern_exception => "InvalidEventPatternException",
                .invalid_state_exception => "InvalidStateException",
                .limit_exceeded_exception => "LimitExceededException",
                .managed_rule_exception => "ManagedRuleException",
                .operation_disabled_exception => "OperationDisabledException",
                .policy_length_exceeded_exception => "PolicyLengthExceededException",
                .resource_already_exists_exception => "ResourceAlreadyExistsException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .throttling_exception => "ThrottlingException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .concurrent_modification_exception => |e| e.message,
                .illegal_status_exception => |e| e.message,
                .internal_exception => |e| e.message,
                .invalid_event_pattern_exception => |e| e.message,
                .invalid_state_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .managed_rule_exception => |e| e.message,
                .operation_disabled_exception => |e| e.message,
                .policy_length_exceeded_exception => |e| e.message,
                .resource_already_exists_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 400,
                .concurrent_modification_exception => 400,
                .illegal_status_exception => 400,
                .internal_exception => 500,
                .invalid_event_pattern_exception => 400,
                .invalid_state_exception => 400,
                .limit_exceeded_exception => 400,
                .managed_rule_exception => 400,
                .operation_disabled_exception => 400,
                .policy_length_exceeded_exception => 400,
                .resource_already_exists_exception => 400,
                .resource_not_found_exception => 400,
                .throttling_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .concurrent_modification_exception => |e| e.request_id,
                .illegal_status_exception => |e| e.request_id,
                .internal_exception => |e| e.request_id,
                .invalid_event_pattern_exception => |e| e.request_id,
                .invalid_state_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .managed_rule_exception => |e| e.request_id,
                .operation_disabled_exception => |e| e.request_id,
                .policy_length_exceeded_exception => |e| e.request_id,
                .resource_already_exists_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
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

/// You do not have the necessary permissions for this action.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// There is concurrent modification on a rule, target, archive, or replay.
pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An error occurred because a replay can be canceled only when the state is
/// Running or
/// Starting.
pub const IllegalStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This exception occurs due to unexpected causes.
pub const InternalException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The event pattern is not valid.
pub const InvalidEventPatternException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified state is not a valid state for an event source.
pub const InvalidStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request failed because it attempted to create resource beyond the
/// allowed service
/// quota.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This rule was created by an Amazon Web Services service on behalf of your
/// account. It is
/// managed by that service. If you see this error in response to `DeleteRule`
/// or
/// `RemoveTargets`, you can use the `Force` parameter in those calls to
/// delete the rule or remove targets from the rule. You cannot modify these
/// managed rules by
/// using `DisableRule`, `EnableRule`, `PutTargets`,
/// `PutRule`, `TagResource`, or `UntagResource`.
pub const ManagedRuleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation you are attempting is not available in this region.
pub const OperationDisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The event bus policy is too long. For more information, see the limits.
pub const PolicyLengthExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The resource you are trying to create already exists.
pub const ResourceAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An entity that you specified does not exist.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This request cannot be completed due to throttling issues.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
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
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        const parsed_error: ?ConcurrentModificationException = aws.json.parseJsonObject(ConcurrentModificationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IllegalStatusException")) {
        const parsed_error: ?IllegalStatusException = aws.json.parseJsonObject(IllegalStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .illegal_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalException")) {
        const parsed_error: ?InternalException = aws.json.parseJsonObject(InternalException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidEventPatternException")) {
        const parsed_error: ?InvalidEventPatternException = aws.json.parseJsonObject(InvalidEventPatternException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_event_pattern_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        const parsed_error: ?InvalidStateException = aws.json.parseJsonObject(InvalidStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_state_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "ManagedRuleException")) {
        const parsed_error: ?ManagedRuleException = aws.json.parseJsonObject(ManagedRuleException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .managed_rule_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OperationDisabledException")) {
        const parsed_error: ?OperationDisabledException = aws.json.parseJsonObject(OperationDisabledException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .operation_disabled_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PolicyLengthExceededException")) {
        const parsed_error: ?PolicyLengthExceededException = aws.json.parseJsonObject(PolicyLengthExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .policy_length_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        const parsed_error: ?ResourceAlreadyExistsException = aws.json.parseJsonObject(ResourceAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = typed_error } };
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
