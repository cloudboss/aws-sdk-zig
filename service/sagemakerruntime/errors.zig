const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        internal_dependency_exception: InternalDependencyException,
        internal_failure: InternalFailure,
        internal_stream_failure: InternalStreamFailure,
        model_error: ModelError,
        model_not_ready_exception: ModelNotReadyException,
        model_stream_error: ModelStreamError,
        service_unavailable: ServiceUnavailable,
        validation_error: ValidationError,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .internal_dependency_exception => "InternalDependencyException",
                .internal_failure => "InternalFailure",
                .internal_stream_failure => "InternalStreamFailure",
                .model_error => "ModelError",
                .model_not_ready_exception => "ModelNotReadyException",
                .model_stream_error => "ModelStreamError",
                .service_unavailable => "ServiceUnavailable",
                .validation_error => "ValidationError",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .internal_dependency_exception => |e| e.message,
                .internal_failure => |e| e.message,
                .internal_stream_failure => |e| e.message,
                .model_error => |e| e.message,
                .model_not_ready_exception => |e| e.message,
                .model_stream_error => |e| e.message,
                .service_unavailable => |e| e.message,
                .validation_error => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .internal_dependency_exception => 530,
                .internal_failure => 500,
                .internal_stream_failure => 500,
                .model_error => 424,
                .model_not_ready_exception => 429,
                .model_stream_error => 400,
                .service_unavailable => 503,
                .validation_error => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .internal_dependency_exception => |e| e.request_id,
                .internal_failure => |e| e.request_id,
                .internal_stream_failure => |e| e.request_id,
                .model_error => |e| e.request_id,
                .model_not_ready_exception => |e| e.request_id,
                .model_stream_error => |e| e.request_id,
                .service_unavailable => |e| e.request_id,
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

pub const InternalDependencyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalFailure = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalStreamFailure = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ModelError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ModelNotReadyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ModelStreamError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceUnavailable = struct {
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

    if (std.mem.eql(u8, error_code, "InternalDependencyException")) {
        return .{ .arena = arena, .kind = .{ .internal_dependency_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailure")) {
        return .{ .arena = arena, .kind = .{ .internal_failure = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalStreamFailure")) {
        return .{ .arena = arena, .kind = .{ .internal_stream_failure = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ModelError")) {
        return .{ .arena = arena, .kind = .{ .model_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ModelNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .model_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ModelStreamError")) {
        return .{ .arena = arena, .kind = .{ .model_stream_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailable")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable = .{
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
