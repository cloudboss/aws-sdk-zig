const std = @import("std");

const MigrationErrorType = @import("migration_error_type.zig").MigrationErrorType;
const ParameterExceptionField = @import("parameter_exception_field.zig").ParameterExceptionField;
const ParameterExceptionReason = @import("parameter_exception_reason.zig").ParameterExceptionReason;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        waf_bad_request_exception: WAFBadRequestException,
        waf_disallowed_name_exception: WAFDisallowedNameException,
        waf_entity_migration_exception: WAFEntityMigrationException,
        waf_internal_error_exception: WAFInternalErrorException,
        waf_invalid_account_exception: WAFInvalidAccountException,
        waf_invalid_operation_exception: WAFInvalidOperationException,
        waf_invalid_parameter_exception: WAFInvalidParameterException,
        waf_invalid_permission_policy_exception: WAFInvalidPermissionPolicyException,
        waf_invalid_regex_pattern_exception: WAFInvalidRegexPatternException,
        waf_limits_exceeded_exception: WAFLimitsExceededException,
        waf_non_empty_entity_exception: WAFNonEmptyEntityException,
        waf_nonexistent_container_exception: WAFNonexistentContainerException,
        waf_nonexistent_item_exception: WAFNonexistentItemException,
        waf_referenced_item_exception: WAFReferencedItemException,
        waf_service_linked_role_error_exception: WAFServiceLinkedRoleErrorException,
        waf_stale_data_exception: WAFStaleDataException,
        waf_subscription_not_found_exception: WAFSubscriptionNotFoundException,
        waf_tag_operation_exception: WAFTagOperationException,
        waf_tag_operation_internal_error_exception: WAFTagOperationInternalErrorException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .waf_bad_request_exception => "WAFBadRequestException",
                .waf_disallowed_name_exception => "WAFDisallowedNameException",
                .waf_entity_migration_exception => "WAFEntityMigrationException",
                .waf_internal_error_exception => "WAFInternalErrorException",
                .waf_invalid_account_exception => "WAFInvalidAccountException",
                .waf_invalid_operation_exception => "WAFInvalidOperationException",
                .waf_invalid_parameter_exception => "WAFInvalidParameterException",
                .waf_invalid_permission_policy_exception => "WAFInvalidPermissionPolicyException",
                .waf_invalid_regex_pattern_exception => "WAFInvalidRegexPatternException",
                .waf_limits_exceeded_exception => "WAFLimitsExceededException",
                .waf_non_empty_entity_exception => "WAFNonEmptyEntityException",
                .waf_nonexistent_container_exception => "WAFNonexistentContainerException",
                .waf_nonexistent_item_exception => "WAFNonexistentItemException",
                .waf_referenced_item_exception => "WAFReferencedItemException",
                .waf_service_linked_role_error_exception => "WAFServiceLinkedRoleErrorException",
                .waf_stale_data_exception => "WAFStaleDataException",
                .waf_subscription_not_found_exception => "WAFSubscriptionNotFoundException",
                .waf_tag_operation_exception => "WAFTagOperationException",
                .waf_tag_operation_internal_error_exception => "WAFTagOperationInternalErrorException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .waf_bad_request_exception => |e| e.message,
                .waf_disallowed_name_exception => |e| e.message,
                .waf_entity_migration_exception => |e| e.message,
                .waf_internal_error_exception => |e| e.message,
                .waf_invalid_account_exception => |e| e.message,
                .waf_invalid_operation_exception => |e| e.message,
                .waf_invalid_parameter_exception => |e| e.message,
                .waf_invalid_permission_policy_exception => |e| e.message,
                .waf_invalid_regex_pattern_exception => |e| e.message,
                .waf_limits_exceeded_exception => |e| e.message,
                .waf_non_empty_entity_exception => |e| e.message,
                .waf_nonexistent_container_exception => |e| e.message,
                .waf_nonexistent_item_exception => |e| e.message,
                .waf_referenced_item_exception => |e| e.message,
                .waf_service_linked_role_error_exception => |e| e.message,
                .waf_stale_data_exception => |e| e.message,
                .waf_subscription_not_found_exception => |e| e.message,
                .waf_tag_operation_exception => |e| e.message,
                .waf_tag_operation_internal_error_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .waf_bad_request_exception => 400,
                .waf_disallowed_name_exception => 400,
                .waf_entity_migration_exception => 400,
                .waf_internal_error_exception => 500,
                .waf_invalid_account_exception => 400,
                .waf_invalid_operation_exception => 400,
                .waf_invalid_parameter_exception => 400,
                .waf_invalid_permission_policy_exception => 400,
                .waf_invalid_regex_pattern_exception => 400,
                .waf_limits_exceeded_exception => 400,
                .waf_non_empty_entity_exception => 400,
                .waf_nonexistent_container_exception => 400,
                .waf_nonexistent_item_exception => 400,
                .waf_referenced_item_exception => 400,
                .waf_service_linked_role_error_exception => 400,
                .waf_stale_data_exception => 400,
                .waf_subscription_not_found_exception => 400,
                .waf_tag_operation_exception => 400,
                .waf_tag_operation_internal_error_exception => 500,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .waf_bad_request_exception => |e| e.request_id,
                .waf_disallowed_name_exception => |e| e.request_id,
                .waf_entity_migration_exception => |e| e.request_id,
                .waf_internal_error_exception => |e| e.request_id,
                .waf_invalid_account_exception => |e| e.request_id,
                .waf_invalid_operation_exception => |e| e.request_id,
                .waf_invalid_parameter_exception => |e| e.request_id,
                .waf_invalid_permission_policy_exception => |e| e.request_id,
                .waf_invalid_regex_pattern_exception => |e| e.request_id,
                .waf_limits_exceeded_exception => |e| e.request_id,
                .waf_non_empty_entity_exception => |e| e.request_id,
                .waf_nonexistent_container_exception => |e| e.request_id,
                .waf_nonexistent_item_exception => |e| e.request_id,
                .waf_referenced_item_exception => |e| e.request_id,
                .waf_service_linked_role_error_exception => |e| e.request_id,
                .waf_stale_data_exception => |e| e.request_id,
                .waf_subscription_not_found_exception => |e| e.request_id,
                .waf_tag_operation_exception => |e| e.request_id,
                .waf_tag_operation_internal_error_exception => |e| e.request_id,
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

