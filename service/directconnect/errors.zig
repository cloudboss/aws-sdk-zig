const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        direct_connect_client_exception: DirectConnectClientException,
        direct_connect_server_exception: DirectConnectServerException,
        duplicate_tag_keys_exception: DuplicateTagKeysException,
        too_many_tags_exception: TooManyTagsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .direct_connect_client_exception => "DirectConnectClientException",
                .direct_connect_server_exception => "DirectConnectServerException",
                .duplicate_tag_keys_exception => "DuplicateTagKeysException",
                .too_many_tags_exception => "TooManyTagsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .direct_connect_client_exception => |e| e.message,
                .direct_connect_server_exception => |e| e.message,
                .duplicate_tag_keys_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .direct_connect_client_exception => 400,
                .direct_connect_server_exception => 500,
                .duplicate_tag_keys_exception => 400,
                .too_many_tags_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .direct_connect_client_exception => |e| e.request_id,
                .direct_connect_server_exception => |e| e.request_id,
                .duplicate_tag_keys_exception => |e| e.request_id,
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

/// One or more parameters are not valid.
pub const DirectConnectClientException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A server-side error occurred.
pub const DirectConnectServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A tag key was specified more than once.
pub const DuplicateTagKeysException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have reached the limit on the number of tags that can be assigned.
pub const TooManyTagsException = struct {
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

    if (std.mem.eql(u8, error_code, "DirectConnectClientException")) {
        const parsed_error: ?DirectConnectClientException = aws.json.parseJsonObject(DirectConnectClientException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .direct_connect_client_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DirectConnectServerException")) {
        const parsed_error: ?DirectConnectServerException = aws.json.parseJsonObject(DirectConnectServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .direct_connect_server_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateTagKeysException")) {
        const parsed_error: ?DuplicateTagKeysException = aws.json.parseJsonObject(DuplicateTagKeysException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_tag_keys_exception = typed_error } };
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
