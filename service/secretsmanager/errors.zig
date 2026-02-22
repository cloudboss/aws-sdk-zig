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

pub const DecryptionFailure = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EncryptionFailure = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServiceError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MalformedPolicyDocumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PreconditionNotMetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PublicPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
