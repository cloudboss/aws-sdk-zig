const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        bad_request_exception: BadRequestException,
        concurrent_access_exception: ConcurrentAccessException,
        conflict_exception: ConflictException,
        forbidden_exception: ForbiddenException,
        internal_server_error_exception: InternalServerErrorException,
        limit_exceeded_exception: LimitExceededException,
        not_found_exception: NotFoundException,
        too_many_requests_exception: TooManyRequestsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => "BadRequestException",
                .concurrent_access_exception => "ConcurrentAccessException",
                .conflict_exception => "ConflictException",
                .forbidden_exception => "ForbiddenException",
                .internal_server_error_exception => "InternalServerErrorException",
                .limit_exceeded_exception => "LimitExceededException",
                .not_found_exception => "NotFoundException",
                .too_many_requests_exception => "TooManyRequestsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => |e| e.message,
                .concurrent_access_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .forbidden_exception => |e| e.message,
                .internal_server_error_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .bad_request_exception => 400,
                .concurrent_access_exception => 400,
                .conflict_exception => 400,
                .forbidden_exception => 400,
                .internal_server_error_exception => 500,
                .limit_exceeded_exception => 400,
                .not_found_exception => 400,
                .too_many_requests_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => |e| e.request_id,
                .concurrent_access_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .forbidden_exception => |e| e.request_id,
                .internal_server_error_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
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

/// The target request is invalid.
pub const BadRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    class_name: ?[]const u8 = null,

    code: ?i32 = null,

    pub const json_field_names = .{
        .class_name = "className",
        .code = "code",
        .message = "message",
    };
};

/// A concurrent access issue occurred.
pub const ConcurrentAccessException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    class_name: ?[]const u8 = null,

    code: ?i32 = null,

    pub const json_field_names = .{
        .class_name = "className",
        .code = "code",
        .message = "message",
    };
};

/// A conflict occurred.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    class_name: ?[]const u8 = null,

    code: ?i32 = null,

    pub const json_field_names = .{
        .class_name = "className",
        .code = "code",
        .message = "message",
    };
};

/// An access permissions issue occurred.
pub const ForbiddenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    class_name: ?[]const u8 = null,

    code: ?i32 = null,

    pub const json_field_names = .{
        .class_name = "className",
        .code = "code",
        .message = "message",
    };
};

/// An internal server error occurred.
pub const InternalServerErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    class_name: ?[]const u8 = null,

    code: ?i32 = null,

    pub const json_field_names = .{
        .class_name = "className",
        .code = "code",
        .message = "message",
    };
};

/// A service limit was exceeded.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    class_name: ?[]const u8 = null,

    code: ?i32 = null,

    pub const json_field_names = .{
        .class_name = "className",
        .code = "code",
        .message = "message",
    };
};

/// The target resource cannot be found.
pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    class_name: ?[]const u8 = null,

    code: ?i32 = null,

    pub const json_field_names = .{
        .class_name = "className",
        .code = "code",
        .message = "message",
    };
};

/// Too many service requests were made over the given time period.
pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    class_name: ?[]const u8 = null,

    code: ?i32 = null,

    pub const json_field_names = .{
        .class_name = "className",
        .code = "code",
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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        const parsed_error: ?BadRequestException = aws.json.parseJsonObject(BadRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .bad_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConcurrentAccessException")) {
        const parsed_error: ?ConcurrentAccessException = aws.json.parseJsonObject(ConcurrentAccessException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .concurrent_access_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        const parsed_error: ?ForbiddenException = aws.json.parseJsonObject(ForbiddenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .forbidden_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        const parsed_error: ?InternalServerErrorException = aws.json.parseJsonObject(InternalServerErrorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_error_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        const parsed_error: ?TooManyRequestsException = aws.json.parseJsonObject(TooManyRequestsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_requests_exception = typed_error } };
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
