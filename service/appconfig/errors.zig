const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        bad_request_exception: BadRequestException,
        conflict_exception: ConflictException,
        internal_server_exception: InternalServerException,
        payload_too_large_exception: PayloadTooLargeException,
        resource_not_found_exception: ResourceNotFoundException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => "BadRequestException",
                .conflict_exception => "ConflictException",
                .internal_server_exception => "InternalServerException",
                .payload_too_large_exception => "PayloadTooLargeException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .payload_too_large_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .bad_request_exception => 400,
                .conflict_exception => 409,
                .internal_server_exception => 500,
                .payload_too_large_exception => 413,
                .resource_not_found_exception => 404,
                .service_quota_exceeded_exception => 402,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .payload_too_large_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
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

pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PayloadTooLargeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceQuotaExceededException = struct {
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PayloadTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .payload_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
