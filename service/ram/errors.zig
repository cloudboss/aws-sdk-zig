const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        idempotent_parameter_mismatch_exception: IdempotentParameterMismatchException,
        invalid_client_token_exception: InvalidClientTokenException,
        invalid_max_results_exception: InvalidMaxResultsException,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_policy_exception: InvalidPolicyException,
        invalid_resource_type_exception: InvalidResourceTypeException,
        invalid_state_transition_exception: InvalidStateTransitionException,
        malformed_arn_exception: MalformedArnException,
        malformed_policy_template_exception: MalformedPolicyTemplateException,
        missing_required_parameter_exception: MissingRequiredParameterException,
        operation_not_permitted_exception: OperationNotPermittedException,
        permission_already_exists_exception: PermissionAlreadyExistsException,
        permission_limit_exceeded_exception: PermissionLimitExceededException,
        permission_versions_limit_exceeded_exception: PermissionVersionsLimitExceededException,
        resource_arn_not_found_exception: ResourceArnNotFoundException,
        resource_share_invitation_already_accepted_exception: ResourceShareInvitationAlreadyAcceptedException,
        resource_share_invitation_already_rejected_exception: ResourceShareInvitationAlreadyRejectedException,
        resource_share_invitation_arn_not_found_exception: ResourceShareInvitationArnNotFoundException,
        resource_share_invitation_expired_exception: ResourceShareInvitationExpiredException,
        resource_share_limit_exceeded_exception: ResourceShareLimitExceededException,
        server_internal_exception: ServerInternalException,
        service_unavailable_exception: ServiceUnavailableException,
        tag_limit_exceeded_exception: TagLimitExceededException,
        tag_policy_violation_exception: TagPolicyViolationException,
        throttling_exception: ThrottlingException,
        unknown_resource_exception: UnknownResourceException,
        unmatched_policy_permission_exception: UnmatchedPolicyPermissionException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .idempotent_parameter_mismatch_exception => "IdempotentParameterMismatchException",
                .invalid_client_token_exception => "InvalidClientTokenException",
                .invalid_max_results_exception => "InvalidMaxResultsException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_policy_exception => "InvalidPolicyException",
                .invalid_resource_type_exception => "InvalidResourceTypeException",
                .invalid_state_transition_exception => "InvalidStateTransitionException",
                .malformed_arn_exception => "MalformedArnException",
                .malformed_policy_template_exception => "MalformedPolicyTemplateException",
                .missing_required_parameter_exception => "MissingRequiredParameterException",
                .operation_not_permitted_exception => "OperationNotPermittedException",
                .permission_already_exists_exception => "PermissionAlreadyExistsException",
                .permission_limit_exceeded_exception => "PermissionLimitExceededException",
                .permission_versions_limit_exceeded_exception => "PermissionVersionsLimitExceededException",
                .resource_arn_not_found_exception => "ResourceArnNotFoundException",
                .resource_share_invitation_already_accepted_exception => "ResourceShareInvitationAlreadyAcceptedException",
                .resource_share_invitation_already_rejected_exception => "ResourceShareInvitationAlreadyRejectedException",
                .resource_share_invitation_arn_not_found_exception => "ResourceShareInvitationArnNotFoundException",
                .resource_share_invitation_expired_exception => "ResourceShareInvitationExpiredException",
                .resource_share_limit_exceeded_exception => "ResourceShareLimitExceededException",
                .server_internal_exception => "ServerInternalException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .tag_limit_exceeded_exception => "TagLimitExceededException",
                .tag_policy_violation_exception => "TagPolicyViolationException",
                .throttling_exception => "ThrottlingException",
                .unknown_resource_exception => "UnknownResourceException",
                .unmatched_policy_permission_exception => "UnmatchedPolicyPermissionException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .idempotent_parameter_mismatch_exception => |e| e.message,
                .invalid_client_token_exception => |e| e.message,
                .invalid_max_results_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_policy_exception => |e| e.message,
                .invalid_resource_type_exception => |e| e.message,
                .invalid_state_transition_exception => |e| e.message,
                .malformed_arn_exception => |e| e.message,
                .malformed_policy_template_exception => |e| e.message,
                .missing_required_parameter_exception => |e| e.message,
                .operation_not_permitted_exception => |e| e.message,
                .permission_already_exists_exception => |e| e.message,
                .permission_limit_exceeded_exception => |e| e.message,
                .permission_versions_limit_exceeded_exception => |e| e.message,
                .resource_arn_not_found_exception => |e| e.message,
                .resource_share_invitation_already_accepted_exception => |e| e.message,
                .resource_share_invitation_already_rejected_exception => |e| e.message,
                .resource_share_invitation_arn_not_found_exception => |e| e.message,
                .resource_share_invitation_expired_exception => |e| e.message,
                .resource_share_limit_exceeded_exception => |e| e.message,
                .server_internal_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .tag_limit_exceeded_exception => |e| e.message,
                .tag_policy_violation_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unknown_resource_exception => |e| e.message,
                .unmatched_policy_permission_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .idempotent_parameter_mismatch_exception => 400,
                .invalid_client_token_exception => 400,
                .invalid_max_results_exception => 400,
                .invalid_next_token_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_policy_exception => 400,
                .invalid_resource_type_exception => 400,
                .invalid_state_transition_exception => 400,
                .malformed_arn_exception => 400,
                .malformed_policy_template_exception => 400,
                .missing_required_parameter_exception => 400,
                .operation_not_permitted_exception => 400,
                .permission_already_exists_exception => 409,
                .permission_limit_exceeded_exception => 400,
                .permission_versions_limit_exceeded_exception => 400,
                .resource_arn_not_found_exception => 400,
                .resource_share_invitation_already_accepted_exception => 400,
                .resource_share_invitation_already_rejected_exception => 400,
                .resource_share_invitation_arn_not_found_exception => 400,
                .resource_share_invitation_expired_exception => 400,
                .resource_share_limit_exceeded_exception => 400,
                .server_internal_exception => 500,
                .service_unavailable_exception => 503,
                .tag_limit_exceeded_exception => 400,
                .tag_policy_violation_exception => 400,
                .throttling_exception => 429,
                .unknown_resource_exception => 400,
                .unmatched_policy_permission_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .idempotent_parameter_mismatch_exception => |e| e.request_id,
                .invalid_client_token_exception => |e| e.request_id,
                .invalid_max_results_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_policy_exception => |e| e.request_id,
                .invalid_resource_type_exception => |e| e.request_id,
                .invalid_state_transition_exception => |e| e.request_id,
                .malformed_arn_exception => |e| e.request_id,
                .malformed_policy_template_exception => |e| e.request_id,
                .missing_required_parameter_exception => |e| e.request_id,
                .operation_not_permitted_exception => |e| e.request_id,
                .permission_already_exists_exception => |e| e.request_id,
                .permission_limit_exceeded_exception => |e| e.request_id,
                .permission_versions_limit_exceeded_exception => |e| e.request_id,
                .resource_arn_not_found_exception => |e| e.request_id,
                .resource_share_invitation_already_accepted_exception => |e| e.request_id,
                .resource_share_invitation_already_rejected_exception => |e| e.request_id,
                .resource_share_invitation_arn_not_found_exception => |e| e.request_id,
                .resource_share_invitation_expired_exception => |e| e.request_id,
                .resource_share_limit_exceeded_exception => |e| e.request_id,
                .server_internal_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .tag_limit_exceeded_exception => |e| e.request_id,
                .tag_policy_violation_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .unknown_resource_exception => |e| e.request_id,
                .unmatched_policy_permission_exception => |e| e.request_id,
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

pub const IdempotentParameterMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidClientTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidMaxResultsException = struct {
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

pub const InvalidPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidResourceTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidStateTransitionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MalformedArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MalformedPolicyTemplateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MissingRequiredParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationNotPermittedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PermissionAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PermissionLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PermissionVersionsLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceArnNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceShareInvitationAlreadyAcceptedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceShareInvitationAlreadyRejectedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceShareInvitationArnNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceShareInvitationExpiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceShareLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServerInternalException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagPolicyViolationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownResourceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnmatchedPolicyPermissionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
