const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied: AccessDenied,
        annotation_limit_exceeded: AnnotationLimitExceeded,
        annotation_name_too_long: AnnotationNameTooLong,
        bucket_already_exists: BucketAlreadyExists,
        bucket_already_owned_by_you: BucketAlreadyOwnedByYou,
        encryption_type_mismatch: EncryptionTypeMismatch,
        idempotency_parameter_mismatch: IdempotencyParameterMismatch,
        invalid_annotation_name: InvalidAnnotationName,
        invalid_object_state: InvalidObjectState,
        invalid_prefix: InvalidPrefix,
        invalid_request: InvalidRequest,
        invalid_write_offset: InvalidWriteOffset,
        no_such_annotation: NoSuchAnnotation,
        no_such_bucket: NoSuchBucket,
        no_such_key: NoSuchKey,
        no_such_upload: NoSuchUpload,
        not_found: NotFound,
        object_already_in_active_tier_error: ObjectAlreadyInActiveTierError,
        object_not_in_active_tier_error: ObjectNotInActiveTierError,
        too_many_parts: TooManyParts,
        unsupported_media_type: UnsupportedMediaType,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied => "AccessDenied",
                .annotation_limit_exceeded => "AnnotationLimitExceeded",
                .annotation_name_too_long => "AnnotationNameTooLong",
                .bucket_already_exists => "BucketAlreadyExists",
                .bucket_already_owned_by_you => "BucketAlreadyOwnedByYou",
                .encryption_type_mismatch => "EncryptionTypeMismatch",
                .idempotency_parameter_mismatch => "IdempotencyParameterMismatch",
                .invalid_annotation_name => "InvalidAnnotationName",
                .invalid_object_state => "InvalidObjectState",
                .invalid_prefix => "InvalidPrefix",
                .invalid_request => "InvalidRequest",
                .invalid_write_offset => "InvalidWriteOffset",
                .no_such_annotation => "NoSuchAnnotation",
                .no_such_bucket => "NoSuchBucket",
                .no_such_key => "NoSuchKey",
                .no_such_upload => "NoSuchUpload",
                .not_found => "NotFound",
                .object_already_in_active_tier_error => "ObjectAlreadyInActiveTierError",
                .object_not_in_active_tier_error => "ObjectNotInActiveTierError",
                .too_many_parts => "TooManyParts",
                .unsupported_media_type => "UnsupportedMediaType",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied => |e| e.message,
                .annotation_limit_exceeded => |e| e.message,
                .annotation_name_too_long => |e| e.message,
                .bucket_already_exists => |e| e.message,
                .bucket_already_owned_by_you => |e| e.message,
                .encryption_type_mismatch => |e| e.message,
                .idempotency_parameter_mismatch => |e| e.message,
                .invalid_annotation_name => |e| e.message,
                .invalid_object_state => |e| e.message,
                .invalid_prefix => |e| e.message,
                .invalid_request => |e| e.message,
                .invalid_write_offset => |e| e.message,
                .no_such_annotation => |e| e.message,
                .no_such_bucket => |e| e.message,
                .no_such_key => |e| e.message,
                .no_such_upload => |e| e.message,
                .not_found => |e| e.message,
                .object_already_in_active_tier_error => |e| e.message,
                .object_not_in_active_tier_error => |e| e.message,
                .too_many_parts => |e| e.message,
                .unsupported_media_type => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied => 403,
                .annotation_limit_exceeded => 400,
                .annotation_name_too_long => 400,
                .bucket_already_exists => 409,
                .bucket_already_owned_by_you => 409,
                .encryption_type_mismatch => 400,
                .idempotency_parameter_mismatch => 400,
                .invalid_annotation_name => 400,
                .invalid_object_state => 403,
                .invalid_prefix => 400,
                .invalid_request => 400,
                .invalid_write_offset => 400,
                .no_such_annotation => 404,
                .no_such_bucket => 404,
                .no_such_key => 404,
                .no_such_upload => 404,
                .not_found => 400,
                .object_already_in_active_tier_error => 403,
                .object_not_in_active_tier_error => 403,
                .too_many_parts => 400,
                .unsupported_media_type => 415,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied => |e| e.request_id,
                .annotation_limit_exceeded => |e| e.request_id,
                .annotation_name_too_long => |e| e.request_id,
                .bucket_already_exists => |e| e.request_id,
                .bucket_already_owned_by_you => |e| e.request_id,
                .encryption_type_mismatch => |e| e.request_id,
                .idempotency_parameter_mismatch => |e| e.request_id,
                .invalid_annotation_name => |e| e.request_id,
                .invalid_object_state => |e| e.request_id,
                .invalid_prefix => |e| e.request_id,
                .invalid_request => |e| e.request_id,
                .invalid_write_offset => |e| e.request_id,
                .no_such_annotation => |e| e.request_id,
                .no_such_bucket => |e| e.request_id,
                .no_such_key => |e| e.request_id,
                .no_such_upload => |e| e.request_id,
                .not_found => |e| e.request_id,
                .object_already_in_active_tier_error => |e| e.request_id,
                .object_not_in_active_tier_error => |e| e.request_id,
                .too_many_parts => |e| e.request_id,
                .unsupported_media_type => |e| e.request_id,
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

pub const AccessDenied = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AnnotationLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AnnotationNameTooLong = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BucketAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BucketAlreadyOwnedByYou = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EncryptionTypeMismatch = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IdempotencyParameterMismatch = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAnnotationName = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidObjectState = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPrefix = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequest = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidWriteOffset = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchAnnotation = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchBucket = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchKey = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchUpload = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ObjectAlreadyInActiveTierError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ObjectNotInActiveTierError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyParts = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedMediaType = struct {
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
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AccessDenied")) {
        return .{ .arena = arena, .kind = .{ .access_denied = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AnnotationLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .annotation_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AnnotationNameTooLong")) {
        return .{ .arena = arena, .kind = .{ .annotation_name_too_long = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .bucket_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyOwnedByYou")) {
        return .{ .arena = arena, .kind = .{ .bucket_already_owned_by_you = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionTypeMismatch")) {
        return .{ .arena = arena, .kind = .{ .encryption_type_mismatch = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotencyParameterMismatch")) {
        return .{ .arena = arena, .kind = .{ .idempotency_parameter_mismatch = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAnnotationName")) {
        return .{ .arena = arena, .kind = .{ .invalid_annotation_name = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidObjectState")) {
        return .{ .arena = arena, .kind = .{ .invalid_object_state = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPrefix")) {
        return .{ .arena = arena, .kind = .{ .invalid_prefix = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequest")) {
        return .{ .arena = arena, .kind = .{ .invalid_request = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidWriteOffset")) {
        return .{ .arena = arena, .kind = .{ .invalid_write_offset = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchAnnotation")) {
        return .{ .arena = arena, .kind = .{ .no_such_annotation = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchBucket")) {
        return .{ .arena = arena, .kind = .{ .no_such_bucket = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchKey")) {
        return .{ .arena = arena, .kind = .{ .no_such_key = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchUpload")) {
        return .{ .arena = arena, .kind = .{ .no_such_upload = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFound")) {
        return .{ .arena = arena, .kind = .{ .not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ObjectAlreadyInActiveTierError")) {
        return .{ .arena = arena, .kind = .{ .object_already_in_active_tier_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ObjectNotInActiveTierError")) {
        return .{ .arena = arena, .kind = .{ .object_not_in_active_tier_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyParts")) {
        return .{ .arena = arena, .kind = .{ .too_many_parts = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedMediaType")) {
        return .{ .arena = arena, .kind = .{ .unsupported_media_type = .{
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
