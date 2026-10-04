const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        authorization_error_exception: AuthorizationErrorException,
        batch_entry_ids_not_distinct_exception: BatchEntryIdsNotDistinctException,
        batch_request_too_long_exception: BatchRequestTooLongException,
        concurrent_access_exception: ConcurrentAccessException,
        empty_batch_request_exception: EmptyBatchRequestException,
        endpoint_disabled_exception: EndpointDisabledException,
        filter_policy_limit_exceeded_exception: FilterPolicyLimitExceededException,
        internal_error_exception: InternalErrorException,
        invalid_batch_entry_id_exception: InvalidBatchEntryIdException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_parameter_value_exception: InvalidParameterValueException,
        invalid_security_exception: InvalidSecurityException,
        invalid_state_exception: InvalidStateException,
        kms_access_denied_exception: KMSAccessDeniedException,
        kms_disabled_exception: KMSDisabledException,
        kms_invalid_state_exception: KMSInvalidStateException,
        kms_not_found_exception: KMSNotFoundException,
        kms_opt_in_required: KMSOptInRequired,
        kms_throttling_exception: KMSThrottlingException,
        not_found_exception: NotFoundException,
        opted_out_exception: OptedOutException,
        platform_application_disabled_exception: PlatformApplicationDisabledException,
        replay_limit_exceeded_exception: ReplayLimitExceededException,
        resource_not_found_exception: ResourceNotFoundException,
        stale_tag_exception: StaleTagException,
        subscription_limit_exceeded_exception: SubscriptionLimitExceededException,
        tag_limit_exceeded_exception: TagLimitExceededException,
        tag_policy_exception: TagPolicyException,
        throttled_exception: ThrottledException,
        too_many_entries_in_batch_request_exception: TooManyEntriesInBatchRequestException,
        topic_limit_exceeded_exception: TopicLimitExceededException,
        user_error_exception: UserErrorException,
        validation_exception: ValidationException,
        verification_exception: VerificationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .authorization_error_exception => "AuthorizationErrorException",
                .batch_entry_ids_not_distinct_exception => "BatchEntryIdsNotDistinctException",
                .batch_request_too_long_exception => "BatchRequestTooLongException",
                .concurrent_access_exception => "ConcurrentAccessException",
                .empty_batch_request_exception => "EmptyBatchRequestException",
                .endpoint_disabled_exception => "EndpointDisabledException",
                .filter_policy_limit_exceeded_exception => "FilterPolicyLimitExceededException",
                .internal_error_exception => "InternalErrorException",
                .invalid_batch_entry_id_exception => "InvalidBatchEntryIdException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_parameter_value_exception => "InvalidParameterValueException",
                .invalid_security_exception => "InvalidSecurityException",
                .invalid_state_exception => "InvalidStateException",
                .kms_access_denied_exception => "KMSAccessDeniedException",
                .kms_disabled_exception => "KMSDisabledException",
                .kms_invalid_state_exception => "KMSInvalidStateException",
                .kms_not_found_exception => "KMSNotFoundException",
                .kms_opt_in_required => "KMSOptInRequired",
                .kms_throttling_exception => "KMSThrottlingException",
                .not_found_exception => "NotFoundException",
                .opted_out_exception => "OptedOutException",
                .platform_application_disabled_exception => "PlatformApplicationDisabledException",
                .replay_limit_exceeded_exception => "ReplayLimitExceededException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .stale_tag_exception => "StaleTagException",
                .subscription_limit_exceeded_exception => "SubscriptionLimitExceededException",
                .tag_limit_exceeded_exception => "TagLimitExceededException",
                .tag_policy_exception => "TagPolicyException",
                .throttled_exception => "ThrottledException",
                .too_many_entries_in_batch_request_exception => "TooManyEntriesInBatchRequestException",
                .topic_limit_exceeded_exception => "TopicLimitExceededException",
                .user_error_exception => "UserErrorException",
                .validation_exception => "ValidationException",
                .verification_exception => "VerificationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .authorization_error_exception => |e| e.message,
                .batch_entry_ids_not_distinct_exception => |e| e.message,
                .batch_request_too_long_exception => |e| e.message,
                .concurrent_access_exception => |e| e.message,
                .empty_batch_request_exception => |e| e.message,
                .endpoint_disabled_exception => |e| e.message,
                .filter_policy_limit_exceeded_exception => |e| e.message,
                .internal_error_exception => |e| e.message,
                .invalid_batch_entry_id_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_parameter_value_exception => |e| e.message,
                .invalid_security_exception => |e| e.message,
                .invalid_state_exception => |e| e.message,
                .kms_access_denied_exception => |e| e.message,
                .kms_disabled_exception => |e| e.message,
                .kms_invalid_state_exception => |e| e.message,
                .kms_not_found_exception => |e| e.message,
                .kms_opt_in_required => |e| e.message,
                .kms_throttling_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .opted_out_exception => |e| e.message,
                .platform_application_disabled_exception => |e| e.message,
                .replay_limit_exceeded_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .stale_tag_exception => |e| e.message,
                .subscription_limit_exceeded_exception => |e| e.message,
                .tag_limit_exceeded_exception => |e| e.message,
                .tag_policy_exception => |e| e.message,
                .throttled_exception => |e| e.message,
                .too_many_entries_in_batch_request_exception => |e| e.message,
                .topic_limit_exceeded_exception => |e| e.message,
                .user_error_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .verification_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .authorization_error_exception => 403,
                .batch_entry_ids_not_distinct_exception => 400,
                .batch_request_too_long_exception => 400,
                .concurrent_access_exception => 400,
                .empty_batch_request_exception => 400,
                .endpoint_disabled_exception => 400,
                .filter_policy_limit_exceeded_exception => 403,
                .internal_error_exception => 500,
                .invalid_batch_entry_id_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_parameter_value_exception => 400,
                .invalid_security_exception => 403,
                .invalid_state_exception => 400,
                .kms_access_denied_exception => 400,
                .kms_disabled_exception => 400,
                .kms_invalid_state_exception => 400,
                .kms_not_found_exception => 400,
                .kms_opt_in_required => 403,
                .kms_throttling_exception => 400,
                .not_found_exception => 404,
                .opted_out_exception => 400,
                .platform_application_disabled_exception => 400,
                .replay_limit_exceeded_exception => 403,
                .resource_not_found_exception => 404,
                .stale_tag_exception => 400,
                .subscription_limit_exceeded_exception => 403,
                .tag_limit_exceeded_exception => 400,
                .tag_policy_exception => 400,
                .throttled_exception => 429,
                .too_many_entries_in_batch_request_exception => 400,
                .topic_limit_exceeded_exception => 403,
                .user_error_exception => 400,
                .validation_exception => 400,
                .verification_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .authorization_error_exception => |e| e.request_id,
                .batch_entry_ids_not_distinct_exception => |e| e.request_id,
                .batch_request_too_long_exception => |e| e.request_id,
                .concurrent_access_exception => |e| e.request_id,
                .empty_batch_request_exception => |e| e.request_id,
                .endpoint_disabled_exception => |e| e.request_id,
                .filter_policy_limit_exceeded_exception => |e| e.request_id,
                .internal_error_exception => |e| e.request_id,
                .invalid_batch_entry_id_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_parameter_value_exception => |e| e.request_id,
                .invalid_security_exception => |e| e.request_id,
                .invalid_state_exception => |e| e.request_id,
                .kms_access_denied_exception => |e| e.request_id,
                .kms_disabled_exception => |e| e.request_id,
                .kms_invalid_state_exception => |e| e.request_id,
                .kms_not_found_exception => |e| e.request_id,
                .kms_opt_in_required => |e| e.request_id,
                .kms_throttling_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .opted_out_exception => |e| e.request_id,
                .platform_application_disabled_exception => |e| e.request_id,
                .replay_limit_exceeded_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .stale_tag_exception => |e| e.request_id,
                .subscription_limit_exceeded_exception => |e| e.request_id,
                .tag_limit_exceeded_exception => |e| e.request_id,
                .tag_policy_exception => |e| e.request_id,
                .throttled_exception => |e| e.request_id,
                .too_many_entries_in_batch_request_exception => |e| e.request_id,
                .topic_limit_exceeded_exception => |e| e.request_id,
                .user_error_exception => |e| e.request_id,
                .validation_exception => |e| e.request_id,
                .verification_exception => |e| e.request_id,
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

