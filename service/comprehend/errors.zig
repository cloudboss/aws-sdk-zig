const std = @import("std");

const InvalidRequestDetail = @import("invalid_request_detail.zig").InvalidRequestDetail;
const InvalidRequestReason = @import("invalid_request_reason.zig").InvalidRequestReason;

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

/// The number of documents in the request exceeds the limit of 25. Try your
/// request again
/// with fewer documents.
pub const BatchSizeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Concurrent modification of the tags associated with an Amazon Comprehend
/// resource is not
/// supported.
pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// An internal server error occurred. Retry your request.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The filter specified for the operation is invalid. Specify a different
/// filter.
pub const InvalidFilterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request is invalid.
pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    detail: ?InvalidRequestDetail = null,

    reason: ?InvalidRequestReason = null,

    pub const json_field_names = .{
        .detail = "Detail",
        .message = "Message",
        .reason = "Reason",
    };
};

/// The specified job was not found. Check the job ID and try again.
pub const JobNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The KMS customer managed key (CMK) entered cannot be validated. Verify the
/// key and
/// re-enter it.
pub const KmsKeyValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified resource name is already in use. Use a different name and try
/// your request
/// again.
pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The maximum number of resources per account has been exceeded. Review the
/// resources, and
/// then try your request again.
pub const ResourceLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified resource ARN was not found. Check the ARN and try your request
/// again.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified resource is not available. Check the resource and try your
/// request
/// again.
pub const ResourceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The size of the input text exceeds the limit. Use a smaller document.
pub const TextSizeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The number of requests exceeds the limit. Resubmit your request later.
pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request contains more tag keys than can be associated with a resource
/// (50 tag keys per
/// resource).
pub const TooManyTagKeysException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request contains more tags than can be associated with a resource (50
/// tags per
/// resource). The maximum number of tags includes both existing tags and those
/// included in your
/// current request.
pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Amazon Comprehend can't process the language of the input text. For a list
/// of supported languages,
/// [Supported
/// languages](https://docs.aws.amazon.com/comprehend/latest/dg/supported-languages.html) in the Comprehend Developer Guide.
pub const UnsupportedLanguageException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
