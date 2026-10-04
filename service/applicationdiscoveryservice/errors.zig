const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        authorization_error_exception: AuthorizationErrorException,
        conflict_error_exception: ConflictErrorException,
        home_region_not_set_exception: HomeRegionNotSetException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_parameter_value_exception: InvalidParameterValueException,
        limit_exceeded_exception: LimitExceededException,
        operation_not_permitted_exception: OperationNotPermittedException,
        resource_in_use_exception: ResourceInUseException,
        resource_not_found_exception: ResourceNotFoundException,
        server_internal_error_exception: ServerInternalErrorException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .authorization_error_exception => "AuthorizationErrorException",
                .conflict_error_exception => "ConflictErrorException",
                .home_region_not_set_exception => "HomeRegionNotSetException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_parameter_value_exception => "InvalidParameterValueException",
                .limit_exceeded_exception => "LimitExceededException",
                .operation_not_permitted_exception => "OperationNotPermittedException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .server_internal_error_exception => "ServerInternalErrorException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .authorization_error_exception => |e| e.message,
                .conflict_error_exception => |e| e.message,
                .home_region_not_set_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_parameter_value_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .operation_not_permitted_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .server_internal_error_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .authorization_error_exception => 403,
                .conflict_error_exception => 409,
                .home_region_not_set_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_parameter_value_exception => 400,
                .limit_exceeded_exception => 400,
                .operation_not_permitted_exception => 429,
                .resource_in_use_exception => 400,
                .resource_not_found_exception => 400,
                .server_internal_error_exception => 500,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .authorization_error_exception => |e| e.request_id,
                .conflict_error_exception => |e| e.request_id,
                .home_region_not_set_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_parameter_value_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .operation_not_permitted_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .server_internal_error_exception => |e| e.request_id,
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

/// The user does not have permission to perform the action. Check the IAM
/// policy associated with this user.
pub const AuthorizationErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Conflict error.
pub const ConflictErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The home Region is not set. Set the home Region to continue.
pub const HomeRegionNotSetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// One or more parameters are not valid. Verify the parameters and try again.
pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The value of one or more parameters are either invalid or out of range.
/// Verify the
/// parameter values and try again.
pub const InvalidParameterValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The limit of 200 configuration IDs per request has been exceeded.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This operation is not permitted.
pub const OperationNotPermittedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// This issue occurs when the same `clientRequestToken` is used with the
/// `StartImportTask` action, but with different parameters. For example, you
/// use the
/// same request token but have two different import URLs, you can encounter
/// this issue. If the
/// import tasks are meant to be different, use a different
/// `clientRequestToken`, and
/// try again.
pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified configuration ID was not located. Verify the configuration ID
/// and try
/// again.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The server experienced an internal error. Try again.
pub const ServerInternalErrorException = struct {
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

    if (std.mem.eql(u8, error_code, "AuthorizationErrorException")) {
        const parsed_error: ?AuthorizationErrorException = aws.json.parseJsonObject(AuthorizationErrorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .authorization_error_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictErrorException")) {
        const parsed_error: ?ConflictErrorException = aws.json.parseJsonObject(ConflictErrorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_error_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "HomeRegionNotSetException")) {
        const parsed_error: ?HomeRegionNotSetException = aws.json.parseJsonObject(HomeRegionNotSetException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .home_region_not_set_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        const parsed_error: ?InvalidParameterValueException = aws.json.parseJsonObject(InvalidParameterValueException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "OperationNotPermittedException")) {
        const parsed_error: ?OperationNotPermittedException = aws.json.parseJsonObject(OperationNotPermittedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .operation_not_permitted_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        const parsed_error: ?ResourceInUseException = aws.json.parseJsonObject(ResourceInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_in_use_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "ServerInternalErrorException")) {
        const parsed_error: ?ServerInternalErrorException = aws.json.parseJsonObject(ServerInternalErrorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .server_internal_error_exception = typed_error } };
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
