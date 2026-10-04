const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        bad_request_error: BadRequestError,
        forbidden_error: ForbiddenError,
        internal_server_error: InternalServerError,
        rate_limit_error: RateLimitError,
        resource_not_found_error: ResourceNotFoundError,
        unauthorized_error: UnauthorizedError,
        validation_error: ValidationError,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_error => "BadRequestError",
                .forbidden_error => "ForbiddenError",
                .internal_server_error => "InternalServerError",
                .rate_limit_error => "RateLimitError",
                .resource_not_found_error => "ResourceNotFoundError",
                .unauthorized_error => "UnauthorizedError",
                .validation_error => "ValidationError",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_error => |e| e.message,
                .forbidden_error => |e| e.message,
                .internal_server_error => |e| e.message,
                .rate_limit_error => |e| e.message,
                .resource_not_found_error => |e| e.message,
                .unauthorized_error => |e| e.message,
                .validation_error => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .bad_request_error => 400,
                .forbidden_error => 403,
                .internal_server_error => 500,
                .rate_limit_error => 429,
                .resource_not_found_error => 404,
                .unauthorized_error => 401,
                .validation_error => 422,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_error => |e| e.request_id,
                .forbidden_error => |e| e.request_id,
                .internal_server_error => |e| e.request_id,
                .rate_limit_error => |e| e.request_id,
                .resource_not_found_error => |e| e.request_id,
                .unauthorized_error => |e| e.request_id,
                .validation_error => |e| e.request_id,
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

pub const BadRequestError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ForbiddenError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RateLimitError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnauthorizedError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ValidationError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
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

    if (std.mem.eql(u8, error_code, "BadRequestError")) {
        return .{ .arena = arena, .kind = .{ .bad_request_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenError")) {
        return .{ .arena = arena, .kind = .{ .forbidden_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RateLimitError")) {
        return .{ .arena = arena, .kind = .{ .rate_limit_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundError")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedError")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationError")) {
        return .{ .arena = arena, .kind = .{ .validation_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
