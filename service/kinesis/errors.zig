const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        expired_iterator_exception: ExpiredIteratorException,
        expired_next_token_exception: ExpiredNextTokenException,
        internal_failure_exception: InternalFailureException,
        invalid_argument_exception: InvalidArgumentException,
        kms_access_denied_exception: KMSAccessDeniedException,
        kms_disabled_exception: KMSDisabledException,
        kms_invalid_state_exception: KMSInvalidStateException,
        kms_not_found_exception: KMSNotFoundException,
        kms_opt_in_required: KMSOptInRequired,
        kms_throttling_exception: KMSThrottlingException,
        limit_exceeded_exception: LimitExceededException,
        provisioned_throughput_exceeded_exception: ProvisionedThroughputExceededException,
        resource_in_use_exception: ResourceInUseException,
        resource_not_found_exception: ResourceNotFoundException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .expired_iterator_exception => "ExpiredIteratorException",
                .expired_next_token_exception => "ExpiredNextTokenException",
                .internal_failure_exception => "InternalFailureException",
                .invalid_argument_exception => "InvalidArgumentException",
                .kms_access_denied_exception => "KMSAccessDeniedException",
                .kms_disabled_exception => "KMSDisabledException",
                .kms_invalid_state_exception => "KMSInvalidStateException",
                .kms_not_found_exception => "KMSNotFoundException",
                .kms_opt_in_required => "KMSOptInRequired",
                .kms_throttling_exception => "KMSThrottlingException",
                .limit_exceeded_exception => "LimitExceededException",
                .provisioned_throughput_exceeded_exception => "ProvisionedThroughputExceededException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .expired_iterator_exception => |e| e.message,
                .expired_next_token_exception => |e| e.message,
                .internal_failure_exception => |e| e.message,
                .invalid_argument_exception => |e| e.message,
                .kms_access_denied_exception => |e| e.message,
                .kms_disabled_exception => |e| e.message,
                .kms_invalid_state_exception => |e| e.message,
                .kms_not_found_exception => |e| e.message,
                .kms_opt_in_required => |e| e.message,
                .kms_throttling_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .provisioned_throughput_exceeded_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 400,
                .expired_iterator_exception => 400,
                .expired_next_token_exception => 400,
                .internal_failure_exception => 500,
                .invalid_argument_exception => 400,
                .kms_access_denied_exception => 400,
                .kms_disabled_exception => 400,
                .kms_invalid_state_exception => 400,
                .kms_not_found_exception => 400,
                .kms_opt_in_required => 400,
                .kms_throttling_exception => 400,
                .limit_exceeded_exception => 400,
                .provisioned_throughput_exceeded_exception => 400,
                .resource_in_use_exception => 400,
                .resource_not_found_exception => 400,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .expired_iterator_exception => |e| e.request_id,
                .expired_next_token_exception => |e| e.request_id,
                .internal_failure_exception => |e| e.request_id,
                .invalid_argument_exception => |e| e.request_id,
                .kms_access_denied_exception => |e| e.request_id,
                .kms_disabled_exception => |e| e.request_id,
                .kms_invalid_state_exception => |e| e.request_id,
                .kms_not_found_exception => |e| e.request_id,
                .kms_opt_in_required => |e| e.request_id,
                .kms_throttling_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .provisioned_throughput_exceeded_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .validation_exception => |e| e.request_id,
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

/// Specifies that you do not have the permissions required to perform this
/// operation.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The provided iterator exceeds the maximum age allowed.
pub const ExpiredIteratorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The pagination token passed to the operation is expired.
pub const ExpiredNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The processing of the request failed because of an unknown error, exception,
/// or
/// failure.
pub const InternalFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A specified parameter exceeds its restrictions, is not supported, or can't
/// be used.
/// For more information, see the returned message.
pub const InvalidArgumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The ciphertext references a key that doesn't exist or that you don't have
/// access
/// to.
pub const KMSAccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the specified customer master key (CMK)
/// isn't
/// enabled.
pub const KMSDisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the state of the specified resource isn't
/// valid for
/// this request. For more information, see [How Key State Affects Use of a
/// Customer Master
/// Key](https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html)
/// in the *Amazon Web Services Key Management
/// Service Developer Guide*.
pub const KMSInvalidStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was rejected because the specified entity or resource can't be
/// found.
pub const KMSNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The Amazon Web Services access key ID needs a subscription for the service.
pub const KMSOptInRequired = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was denied due to request throttling. For more information about
/// throttling, see
/// [Limits](https://docs.aws.amazon.com/kms/latest/developerguide/limits.html#requests-per-second) in
/// the *Amazon Web Services Key Management Service Developer
/// Guide*.
pub const KMSThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The requested resource exceeds the maximum number allowed, or the number of
/// concurrent
/// stream requests exceeds the maximum number allowed.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request rate for the stream is too high, or the requested data is too
/// large for
/// the available throughput. Reduce the frequency or size of your requests. For
/// more
/// information, see [Streams
/// Limits](https://docs.aws.amazon.com/kinesis/latest/dev/service-sizes-and-limits.html) in the
/// *Amazon Kinesis Data Streams Developer Guide*, and [Error Retries and
/// Exponential Backoff in Amazon Web
/// Services](https://docs.aws.amazon.com/general/latest/gr/api-retries.html) in
/// the *Amazon Web Services General Reference*.
pub const ProvisionedThroughputExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The resource is not available for this operation. For successful operation,
/// the
/// resource must be in the `ACTIVE` state.
pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The requested resource could not be found. The stream might not be specified
/// correctly.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Specifies that you tried to invoke this API for a data stream with the
/// on-demand
/// capacity mode. This API is only supported for data streams with the
/// provisioned capacity
/// mode.
pub const ValidationException = struct {
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
