const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        certificate_mismatch_exception: CertificateMismatchException,
        concurrent_modification_exception: ConcurrentModificationException,
        invalid_args_exception: InvalidArgsException,
        invalid_arn_exception: InvalidArnException,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_policy_exception: InvalidPolicyException,
        invalid_request_exception: InvalidRequestException,
        invalid_state_exception: InvalidStateException,
        invalid_tag_exception: InvalidTagException,
        limit_exceeded_exception: LimitExceededException,
        lockout_prevented_exception: LockoutPreventedException,
        malformed_certificate_exception: MalformedCertificateException,
        malformed_csr_exception: MalformedCSRException,
        permission_already_exists_exception: PermissionAlreadyExistsException,
        request_already_processed_exception: RequestAlreadyProcessedException,
        request_failed_exception: RequestFailedException,
        request_in_progress_exception: RequestInProgressException,
        resource_not_found_exception: ResourceNotFoundException,
        too_many_tags_exception: TooManyTagsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .certificate_mismatch_exception => "CertificateMismatchException",
                .concurrent_modification_exception => "ConcurrentModificationException",
                .invalid_args_exception => "InvalidArgsException",
                .invalid_arn_exception => "InvalidArnException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_policy_exception => "InvalidPolicyException",
                .invalid_request_exception => "InvalidRequestException",
                .invalid_state_exception => "InvalidStateException",
                .invalid_tag_exception => "InvalidTagException",
                .limit_exceeded_exception => "LimitExceededException",
                .lockout_prevented_exception => "LockoutPreventedException",
                .malformed_certificate_exception => "MalformedCertificateException",
                .malformed_csr_exception => "MalformedCSRException",
                .permission_already_exists_exception => "PermissionAlreadyExistsException",
                .request_already_processed_exception => "RequestAlreadyProcessedException",
                .request_failed_exception => "RequestFailedException",
                .request_in_progress_exception => "RequestInProgressException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .too_many_tags_exception => "TooManyTagsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .certificate_mismatch_exception => |e| e.message,
                .concurrent_modification_exception => |e| e.message,
                .invalid_args_exception => |e| e.message,
                .invalid_arn_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_policy_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .invalid_state_exception => |e| e.message,
                .invalid_tag_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .lockout_prevented_exception => |e| e.message,
                .malformed_certificate_exception => |e| e.message,
                .malformed_csr_exception => |e| e.message,
                .permission_already_exists_exception => |e| e.message,
                .request_already_processed_exception => |e| e.message,
                .request_failed_exception => |e| e.message,
                .request_in_progress_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .certificate_mismatch_exception => 400,
                .concurrent_modification_exception => 400,
                .invalid_args_exception => 400,
                .invalid_arn_exception => 400,
                .invalid_next_token_exception => 400,
                .invalid_policy_exception => 400,
                .invalid_request_exception => 400,
                .invalid_state_exception => 400,
                .invalid_tag_exception => 400,
                .limit_exceeded_exception => 400,
                .lockout_prevented_exception => 400,
                .malformed_certificate_exception => 400,
                .malformed_csr_exception => 400,
                .permission_already_exists_exception => 400,
                .request_already_processed_exception => 400,
                .request_failed_exception => 400,
                .request_in_progress_exception => 400,
                .resource_not_found_exception => 400,
                .too_many_tags_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .certificate_mismatch_exception => |e| e.request_id,
                .concurrent_modification_exception => |e| e.request_id,
                .invalid_args_exception => |e| e.request_id,
                .invalid_arn_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_policy_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .invalid_state_exception => |e| e.request_id,
                .invalid_tag_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .lockout_prevented_exception => |e| e.request_id,
                .malformed_certificate_exception => |e| e.request_id,
                .malformed_csr_exception => |e| e.request_id,
                .permission_already_exists_exception => |e| e.request_id,
                .request_already_processed_exception => |e| e.request_id,
                .request_failed_exception => |e| e.request_id,
                .request_in_progress_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
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

/// The certificate authority certificate you are importing does not comply with
/// conditions specified in the certificate that signed it.
pub const CertificateMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A previous update to your private CA is still ongoing.
pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// One or more of the specified arguments was not valid.
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

/// The token specified in the `NextToken` argument is not valid. Use the token
/// returned from your previous call to
/// [ListCertificateAuthorities](https://docs.aws.amazon.com/privateca/latest/APIReference/API_ListCertificateAuthorities.html).
pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The resource policy is invalid or is missing a required statement. For
/// general information about IAM policy and statement structure, see [Overview
/// of JSON
/// Policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#access_policies-json).
pub const InvalidPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request action cannot be performed or is prohibited.
pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The state of the private CA does not allow this action to occur.
pub const InvalidStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The tag associated with the CA is not valid. The invalid argument is
/// contained in the message field.
pub const InvalidTagException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An Amazon Web Services Private CA quota has been exceeded. See the exception
/// message returned to determine the quota that was exceeded.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The current action was prevented because it would lock the caller out from
/// performing subsequent actions. Verify that the specified parameters would
/// not result in the caller being denied access to the resource.
pub const LockoutPreventedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// One or more fields in the certificate are invalid.
pub const MalformedCertificateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The certificate signing request is invalid.
pub const MalformedCSRException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The designated permission has already been given to the user.
pub const PermissionAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Your request has already been completed.
pub const RequestAlreadyProcessedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request has failed for an unspecified reason.
pub const RequestFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Your request is already in progress.
pub const RequestInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A resource such as a private CA, S3 bucket, certificate, audit report, or
/// policy cannot be found.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You can associate up to 50 tags with a private CA. Exception information is
/// contained in the exception message field.
pub const TooManyTagsException = struct {
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
