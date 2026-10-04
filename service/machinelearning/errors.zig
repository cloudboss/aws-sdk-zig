const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        idempotent_parameter_mismatch_exception: IdempotentParameterMismatchException,
        internal_server_exception: InternalServerException,
        invalid_input_exception: InvalidInputException,
        invalid_tag_exception: InvalidTagException,
        limit_exceeded_exception: LimitExceededException,
        predictor_not_mounted_exception: PredictorNotMountedException,
        resource_not_found_exception: ResourceNotFoundException,
        tag_limit_exceeded_exception: TagLimitExceededException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .idempotent_parameter_mismatch_exception => "IdempotentParameterMismatchException",
                .internal_server_exception => "InternalServerException",
                .invalid_input_exception => "InvalidInputException",
                .invalid_tag_exception => "InvalidTagException",
                .limit_exceeded_exception => "LimitExceededException",
                .predictor_not_mounted_exception => "PredictorNotMountedException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .tag_limit_exceeded_exception => "TagLimitExceededException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .idempotent_parameter_mismatch_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .invalid_input_exception => |e| e.message,
                .invalid_tag_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .predictor_not_mounted_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .tag_limit_exceeded_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .idempotent_parameter_mismatch_exception => 400,
                .internal_server_exception => 500,
                .invalid_input_exception => 400,
                .invalid_tag_exception => 400,
                .limit_exceeded_exception => 417,
                .predictor_not_mounted_exception => 400,
                .resource_not_found_exception => 404,
                .tag_limit_exceeded_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .idempotent_parameter_mismatch_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .invalid_input_exception => |e| e.request_id,
                .invalid_tag_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .predictor_not_mounted_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .tag_limit_exceeded_exception => |e| e.request_id,
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

/// A second request to use or change an object was not allowed. This can result
/// from retrying a request using a parameter that was not present in the
/// original request.
pub const IdempotentParameterMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?i32 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};

/// An error on the server occurred when trying to process a request.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?i32 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};

/// An error on the client occurred. Typically, the cause is an invalid input
/// value.
pub const InvalidInputException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?i32 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};

pub const InvalidTagException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The subscriber exceeded the maximum number of operations. This exception can
/// occur when listing objects such as `DataSource`.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?i32 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};

/// The exception is thrown when a predict request is made to an unmounted
/// `MLModel`.
pub const PredictorNotMountedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A specified resource cannot be located.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    code: ?i32 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};

pub const TagLimitExceededException = struct {
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

    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        const parsed_error: ?IdempotentParameterMismatchException = aws.json.parseJsonObject(IdempotentParameterMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        const parsed_error: ?InternalServerException = aws.json.parseJsonObject(InternalServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "InvalidTagException")) {
        const parsed_error: ?InvalidTagException = aws.json.parseJsonObject(InvalidTagException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_tag_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "PredictorNotMountedException")) {
        const parsed_error: ?PredictorNotMountedException = aws.json.parseJsonObject(PredictorNotMountedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .predictor_not_mounted_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "TagLimitExceededException")) {
        const parsed_error: ?TagLimitExceededException = aws.json.parseJsonObject(TagLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_limit_exceeded_exception = typed_error } };
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
