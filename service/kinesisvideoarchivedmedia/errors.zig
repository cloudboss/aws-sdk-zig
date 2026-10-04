const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        client_limit_exceeded_exception: ClientLimitExceededException,
        invalid_argument_exception: InvalidArgumentException,
        invalid_codec_private_data_exception: InvalidCodecPrivateDataException,
        invalid_media_frame_exception: InvalidMediaFrameException,
        missing_codec_private_data_exception: MissingCodecPrivateDataException,
        no_data_retention_exception: NoDataRetentionException,
        not_authorized_exception: NotAuthorizedException,
        resource_not_found_exception: ResourceNotFoundException,
        unsupported_stream_media_type_exception: UnsupportedStreamMediaTypeException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .client_limit_exceeded_exception => "ClientLimitExceededException",
                .invalid_argument_exception => "InvalidArgumentException",
                .invalid_codec_private_data_exception => "InvalidCodecPrivateDataException",
                .invalid_media_frame_exception => "InvalidMediaFrameException",
                .missing_codec_private_data_exception => "MissingCodecPrivateDataException",
                .no_data_retention_exception => "NoDataRetentionException",
                .not_authorized_exception => "NotAuthorizedException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .unsupported_stream_media_type_exception => "UnsupportedStreamMediaTypeException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .client_limit_exceeded_exception => |e| e.message,
                .invalid_argument_exception => |e| e.message,
                .invalid_codec_private_data_exception => |e| e.message,
                .invalid_media_frame_exception => |e| e.message,
                .missing_codec_private_data_exception => |e| e.message,
                .no_data_retention_exception => |e| e.message,
                .not_authorized_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .unsupported_stream_media_type_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .client_limit_exceeded_exception => 400,
                .invalid_argument_exception => 400,
                .invalid_codec_private_data_exception => 400,
                .invalid_media_frame_exception => 400,
                .missing_codec_private_data_exception => 400,
                .no_data_retention_exception => 400,
                .not_authorized_exception => 401,
                .resource_not_found_exception => 404,
                .unsupported_stream_media_type_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .client_limit_exceeded_exception => |e| e.request_id,
                .invalid_argument_exception => |e| e.request_id,
                .invalid_codec_private_data_exception => |e| e.request_id,
                .invalid_media_frame_exception => |e| e.request_id,
                .missing_codec_private_data_exception => |e| e.request_id,
                .no_data_retention_exception => |e| e.request_id,
                .not_authorized_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .unsupported_stream_media_type_exception => |e| e.request_id,
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

pub const ClientLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidArgumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidCodecPrivateDataException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidMediaFrameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MissingCodecPrivateDataException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoDataRetentionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotAuthorizedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedStreamMediaTypeException = struct {
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

    if (std.mem.eql(u8, error_code, "ClientLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .client_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArgumentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCodecPrivateDataException")) {
        return .{ .arena = arena, .kind = .{ .invalid_codec_private_data_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidMediaFrameException")) {
        return .{ .arena = arena, .kind = .{ .invalid_media_frame_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingCodecPrivateDataException")) {
        return .{ .arena = arena, .kind = .{ .missing_codec_private_data_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoDataRetentionException")) {
        return .{ .arena = arena, .kind = .{ .no_data_retention_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedStreamMediaTypeException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_stream_media_type_exception = .{
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