pub const AuthorizationErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BatchEntryIdsNotDistinctException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BatchRequestTooLongException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentAccessException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EmptyBatchRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EndpointDisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FilterPolicyLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidBatchEntryIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSecurityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSAccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSDisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSInvalidStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSOptInRequired = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KMSThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OptedOutException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PlatformApplicationDisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReplayLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StaleTagException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubscriptionLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyEntriesInBatchRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TopicLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UserErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const VerificationException = struct {
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
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AuthorizationErrorException")) {
        return .{ .arena = arena, .kind = .{ .authorization_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BatchEntryIdsNotDistinctException")) {
        return .{ .arena = arena, .kind = .{ .batch_entry_ids_not_distinct_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BatchRequestTooLongException")) {
        return .{ .arena = arena, .kind = .{ .batch_request_too_long_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentAccessException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_access_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EmptyBatchRequestException")) {
        return .{ .arena = arena, .kind = .{ .empty_batch_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointDisabledException")) {
        return .{ .arena = arena, .kind = .{ .endpoint_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FilterPolicyLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .filter_policy_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidBatchEntryIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_batch_entry_id_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurityException")) {
        return .{ .arena = arena, .kind = .{ .invalid_security_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .kms_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledException")) {
        return .{ .arena = arena, .kind = .{ .kms_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .kms_invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .kms_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSOptInRequired")) {
        return .{ .arena = arena, .kind = .{ .kms_opt_in_required = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .kms_throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OptedOutException")) {
        return .{ .arena = arena, .kind = .{ .opted_out_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PlatformApplicationDisabledException")) {
        return .{ .arena = arena, .kind = .{ .platform_application_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplayLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .replay_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StaleTagException")) {
        return .{ .arena = arena, .kind = .{ .stale_tag_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .subscription_limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "TagPolicyException")) {
        return .{ .arena = arena, .kind = .{ .tag_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottledException")) {
        return .{ .arena = arena, .kind = .{ .throttled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyEntriesInBatchRequestException")) {
        return .{ .arena = arena, .kind = .{ .too_many_entries_in_batch_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TopicLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .topic_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserErrorException")) {
        return .{ .arena = arena, .kind = .{ .user_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "VerificationException")) {
        return .{ .arena = arena, .kind = .{ .verification_exception = .{
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
