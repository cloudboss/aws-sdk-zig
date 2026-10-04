const aws = @import("aws");
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

/// Parse a service diagnostic. The caller must call deinit on the result.
pub fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) std.mem.Allocator.Error!ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClientTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_client_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidMaxResultsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_max_results_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceTypeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateTransitionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_transition_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MalformedArnException")) {
        return .{ .arena = arena, .kind = .{ .malformed_arn_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MalformedPolicyTemplateException")) {
        return .{ .arena = arena, .kind = .{ .malformed_policy_template_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingRequiredParameterException")) {
        return .{ .arena = arena, .kind = .{ .missing_required_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotPermittedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_permitted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PermissionAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .permission_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PermissionLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .permission_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PermissionVersionsLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .permission_versions_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceArnNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_arn_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceShareInvitationAlreadyAcceptedException")) {
        return .{ .arena = arena, .kind = .{ .resource_share_invitation_already_accepted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceShareInvitationAlreadyRejectedException")) {
        return .{ .arena = arena, .kind = .{ .resource_share_invitation_already_rejected_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceShareInvitationArnNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_share_invitation_arn_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceShareInvitationExpiredException")) {
        return .{ .arena = arena, .kind = .{ .resource_share_invitation_expired_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceShareLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_share_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerInternalException")) {
        return .{ .arena = arena, .kind = .{ .server_internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .tag_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagPolicyViolationException")) {
        return .{ .arena = arena, .kind = .{ .tag_policy_violation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnknownResourceException")) {
        return .{ .arena = arena, .kind = .{ .unknown_resource_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnmatchedPolicyPermissionException")) {
        return .{ .arena = arena, .kind = .{ .unmatched_policy_permission_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
