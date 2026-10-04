const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        channel_insufficient_permission: ChannelInsufficientPermission,
        channel_not_found: ChannelNotFound,
        channel_unsupported_schema: ChannelUnsupportedSchema,
        duplicated_audit_event_id: DuplicatedAuditEventId,
        invalid_channel_arn: InvalidChannelARN,
        unsupported_operation_exception: UnsupportedOperationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .channel_insufficient_permission => "ChannelInsufficientPermission",
                .channel_not_found => "ChannelNotFound",
                .channel_unsupported_schema => "ChannelUnsupportedSchema",
                .duplicated_audit_event_id => "DuplicatedAuditEventId",
                .invalid_channel_arn => "InvalidChannelARN",
                .unsupported_operation_exception => "UnsupportedOperationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .channel_insufficient_permission => |e| e.message,
                .channel_not_found => |e| e.message,
                .channel_unsupported_schema => |e| e.message,
                .duplicated_audit_event_id => |e| e.message,
                .invalid_channel_arn => |e| e.message,
                .unsupported_operation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .channel_insufficient_permission => 400,
                .channel_not_found => 400,
                .channel_unsupported_schema => 400,
                .duplicated_audit_event_id => 400,
                .invalid_channel_arn => 400,
                .unsupported_operation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .channel_insufficient_permission => |e| e.request_id,
                .channel_not_found => |e| e.request_id,
                .channel_unsupported_schema => |e| e.request_id,
                .duplicated_audit_event_id => |e| e.request_id,
                .invalid_channel_arn => |e| e.request_id,
                .unsupported_operation_exception => |e| e.request_id,
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

pub const ChannelInsufficientPermission = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ChannelNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ChannelUnsupportedSchema = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicatedAuditEventId = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidChannelARN = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedOperationException = struct {
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

    if (std.mem.eql(u8, error_code, "ChannelInsufficientPermission")) {
        return .{ .arena = arena, .kind = .{ .channel_insufficient_permission = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ChannelNotFound")) {
        return .{ .arena = arena, .kind = .{ .channel_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ChannelUnsupportedSchema")) {
        return .{ .arena = arena, .kind = .{ .channel_unsupported_schema = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicatedAuditEventId")) {
        return .{ .arena = arena, .kind = .{ .duplicated_audit_event_id = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidChannelARN")) {
        return .{ .arena = arena, .kind = .{ .invalid_channel_arn = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
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