pub const WAFBadRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The name specified is invalid.
pub const WAFDisallowedNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation failed due to a problem with the migration. The failure cause
/// is provided in the exception, in the `MigrationErrorType`:
///
/// * `ENTITY_NOT_SUPPORTED` - The web ACL has an unsupported entity but the
///   `IgnoreUnsupportedType` is not set to true.
///
/// * `ENTITY_NOT_FOUND` - The web ACL doesn't exist.
///
/// * `S3_BUCKET_NO_PERMISSION` - You don't have permission to perform the
///   `PutObject` action to the specified Amazon S3 bucket.
///
/// * `S3_BUCKET_NOT_ACCESSIBLE` - The bucket policy doesn't allow AWS WAF to
///   perform the `PutObject` action in the bucket.
///
/// * `S3_BUCKET_NOT_FOUND` - The S3 bucket doesn't exist.
///
/// * `S3_BUCKET_INVALID_REGION` - The S3 bucket is not in the same Region as
///   the web ACL.
///
/// * `S3_INTERNAL_ERROR` - AWS WAF failed to create the template in the S3
///   bucket for another reason.
pub const WAFEntityMigrationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    migration_error_reason: ?[]const u8 = null,

    migration_error_type: ?MigrationErrorType = null,

    pub const json_field_names = .{
        .message = "message",
        .migration_error_reason = "MigrationErrorReason",
        .migration_error_type = "MigrationErrorType",
    };
};

/// The operation failed because of a system problem, even though the request
/// was valid. Retry your request.
pub const WAFInternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation failed because you tried to create, update, or delete an
/// object by using an invalid account identifier.
pub const WAFInvalidAccountException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

/// The operation failed because there was nothing to do. For example:
///
/// * You tried to remove a `Rule` from a `WebACL`, but the `Rule` isn't in the
///   specified `WebACL`.
///
/// * You tried to remove an IP address from an `IPSet`, but the IP address
///   isn't in the specified `IPSet`.
///
/// * You tried to remove a `ByteMatchTuple` from a `ByteMatchSet`, but the
///   `ByteMatchTuple`
/// isn't in the specified `WebACL`.
///
/// * You tried to add a `Rule` to a `WebACL`, but the `Rule` already exists in
///   the
/// specified `WebACL`.
///
/// * You tried to add a `ByteMatchTuple` to a `ByteMatchSet`, but the
///   `ByteMatchTuple`
/// already exists in the specified `WebACL`.
pub const WAFInvalidOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation failed because AWS WAF didn't recognize a parameter in the
/// request. For example:
///
/// * You specified an invalid parameter name.
///
/// * You specified an invalid value.
///
/// * You tried to update an object (`ByteMatchSet`, `IPSet`, `Rule`, or
///   `WebACL`)
/// using an action other than `INSERT` or `DELETE`.
///
/// * You tried to create a `WebACL` with a `DefaultAction`
/// `Type` other than
/// `ALLOW`, `BLOCK`, or `COUNT`.
///
/// * You tried to create a `RateBasedRule` with a `RateKey` value other than
///   `IP`.
///
/// * You tried to update a `WebACL` with a `WafAction`
/// `Type` other than
/// `ALLOW`, `BLOCK`, or `COUNT`.
///
/// * You tried to update a `ByteMatchSet` with a `FieldToMatch`
/// `Type` other than
/// HEADER, METHOD, QUERY_STRING, URI, or BODY.
///
/// * You tried to update a `ByteMatchSet` with a `Field` of `HEADER`
/// but no value for `Data`.
///
/// * Your request references an ARN that is malformed, or corresponds to a
///   resource with which a web ACL cannot be associated.
pub const WAFInvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    field: ?ParameterExceptionField = null,

    parameter: ?[]const u8 = null,

    reason: ?ParameterExceptionReason = null,

    pub const json_field_names = .{
        .field = "field",
        .parameter = "parameter",
        .reason = "reason",
    };
};

