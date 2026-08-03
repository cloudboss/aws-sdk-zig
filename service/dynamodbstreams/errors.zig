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
