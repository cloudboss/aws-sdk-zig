const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        already_streamed_exception: AlreadyStreamedException,
        concurrent_modification_exception: ConcurrentModificationException,
        duplicate_request_exception: DuplicateRequestException,
        internal_error_exception: InternalErrorException,
        invalid_configuration_exception: InvalidConfigurationException,
        invalid_lambda_function_output_exception: InvalidLambdaFunctionOutputException,
        invalid_parameter_exception: InvalidParameterException,
        lambda_throttled_exception: LambdaThrottledException,
        limit_exceeded_exception: LimitExceededException,
        not_authorized_exception: NotAuthorizedException,
        resource_conflict_exception: ResourceConflictException,
        resource_not_found_exception: ResourceNotFoundException,
        too_many_requests_exception: TooManyRequestsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .already_streamed_exception => "AlreadyStreamedException",
                .concurrent_modification_exception => "ConcurrentModificationException",
                .duplicate_request_exception => "DuplicateRequestException",
                .internal_error_exception => "InternalErrorException",
                .invalid_configuration_exception => "InvalidConfigurationException",
                .invalid_lambda_function_output_exception => "InvalidLambdaFunctionOutputException",
                .invalid_parameter_exception => "InvalidParameterException",
                .lambda_throttled_exception => "LambdaThrottledException",
                .limit_exceeded_exception => "LimitExceededException",
                .not_authorized_exception => "NotAuthorizedException",
                .resource_conflict_exception => "ResourceConflictException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .too_many_requests_exception => "TooManyRequestsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .already_streamed_exception => |e| e.message,
                .concurrent_modification_exception => |e| e.message,
                .duplicate_request_exception => |e| e.message,
                .internal_error_exception => |e| e.message,
                .invalid_configuration_exception => |e| e.message,
                .invalid_lambda_function_output_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .lambda_throttled_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .not_authorized_exception => |e| e.message,
                .resource_conflict_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .already_streamed_exception => 400,
                .concurrent_modification_exception => 400,
                .duplicate_request_exception => 400,
                .internal_error_exception => 500,
                .invalid_configuration_exception => 400,
                .invalid_lambda_function_output_exception => 400,
                .invalid_parameter_exception => 400,
                .lambda_throttled_exception => 429,
                .limit_exceeded_exception => 400,
                .not_authorized_exception => 403,
                .resource_conflict_exception => 409,
                .resource_not_found_exception => 404,
                .too_many_requests_exception => 429,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .already_streamed_exception => |e| e.request_id,
                .concurrent_modification_exception => |e| e.request_id,
                .duplicate_request_exception => |e| e.request_id,
                .internal_error_exception => |e| e.request_id,
                .invalid_configuration_exception => |e| e.request_id,
                .invalid_lambda_function_output_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .lambda_throttled_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .not_authorized_exception => |e| e.request_id,
                .resource_conflict_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
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

pub const AlreadyStreamedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidLambdaFunctionOutputException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LambdaThrottledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotAuthorizedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRequestsException = struct {
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

    if (std.mem.eql(u8, error_code, "AlreadyStreamedException")) {
        return .{ .arena = arena, .kind = .{ .already_streamed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateRequestException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLambdaFunctionOutputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_lambda_function_output_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LambdaThrottledException")) {
        return .{ .arena = arena, .kind = .{ .lambda_throttled_exception = .{
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
    if (std.mem.eql(u8, error_code, "NotAuthorizedException")) {
        return .{ .arena = arena, .kind = .{ .not_authorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceConflictException")) {
        return .{ .arena = arena, .kind = .{ .resource_conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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
