const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        bad_request_exception: BadRequestException,
        client_exception: ClientException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_request_exception: InvalidRequestException,
        invalid_state_exception: InvalidStateException,
        not_found_exception: NotFoundException,
        resource_in_use_exception: ResourceInUseException,
        resource_limit_exceeded_exception: ResourceLimitExceededException,
        resource_not_found_exception: ResourceNotFoundException,
        resource_propagation_delay_exception: ResourcePropagationDelayException,
        server_exception: ServerException,
        service_unavailable_exception: ServiceUnavailableException,
        throttling_exception: ThrottlingException,
        unsupported_availability_zone_exception: UnsupportedAvailabilityZoneException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .bad_request_exception => "BadRequestException",
                .client_exception => "ClientException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_request_exception => "InvalidRequestException",
                .invalid_state_exception => "InvalidStateException",
                .not_found_exception => "NotFoundException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_limit_exceeded_exception => "ResourceLimitExceededException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .resource_propagation_delay_exception => "ResourcePropagationDelayException",
                .server_exception => "ServerException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .throttling_exception => "ThrottlingException",
                .unsupported_availability_zone_exception => "UnsupportedAvailabilityZoneException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .bad_request_exception => |e| e.message,
                .client_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .invalid_state_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_limit_exceeded_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .resource_propagation_delay_exception => |e| e.message,
                .server_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unsupported_availability_zone_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .bad_request_exception => 400,
                .client_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_request_exception => 400,
                .invalid_state_exception => 400,
                .not_found_exception => 404,
                .resource_in_use_exception => 409,
                .resource_limit_exceeded_exception => 400,
                .resource_not_found_exception => 404,
                .resource_propagation_delay_exception => 428,
                .server_exception => 500,
                .service_unavailable_exception => 503,
                .throttling_exception => 429,
                .unsupported_availability_zone_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .bad_request_exception => |e| e.request_id,
                .client_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .invalid_state_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_limit_exceeded_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .resource_propagation_delay_exception => |e| e.request_id,
                .server_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .unsupported_availability_zone_exception => |e| e.request_id,
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

pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BadRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClientException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourcePropagationDelayException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedAvailabilityZoneException = struct {
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClientException")) {
        return .{ .arena = arena, .kind = .{ .client_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourcePropagationDelayException")) {
        return .{ .arena = arena, .kind = .{ .resource_propagation_delay_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerException")) {
        return .{ .arena = arena, .kind = .{ .server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedAvailabilityZoneException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_availability_zone_exception = .{
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
