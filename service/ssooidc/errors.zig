const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        authorization_pending_exception: AuthorizationPendingException,
        expired_token_exception: ExpiredTokenException,
        internal_server_exception: InternalServerException,
        invalid_client_exception: InvalidClientException,
        invalid_client_metadata_exception: InvalidClientMetadataException,
        invalid_grant_exception: InvalidGrantException,
        invalid_redirect_uri_exception: InvalidRedirectUriException,
        invalid_request_exception: InvalidRequestException,
        invalid_request_region_exception: InvalidRequestRegionException,
        invalid_scope_exception: InvalidScopeException,
        slow_down_exception: SlowDownException,
        unauthorized_client_exception: UnauthorizedClientException,
        unsupported_grant_type_exception: UnsupportedGrantTypeException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .authorization_pending_exception => "AuthorizationPendingException",
                .expired_token_exception => "ExpiredTokenException",
                .internal_server_exception => "InternalServerException",
                .invalid_client_exception => "InvalidClientException",
                .invalid_client_metadata_exception => "InvalidClientMetadataException",
                .invalid_grant_exception => "InvalidGrantException",
                .invalid_redirect_uri_exception => "InvalidRedirectUriException",
                .invalid_request_exception => "InvalidRequestException",
                .invalid_request_region_exception => "InvalidRequestRegionException",
                .invalid_scope_exception => "InvalidScopeException",
                .slow_down_exception => "SlowDownException",
                .unauthorized_client_exception => "UnauthorizedClientException",
                .unsupported_grant_type_exception => "UnsupportedGrantTypeException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .authorization_pending_exception => |e| e.message,
                .expired_token_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .invalid_client_exception => |e| e.message,
                .invalid_client_metadata_exception => |e| e.message,
                .invalid_grant_exception => |e| e.message,
                .invalid_redirect_uri_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .invalid_request_region_exception => |e| e.message,
                .invalid_scope_exception => |e| e.message,
                .slow_down_exception => |e| e.message,
                .unauthorized_client_exception => |e| e.message,
                .unsupported_grant_type_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 400,
                .authorization_pending_exception => 400,
                .expired_token_exception => 400,
                .internal_server_exception => 500,
                .invalid_client_exception => 401,
                .invalid_client_metadata_exception => 400,
                .invalid_grant_exception => 400,
                .invalid_redirect_uri_exception => 400,
                .invalid_request_exception => 400,
                .invalid_request_region_exception => 400,
                .invalid_scope_exception => 400,
                .slow_down_exception => 400,
                .unauthorized_client_exception => 400,
                .unsupported_grant_type_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .authorization_pending_exception => |e| e.request_id,
                .expired_token_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .invalid_client_exception => |e| e.request_id,
                .invalid_client_metadata_exception => |e| e.request_id,
                .invalid_grant_exception => |e| e.request_id,
                .invalid_redirect_uri_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .invalid_request_region_exception => |e| e.request_id,
                .invalid_scope_exception => |e| e.request_id,
                .slow_down_exception => |e| e.request_id,
                .unauthorized_client_exception => |e| e.request_id,
                .unsupported_grant_type_exception => |e| e.request_id,
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

pub const AuthorizationPendingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ExpiredTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidClientException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidClientMetadataException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidGrantException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRedirectUriException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestRegionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidScopeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SlowDownException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnauthorizedClientException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedGrantTypeException = struct {
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
    if (std.mem.eql(u8, error_code, "AuthorizationPendingException")) {
        return .{ .arena = arena, .kind = .{ .authorization_pending_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExpiredTokenException")) {
        return .{ .arena = arena, .kind = .{ .expired_token_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidClientException")) {
        return .{ .arena = arena, .kind = .{ .invalid_client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClientMetadataException")) {
        return .{ .arena = arena, .kind = .{ .invalid_client_metadata_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGrantException")) {
        return .{ .arena = arena, .kind = .{ .invalid_grant_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRedirectUriException")) {
        return .{ .arena = arena, .kind = .{ .invalid_redirect_uri_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidRequestRegionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_region_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidScopeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_scope_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SlowDownException")) {
        return .{ .arena = arena, .kind = .{ .slow_down_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedClientException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedGrantTypeException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_grant_type_exception = .{
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
