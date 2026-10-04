const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        concurrent_modification_exception: ConcurrentModificationException,
        invalid_pagination_token: InvalidPaginationToken,
        unsupported_locale: UnsupportedLocale,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => "ConcurrentModificationException",
                .invalid_pagination_token => "InvalidPaginationToken",
                .unsupported_locale => "UnsupportedLocale",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.message,
                .invalid_pagination_token => |e| e.message,
                .unsupported_locale => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .concurrent_modification_exception => 400,
                .invalid_pagination_token => 400,
                .unsupported_locale => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.request_id,
                .invalid_pagination_token => |e| e.request_id,
                .unsupported_locale => |e| e.request_id,
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

/// [EnableHealthServiceAccessForOrganization](https://docs.aws.amazon.com/health/latest/APIReference/API_EnableHealthServiceAccessForOrganization.html) is already in progress. Wait for the
/// action to complete before trying again. To get the current status, use the
/// [DescribeHealthServiceStatusForOrganization](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeHealthServiceStatusForOrganization.html) operation.
pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified pagination token (`nextToken`) is not valid.
pub const InvalidPaginationToken = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified locale is not supported.
pub const UnsupportedLocale = struct {
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
    if (std.mem.eql(u8, error_code, "InvalidPaginationToken")) {
        const parsed_error: ?InvalidPaginationToken = aws.json.parseJsonObject(InvalidPaginationToken, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_pagination_token = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedLocale")) {
        const parsed_error: ?UnsupportedLocale = aws.json.parseJsonObject(UnsupportedLocale, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_locale = typed_error } };
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
