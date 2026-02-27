const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        batch_size_limit_exceeded_exception: BatchSizeLimitExceededException,
        concurrent_modification_exception: ConcurrentModificationException,
        internal_server_exception: InternalServerException,
        invalid_filter_exception: InvalidFilterException,
        invalid_request_exception: InvalidRequestException,
        job_not_found_exception: JobNotFoundException,
        kms_key_validation_exception: KmsKeyValidationException,
        resource_in_use_exception: ResourceInUseException,
        resource_limit_exceeded_exception: ResourceLimitExceededException,
        resource_not_found_exception: ResourceNotFoundException,
        resource_unavailable_exception: ResourceUnavailableException,
        text_size_limit_exceeded_exception: TextSizeLimitExceededException,
        too_many_requests_exception: TooManyRequestsException,
        too_many_tag_keys_exception: TooManyTagKeysException,
        too_many_tags_exception: TooManyTagsException,
        unsupported_language_exception: UnsupportedLanguageException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .batch_size_limit_exceeded_exception => "BatchSizeLimitExceededException",
                .concurrent_modification_exception => "ConcurrentModificationException",
                .internal_server_exception => "InternalServerException",
                .invalid_filter_exception => "InvalidFilterException",
                .invalid_request_exception => "InvalidRequestException",
                .job_not_found_exception => "JobNotFoundException",
                .kms_key_validation_exception => "KmsKeyValidationException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_limit_exceeded_exception => "ResourceLimitExceededException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .resource_unavailable_exception => "ResourceUnavailableException",
                .text_size_limit_exceeded_exception => "TextSizeLimitExceededException",
                .too_many_requests_exception => "TooManyRequestsException",
                .too_many_tag_keys_exception => "TooManyTagKeysException",
                .too_many_tags_exception => "TooManyTagsException",
                .unsupported_language_exception => "UnsupportedLanguageException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .batch_size_limit_exceeded_exception => |e| e.message,
                .concurrent_modification_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .invalid_filter_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .job_not_found_exception => |e| e.message,
                .kms_key_validation_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_limit_exceeded_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .resource_unavailable_exception => |e| e.message,
                .text_size_limit_exceeded_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .too_many_tag_keys_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unsupported_language_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .batch_size_limit_exceeded_exception => 400,
                .concurrent_modification_exception => 400,
                .internal_server_exception => 500,
                .invalid_filter_exception => 400,
                .invalid_request_exception => 400,
                .job_not_found_exception => 404,
                .kms_key_validation_exception => 400,
                .resource_in_use_exception => 400,
                .resource_limit_exceeded_exception => 400,
                .resource_not_found_exception => 404,
                .resource_unavailable_exception => 404,
                .text_size_limit_exceeded_exception => 400,
                .too_many_requests_exception => 429,
                .too_many_tag_keys_exception => 400,
                .too_many_tags_exception => 400,
                .unsupported_language_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .batch_size_limit_exceeded_exception => |e| e.request_id,
                .concurrent_modification_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .invalid_filter_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .job_not_found_exception => |e| e.request_id,
                .kms_key_validation_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_limit_exceeded_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .resource_unavailable_exception => |e| e.request_id,
                .text_size_limit_exceeded_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
                .too_many_tag_keys_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
                .unsupported_language_exception => |e| e.request_id,
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

pub const BatchSizeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidFilterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const JobNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KmsKeyValidationException = struct {
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

pub const ResourceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TextSizeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagKeysException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedLanguageException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
