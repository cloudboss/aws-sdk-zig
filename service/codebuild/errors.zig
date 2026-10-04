const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        account_limit_exceeded_exception: AccountLimitExceededException,
        account_suspended_exception: AccountSuspendedException,
        invalid_input_exception: InvalidInputException,
        o_auth_provider_exception: OAuthProviderException,
        resource_already_exists_exception: ResourceAlreadyExistsException,
        resource_not_found_exception: ResourceNotFoundException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .account_limit_exceeded_exception => "AccountLimitExceededException",
                .account_suspended_exception => "AccountSuspendedException",
                .invalid_input_exception => "InvalidInputException",
                .o_auth_provider_exception => "OAuthProviderException",
                .resource_already_exists_exception => "ResourceAlreadyExistsException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .account_limit_exceeded_exception => |e| e.message,
                .account_suspended_exception => |e| e.message,
                .invalid_input_exception => |e| e.message,
                .o_auth_provider_exception => |e| e.message,
                .resource_already_exists_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .account_limit_exceeded_exception => 400,
                .account_suspended_exception => 400,
                .invalid_input_exception => 400,
                .o_auth_provider_exception => 400,
                .resource_already_exists_exception => 400,
                .resource_not_found_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .account_limit_exceeded_exception => |e| e.request_id,
                .account_suspended_exception => |e| e.request_id,
                .invalid_input_exception => |e| e.request_id,
                .o_auth_provider_exception => |e| e.request_id,
                .resource_already_exists_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
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

/// An Amazon Web Services service limit was exceeded for the calling Amazon Web
/// Services account.
pub const AccountLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The CodeBuild access has been suspended for the calling Amazon Web Services
/// account.
pub const AccountSuspendedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The input value that was provided is not valid.
pub const InvalidInputException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// There was a problem with the underlying OAuth provider.
pub const OAuthProviderException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified Amazon Web Services resource cannot be created, because an
/// Amazon Web Services resource with the same
/// settings already exists.
pub const ResourceAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified Amazon Web Services resource cannot be found.
pub const ResourceNotFoundException = struct {
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

    if (std.mem.eql(u8, error_code, "AccountLimitExceededException")) {
        const parsed_error: ?AccountLimitExceededException = aws.json.parseJsonObject(AccountLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .account_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AccountSuspendedException")) {
        const parsed_error: ?AccountSuspendedException = aws.json.parseJsonObject(AccountSuspendedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .account_suspended_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        const parsed_error: ?InvalidInputException = aws.json.parseJsonObject(InvalidInputException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_input_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OAuthProviderException")) {
        const parsed_error: ?OAuthProviderException = aws.json.parseJsonObject(OAuthProviderException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .o_auth_provider_exception = typed_error } };
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
