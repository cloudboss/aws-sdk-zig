const std = @import("std");

const ThrottlingReason = @import("throttling_reason.zig").ThrottlingReason;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        conflict_exception: ConflictException,
        invalid_args_exception: InvalidArgsException,
        invalid_arn_exception: InvalidArnException,
        invalid_domain_validation_options_exception: InvalidDomainValidationOptionsException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_state_exception: InvalidStateException,
        invalid_tag_exception: InvalidTagException,
        limit_exceeded_exception: LimitExceededException,
        request_in_progress_exception: RequestInProgressException,
        resource_in_use_exception: ResourceInUseException,
        resource_not_found_exception: ResourceNotFoundException,
        tag_policy_exception: TagPolicyException,
        throttling_exception: ThrottlingException,
        too_many_tags_exception: TooManyTagsException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .conflict_exception => "ConflictException",
                .invalid_args_exception => "InvalidArgsException",
                .invalid_arn_exception => "InvalidArnException",
                .invalid_domain_validation_options_exception => "InvalidDomainValidationOptionsException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_state_exception => "InvalidStateException",
                .invalid_tag_exception => "InvalidTagException",
                .limit_exceeded_exception => "LimitExceededException",
                .request_in_progress_exception => "RequestInProgressException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .tag_policy_exception => "TagPolicyException",
                .throttling_exception => "ThrottlingException",
                .too_many_tags_exception => "TooManyTagsException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .invalid_args_exception => |e| e.message,
                .invalid_arn_exception => |e| e.message,
                .invalid_domain_validation_options_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_state_exception => |e| e.message,
                .invalid_tag_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .request_in_progress_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .tag_policy_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .conflict_exception => 400,
                .invalid_args_exception => 400,
                .invalid_arn_exception => 400,
                .invalid_domain_validation_options_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_state_exception => 400,
                .invalid_tag_exception => 400,
                .limit_exceeded_exception => 400,
                .request_in_progress_exception => 400,
                .resource_in_use_exception => 400,
                .resource_not_found_exception => 400,
                .tag_policy_exception => 400,
                .throttling_exception => 400,
                .too_many_tags_exception => 400,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .invalid_args_exception => |e| e.request_id,
                .invalid_arn_exception => |e| e.request_id,
                .invalid_domain_validation_options_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_state_exception => |e| e.request_id,
                .invalid_tag_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .request_in_progress_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .tag_policy_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
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

/// You do not have access required to perform this action.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You are trying to update a resource or configuration that is already being
/// created or updated. Wait for the previous operation to finish and try again.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// One or more of request parameters specified is not valid.
pub const InvalidArgsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The requested Amazon Resource Name (ARN) does not refer to an existing
/// resource.
pub const InvalidArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// One or more values in the DomainValidationOption structure is incorrect.
pub const InvalidDomainValidationOptionsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An input parameter was invalid.
pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Processing has reached an invalid state.
pub const InvalidStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// One or both of the values that make up the key-value pair is not valid. For
/// example, you cannot specify a tag value that begins with `aws:`.
pub const InvalidTagException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An ACM quota has been exceeded.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The certificate request is in process and the certificate in your account
/// has not yet been issued.
pub const RequestInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The certificate is in use by another Amazon Web Services service in the
/// caller's account. Remove the association and try again.
pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified certificate cannot be found in the caller's account or the
/// caller's account cannot be found.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A specified tag did not comply with an existing tag policy and was rejected.
pub const TagPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request was denied because it exceeded a quota.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// One or more reasons why the request was throttled.
    throttling_reasons: ?[]const ThrottlingReason = null,

    pub const json_field_names = .{
        .message = "message",
        .throttling_reasons = "throttlingReasons",
    };
};

/// The request contains too many tags. Try the request again with fewer tags.
pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The supplied input failed to satisfy constraints of an Amazon Web Services
/// service.
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
