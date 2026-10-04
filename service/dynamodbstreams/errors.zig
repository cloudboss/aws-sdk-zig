const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        expired_iterator_exception: ExpiredIteratorException,
        internal_server_error: InternalServerError,
        limit_exceeded_exception: LimitExceededException,
        resource_not_found_exception: ResourceNotFoundException,
        trimmed_data_access_exception: TrimmedDataAccessException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .expired_iterator_exception => "ExpiredIteratorException",
                .internal_server_error => "InternalServerError",
                .limit_exceeded_exception => "LimitExceededException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .trimmed_data_access_exception => "TrimmedDataAccessException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .expired_iterator_exception => |e| e.message,
                .internal_server_error => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .trimmed_data_access_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .expired_iterator_exception => 400,
                .internal_server_error => 500,
                .limit_exceeded_exception => 400,
                .resource_not_found_exception => 400,
                .trimmed_data_access_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .expired_iterator_exception => |e| e.request_id,
                .internal_server_error => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .trimmed_data_access_exception => |e| e.request_id,
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

/// The shard iterator has expired and can no longer be used to retrieve stream
/// records. A shard
/// iterator expires 15 minutes after it is retrieved using the
/// `GetShardIterator`
/// action.
pub const ExpiredIteratorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An error occurred on the server side.
pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// There is no limit to the number of daily on-demand backups that can be
/// taken.
///
/// For most purposes, up to 500 simultaneous table operations are allowed per
/// account. These operations
/// include `CreateTable`, `UpdateTable`,
/// `DeleteTable`,`UpdateTimeToLive`,
/// `RestoreTableFromBackup`, and `RestoreTableToPointInTime`.
///
/// When you are creating a table with one or more secondary
/// indexes, you can have up to 250 such requests running at a time. However, if
/// the table or
/// index specifications are complex, then DynamoDB might temporarily reduce the
/// number
/// of concurrent operations.
///
/// When importing into DynamoDB, up to 50 simultaneous import table operations
/// are allowed per account.
///
/// There is a soft account quota of 2,500 tables.
///
/// GetRecords was called with a value of more than 1000 for the limit request
/// parameter.
///
/// More than 2 processes are reading from the same streams shard at the same
/// time. Exceeding
/// this limit may result in request throttling.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation tried to access a nonexistent table or index. The resource
/// might not be specified correctly, or its status might not be
/// `ACTIVE`.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation attempted to read past the oldest stream record in a shard.
///
/// In DynamoDB Streams, there is a 24 hour limit on data retention. Stream
/// records whose age exceeds this limit are subject to removal (trimming) from
/// the stream. You might receive a TrimmedDataAccessException if:
///
/// * You request a shard iterator with a sequence number older than the trim
///   point (24 hours).
///
/// * You obtain a shard iterator, but before you use the iterator in a
///   `GetRecords`
/// request, a stream record in the shard exceeds the 24 hour period and is
/// trimmed. This causes
/// the iterator to access a record that no longer exists.
pub const TrimmedDataAccessException = struct {
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

    if (std.mem.eql(u8, error_code, "ExpiredIteratorException")) {
        const parsed_error: ?ExpiredIteratorException = aws.json.parseJsonObject(ExpiredIteratorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .expired_iterator_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        const parsed_error: ?InternalServerError = aws.json.parseJsonObject(InternalServerError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_error = typed_error } };
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
    if (std.mem.eql(u8, error_code, "TrimmedDataAccessException")) {
        const parsed_error: ?TrimmedDataAccessException = aws.json.parseJsonObject(TrimmedDataAccessException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .trimmed_data_access_exception = typed_error } };
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
