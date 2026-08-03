const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        decryption_failure: DecryptionFailure,
        encryption_failure: EncryptionFailure,
        internal_service_error: InternalServiceError,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_request_exception: InvalidRequestException,
        limit_exceeded_exception: LimitExceededException,
        malformed_policy_document_exception: MalformedPolicyDocumentException,
        precondition_not_met_exception: PreconditionNotMetException,
        public_policy_exception: PublicPolicyException,
        resource_exists_exception: ResourceExistsException,
        resource_not_found_exception: ResourceNotFoundException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .decryption_failure => "DecryptionFailure",
                .encryption_failure => "EncryptionFailure",
                .internal_service_error => "InternalServiceError",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_request_exception => "InvalidRequestException",
                .limit_exceeded_exception => "LimitExceededException",
                .malformed_policy_document_exception => "MalformedPolicyDocumentException",
                .precondition_not_met_exception => "PreconditionNotMetException",
                .public_policy_exception => "PublicPolicyException",
                .resource_exists_exception => "ResourceExistsException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .decryption_failure => |e| e.message,
                .encryption_failure => |e| e.message,
                .internal_service_error => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .malformed_policy_document_exception => |e| e.message,
                .precondition_not_met_exception => |e| e.message,
                .public_policy_exception => |e| e.message,
                .resource_exists_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .decryption_failure => 400,
                .encryption_failure => 400,
                .internal_service_error => 500,
                .invalid_next_token_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_request_exception => 400,
                .limit_exceeded_exception => 400,
                .malformed_policy_document_exception => 400,
                .precondition_not_met_exception => 400,
                .public_policy_exception => 400,
                .resource_exists_exception => 400,
                .resource_not_found_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .decryption_failure => |e| e.request_id,
                .encryption_failure => |e| e.request_id,
                .internal_service_error => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .malformed_policy_document_exception => |e| e.request_id,
                .precondition_not_met_exception => |e| e.request_id,
                .public_policy_exception => |e| e.request_id,
                .resource_exists_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
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

/// Secrets Manager can't decrypt the protected secret text using the provided
/// KMS key.
pub const DecryptionFailure = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Secrets Manager can't encrypt the protected secret text using the provided
/// KMS key. Check that the
/// KMS key is available, enabled, and not in an invalid state. For more
/// information, see [Key state: Effect on your KMS
/// key](https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html).
pub const EncryptionFailure = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// An error occurred on the server side.
pub const InternalServiceError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The `NextToken` value is invalid.
pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The parameter name or value is invalid.
pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A parameter value is not valid for the current state of the
/// resource.
///
/// Possible causes:
///
/// * The secret is scheduled for deletion.
///
/// * You tried to enable rotation on a secret that doesn't already have a
///   Lambda function
/// ARN configured and you didn't include such an ARN as a parameter in this
/// call.
///
/// * The secret is managed by another service, and you must use that service to
///   update it.
/// For more information, see [Secrets managed by other Amazon Web Services
/// services](https://docs.aws.amazon.com/secretsmanager/latest/userguide/service-linked-secrets.html).
pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request failed because it would exceed one of the Secrets Manager
/// quotas.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource policy has syntax errors.
pub const MalformedPolicyDocumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request failed because you did not complete all the prerequisite steps.
pub const PreconditionNotMetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The `BlockPublicPolicy` parameter is set to true, and the resource policy
/// did not prevent broad access to the secret.
pub const PublicPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// A resource with the ID you requested already exists.
pub const ResourceExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Secrets Manager can't find the resource that you asked for.
pub const ResourceNotFoundException = struct {
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
