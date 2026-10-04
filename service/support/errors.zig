const aws = @import("aws");
const std = @import("std");

const ThrottlingReason = @import("throttling_reason.zig").ThrottlingReason;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        attachment_id_not_found: AttachmentIdNotFound,
        attachment_limit_exceeded: AttachmentLimitExceeded,
        attachment_set_expired: AttachmentSetExpired,
        attachment_set_id_not_found: AttachmentSetIdNotFound,
        attachment_set_size_limit_exceeded: AttachmentSetSizeLimitExceeded,
        case_creation_limit_exceeded: CaseCreationLimitExceeded,
        case_id_not_found: CaseIdNotFound,
        describe_attachment_limit_exceeded: DescribeAttachmentLimitExceeded,
        dry_run_operation_exception: DryRunOperationException,
        internal_server_error: InternalServerError,
        throttling_exception: ThrottlingException,
        upload_id_not_found: UploadIdNotFound,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .attachment_id_not_found => "AttachmentIdNotFound",
                .attachment_limit_exceeded => "AttachmentLimitExceeded",
                .attachment_set_expired => "AttachmentSetExpired",
                .attachment_set_id_not_found => "AttachmentSetIdNotFound",
                .attachment_set_size_limit_exceeded => "AttachmentSetSizeLimitExceeded",
                .case_creation_limit_exceeded => "CaseCreationLimitExceeded",
                .case_id_not_found => "CaseIdNotFound",
                .describe_attachment_limit_exceeded => "DescribeAttachmentLimitExceeded",
                .dry_run_operation_exception => "DryRunOperationException",
                .internal_server_error => "InternalServerError",
                .throttling_exception => "ThrottlingException",
                .upload_id_not_found => "UploadIdNotFound",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .attachment_id_not_found => |e| e.message,
                .attachment_limit_exceeded => |e| e.message,
                .attachment_set_expired => |e| e.message,
                .attachment_set_id_not_found => |e| e.message,
                .attachment_set_size_limit_exceeded => |e| e.message,
                .case_creation_limit_exceeded => |e| e.message,
                .case_id_not_found => |e| e.message,
                .describe_attachment_limit_exceeded => |e| e.message,
                .dry_run_operation_exception => |e| e.message,
                .internal_server_error => |e| e.message,
                .throttling_exception => |e| e.message,
                .upload_id_not_found => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .attachment_id_not_found => 400,
                .attachment_limit_exceeded => 400,
                .attachment_set_expired => 400,
                .attachment_set_id_not_found => 400,
                .attachment_set_size_limit_exceeded => 400,
                .case_creation_limit_exceeded => 400,
                .case_id_not_found => 400,
                .describe_attachment_limit_exceeded => 400,
                .dry_run_operation_exception => 400,
                .internal_server_error => 500,
                .throttling_exception => 400,
                .upload_id_not_found => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .attachment_id_not_found => |e| e.request_id,
                .attachment_limit_exceeded => |e| e.request_id,
                .attachment_set_expired => |e| e.request_id,
                .attachment_set_id_not_found => |e| e.request_id,
                .attachment_set_size_limit_exceeded => |e| e.request_id,
                .case_creation_limit_exceeded => |e| e.request_id,
                .case_id_not_found => |e| e.request_id,
                .describe_attachment_limit_exceeded => |e| e.request_id,
                .dry_run_operation_exception => |e| e.request_id,
                .internal_server_error => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .upload_id_not_found => |e| e.request_id,
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

/// An attachment with the specified ID could not be found.
pub const AttachmentIdNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The limit for the number of attachment sets created in a short period of
/// time has been
/// exceeded.
pub const AttachmentLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The expiration time of the attachment set has passed. The set expires 1 hour
/// after it
/// is created.
pub const AttachmentSetExpired = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An attachment set with the specified ID could not be found.
pub const AttachmentSetIdNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A limit for the size of an attachment set has been exceeded. The limits are
/// three
/// attachments and 5 MB per attachment.
pub const AttachmentSetSizeLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The case creation limit for the account has been exceeded.
pub const CaseCreationLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The requested `caseId` couldn't be located.
pub const CaseIdNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The limit for the number of DescribeAttachment requests in a short
/// period of time has been exceeded.
pub const DescribeAttachmentLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was valid, but the operation wasn't performed because `dryRun`
/// was
/// set to `true`.
pub const DryRunOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An internal server error occurred.
pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You have exceeded the maximum allowed TPS (Transactions Per Second) for the
/// operations.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// A list of one or more reasons that the request was throttled.
    throttling_reasons: ?[]const ThrottlingReason = null,

    pub const json_field_names = .{
        .message = "message",
        .throttling_reasons = "throttlingReasons",
    };
};

/// The specified `uploadId` couldn't be located.
pub const UploadIdNotFound = struct {
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

    if (std.mem.eql(u8, error_code, "AttachmentIdNotFound")) {
        const parsed_error: ?AttachmentIdNotFound = aws.json.parseJsonObject(AttachmentIdNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .attachment_id_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AttachmentLimitExceeded")) {
        const parsed_error: ?AttachmentLimitExceeded = aws.json.parseJsonObject(AttachmentLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .attachment_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AttachmentSetExpired")) {
        const parsed_error: ?AttachmentSetExpired = aws.json.parseJsonObject(AttachmentSetExpired, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .attachment_set_expired = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AttachmentSetIdNotFound")) {
        const parsed_error: ?AttachmentSetIdNotFound = aws.json.parseJsonObject(AttachmentSetIdNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .attachment_set_id_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AttachmentSetSizeLimitExceeded")) {
        const parsed_error: ?AttachmentSetSizeLimitExceeded = aws.json.parseJsonObject(AttachmentSetSizeLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .attachment_set_size_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CaseCreationLimitExceeded")) {
        const parsed_error: ?CaseCreationLimitExceeded = aws.json.parseJsonObject(CaseCreationLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .case_creation_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CaseIdNotFound")) {
        const parsed_error: ?CaseIdNotFound = aws.json.parseJsonObject(CaseIdNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .case_id_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DescribeAttachmentLimitExceeded")) {
        const parsed_error: ?DescribeAttachmentLimitExceeded = aws.json.parseJsonObject(DescribeAttachmentLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .describe_attachment_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DryRunOperationException")) {
        const parsed_error: ?DryRunOperationException = aws.json.parseJsonObject(DryRunOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .dry_run_operation_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?ThrottlingException = aws.json.parseJsonObject(ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UploadIdNotFound")) {
        const parsed_error: ?UploadIdNotFound = aws.json.parseJsonObject(UploadIdNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .upload_id_not_found = typed_error } };
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
