const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        bad_request_exception: BadRequestException,
        conflict_exception: ConflictException,
        limit_exceeded_exception: LimitExceededException,
        not_found_exception: NotFoundException,
        service_unavailable_exception: ServiceUnavailableException,
        too_many_requests_exception: TooManyRequestsException,
        unauthorized_exception: UnauthorizedException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => "BadRequestException",
                .conflict_exception => "ConflictException",
                .limit_exceeded_exception => "LimitExceededException",
                .not_found_exception => "NotFoundException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .too_many_requests_exception => "TooManyRequestsException",
                .unauthorized_exception => "UnauthorizedException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .unauthorized_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .bad_request_exception => 400,
                .conflict_exception => 409,
                .limit_exceeded_exception => 429,
                .not_found_exception => 404,
                .service_unavailable_exception => 503,
                .too_many_requests_exception => 429,
                .unauthorized_exception => 401,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
                .unauthorized_exception => |e| e.request_id,
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

pub const BadRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnauthorizedException = struct {
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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
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
