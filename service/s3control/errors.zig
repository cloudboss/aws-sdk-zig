const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        bad_request_exception: BadRequestException,
        bucket_already_exists: BucketAlreadyExists,
        bucket_already_owned_by_you: BucketAlreadyOwnedByYou,
        idempotency_exception: IdempotencyException,
        internal_service_exception: InternalServiceException,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_request_exception: InvalidRequestException,
        job_status_exception: JobStatusException,
        no_such_public_access_block_configuration: NoSuchPublicAccessBlockConfiguration,
        not_found_exception: NotFoundException,
        too_many_requests_exception: TooManyRequestsException,
        too_many_tags_exception: TooManyTagsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => "BadRequestException",
                .bucket_already_exists => "BucketAlreadyExists",
                .bucket_already_owned_by_you => "BucketAlreadyOwnedByYou",
                .idempotency_exception => "IdempotencyException",
                .internal_service_exception => "InternalServiceException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_request_exception => "InvalidRequestException",
                .job_status_exception => "JobStatusException",
                .no_such_public_access_block_configuration => "NoSuchPublicAccessBlockConfiguration",
                .not_found_exception => "NotFoundException",
                .too_many_requests_exception => "TooManyRequestsException",
                .too_many_tags_exception => "TooManyTagsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => |e| e.message,
                .bucket_already_exists => |e| e.message,
                .bucket_already_owned_by_you => |e| e.message,
                .idempotency_exception => |e| e.message,
                .internal_service_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .job_status_exception => |e| e.message,
                .no_such_public_access_block_configuration => |e| e.message,
                .not_found_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .bad_request_exception => 400,
                .bucket_already_exists => 400,
                .bucket_already_owned_by_you => 400,
                .idempotency_exception => 400,
                .internal_service_exception => 500,
                .invalid_next_token_exception => 400,
                .invalid_request_exception => 400,
                .job_status_exception => 400,
                .no_such_public_access_block_configuration => 404,
                .not_found_exception => 400,
                .too_many_requests_exception => 400,
                .too_many_tags_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .bad_request_exception => |e| e.request_id,
                .bucket_already_exists => |e| e.request_id,
                .bucket_already_owned_by_you => |e| e.request_id,
                .idempotency_exception => |e| e.request_id,
                .internal_service_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .job_status_exception => |e| e.request_id,
                .no_such_public_access_block_configuration => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
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

pub const BadRequestException = struct {
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

pub const IdempotencyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const JobStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoSuchPublicAccessBlockConfiguration = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
