const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied: AccessDenied,
        bucket_already_exists: BucketAlreadyExists,
        bucket_already_owned_by_you: BucketAlreadyOwnedByYou,
        encryption_type_mismatch: EncryptionTypeMismatch,
        idempotency_parameter_mismatch: IdempotencyParameterMismatch,
        invalid_object_state: InvalidObjectState,
        invalid_request: InvalidRequest,
        invalid_write_offset: InvalidWriteOffset,
        no_such_bucket: NoSuchBucket,
        no_such_key: NoSuchKey,
        no_such_upload: NoSuchUpload,
        not_found: NotFound,
        object_already_in_active_tier_error: ObjectAlreadyInActiveTierError,
        object_not_in_active_tier_error: ObjectNotInActiveTierError,
        too_many_parts: TooManyParts,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied => "AccessDenied",
                .bucket_already_exists => "BucketAlreadyExists",
                .bucket_already_owned_by_you => "BucketAlreadyOwnedByYou",
                .encryption_type_mismatch => "EncryptionTypeMismatch",
                .idempotency_parameter_mismatch => "IdempotencyParameterMismatch",
                .invalid_object_state => "InvalidObjectState",
                .invalid_request => "InvalidRequest",
                .invalid_write_offset => "InvalidWriteOffset",
                .no_such_bucket => "NoSuchBucket",
                .no_such_key => "NoSuchKey",
                .no_such_upload => "NoSuchUpload",
                .not_found => "NotFound",
                .object_already_in_active_tier_error => "ObjectAlreadyInActiveTierError",
                .object_not_in_active_tier_error => "ObjectNotInActiveTierError",
                .too_many_parts => "TooManyParts",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied => |e| e.message,
                .bucket_already_exists => |e| e.message,
                .bucket_already_owned_by_you => |e| e.message,
                .encryption_type_mismatch => |e| e.message,
                .idempotency_parameter_mismatch => |e| e.message,
                .invalid_object_state => |e| e.message,
                .invalid_request => |e| e.message,
                .invalid_write_offset => |e| e.message,
                .no_such_bucket => |e| e.message,
                .no_such_key => |e| e.message,
                .no_such_upload => |e| e.message,
                .not_found => |e| e.message,
                .object_already_in_active_tier_error => |e| e.message,
                .object_not_in_active_tier_error => |e| e.message,
                .too_many_parts => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied => 403,
                .bucket_already_exists => 409,
                .bucket_already_owned_by_you => 409,
                .encryption_type_mismatch => 400,
                .idempotency_parameter_mismatch => 400,
                .invalid_object_state => 403,
                .invalid_request => 400,
                .invalid_write_offset => 400,
                .no_such_bucket => 404,
                .no_such_key => 404,
                .no_such_upload => 404,
                .not_found => 400,
                .object_already_in_active_tier_error => 403,
                .object_not_in_active_tier_error => 403,
                .too_many_parts => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied => |e| e.request_id,
                .bucket_already_exists => |e| e.request_id,
                .bucket_already_owned_by_you => |e| e.request_id,
                .encryption_type_mismatch => |e| e.request_id,
                .idempotency_parameter_mismatch => |e| e.request_id,
                .invalid_object_state => |e| e.request_id,
                .invalid_request => |e| e.request_id,
                .invalid_write_offset => |e| e.request_id,
                .no_such_bucket => |e| e.request_id,
                .no_such_key => |e| e.request_id,
                .no_such_upload => |e| e.request_id,
                .not_found => |e| e.request_id,
                .object_already_in_active_tier_error => |e| e.request_id,
                .object_not_in_active_tier_error => |e| e.request_id,
                .too_many_parts => |e| e.request_id,
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

pub const InvalidObjectState = struct {
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

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