/// The operation failed because the specified policy is not in the proper
/// format.
///
/// The policy is subject to the following restrictions:
///
/// * You can attach only one policy with each `PutPermissionPolicy` request.
///
/// * The policy must include an `Effect`, `Action` and `Principal`.
///
/// * `Effect` must specify `Allow`.
///
/// * The `Action` in the policy must be `waf:UpdateWebACL`,
///   `waf-regional:UpdateWebACL`, `waf:GetRuleGroup` and
///   `waf-regional:GetRuleGroup` . Any extra or wildcard actions in the policy
///   will be rejected.
///
/// * The policy cannot include a `Resource` parameter.
///
/// * The ARN in the request must be a valid WAF RuleGroup ARN and the RuleGroup
///   must exist in the same region.
///
/// * The user making the request must be the owner of the RuleGroup.
///
/// * Your policy must be composed using IAM Policy version 2012-10-17.
pub const WAFInvalidPermissionPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The regular expression (regex) you specified in `RegexPatternString` is
/// invalid.
pub const WAFInvalidRegexPatternException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation exceeds a resource limit, for example, the maximum number of
/// `WebACL` objects that you can create
/// for an AWS account. For more information, see
/// [Limits](https://docs.aws.amazon.com/waf/latest/developerguide/limits.html)
/// in the *AWS WAF Developer Guide*.
pub const WAFLimitsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation failed because you tried to delete an object that isn't empty.
/// For example:
///
/// * You tried to delete a `WebACL` that still contains one or more `Rule`
///   objects.
///
/// * You tried to delete a `Rule` that still contains one or more
///   `ByteMatchSet` objects
/// or other predicates.
///
/// * You tried to delete a `ByteMatchSet` that contains one or more
///   `ByteMatchTuple` objects.
///
/// * You tried to delete an `IPSet` that references one or more IP addresses.
pub const WAFNonEmptyEntityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation failed because you tried to add an object to or delete an
/// object from another object that doesn't exist. For example:
///
/// * You tried to add a `Rule` to or delete a `Rule` from a `WebACL` that
///   doesn't exist.
///
/// * You tried to add a `ByteMatchSet` to or delete a `ByteMatchSet` from a
///   `Rule` that doesn't exist.
///
/// * You tried to add an IP address to or delete an IP address from an `IPSet`
///   that doesn't exist.
///
/// * You tried to add a `ByteMatchTuple` to or delete a `ByteMatchTuple` from a
///   `ByteMatchSet`
/// that doesn't exist.
pub const WAFNonexistentContainerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation failed because the referenced object doesn't exist.
pub const WAFNonexistentItemException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation failed because you tried to delete an object that is still in
/// use. For example:
///
/// * You tried to delete a `ByteMatchSet` that is still referenced by a `Rule`.
///
/// * You tried to delete a `Rule` that is still referenced by a `WebACL`.
pub const WAFReferencedItemException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// AWS WAF is not able to access the service linked role. This can be caused by
/// a previous `PutLoggingConfiguration` request, which can lock the service
/// linked role for about 20 seconds. Please try your request again. The service
/// linked role can also be locked by a previous `DeleteServiceLinkedRole`
/// request, which can lock the role for 15 minutes or more. If you recently
/// made a `DeleteServiceLinkedRole`, wait at least 15 minutes and try the
/// request again. If you receive this same exception again, you will have to
/// wait additional time until the role is unlocked.
pub const WAFServiceLinkedRoleErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation failed because you tried to create, update, or delete an
/// object by using a change token that has already been used.
pub const WAFStaleDataException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified subscription does not exist.
pub const WAFSubscriptionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

pub const WAFTagOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

pub const WAFTagOperationInternalErrorException = struct {
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
