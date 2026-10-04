const aws = @import("aws");
const std = @import("std");

const DisallowedFeature = @import("disallowed_feature.zig").DisallowedFeature;
const ParameterExceptionField = @import("parameter_exception_field.zig").ParameterExceptionField;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        waf_associated_item_exception: WAFAssociatedItemException,
        waf_configuration_warning_exception: WAFConfigurationWarningException,
        waf_duplicate_item_exception: WAFDuplicateItemException,
        waf_expired_managed_rule_group_version_exception: WAFExpiredManagedRuleGroupVersionException,
        waf_feature_not_included_in_pricing_plan_exception: WAFFeatureNotIncludedInPricingPlanException,
        waf_internal_error_exception: WAFInternalErrorException,
        waf_invalid_operation_exception: WAFInvalidOperationException,
        waf_invalid_parameter_exception: WAFInvalidParameterException,
        waf_invalid_permission_policy_exception: WAFInvalidPermissionPolicyException,
        waf_invalid_resource_exception: WAFInvalidResourceException,
        waf_limits_exceeded_exception: WAFLimitsExceededException,
        waf_log_destination_permission_issue_exception: WAFLogDestinationPermissionIssueException,
        waf_nonexistent_item_exception: WAFNonexistentItemException,
        waf_optimistic_lock_exception: WAFOptimisticLockException,
        waf_service_linked_role_error_exception: WAFServiceLinkedRoleErrorException,
        waf_subscription_not_found_exception: WAFSubscriptionNotFoundException,
        waf_tag_operation_exception: WAFTagOperationException,
        waf_tag_operation_internal_error_exception: WAFTagOperationInternalErrorException,
        waf_unavailable_entity_exception: WAFUnavailableEntityException,
        waf_unsupported_aggregate_key_type_exception: WAFUnsupportedAggregateKeyTypeException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .waf_associated_item_exception => "WAFAssociatedItemException",
                .waf_configuration_warning_exception => "WAFConfigurationWarningException",
                .waf_duplicate_item_exception => "WAFDuplicateItemException",
                .waf_expired_managed_rule_group_version_exception => "WAFExpiredManagedRuleGroupVersionException",
                .waf_feature_not_included_in_pricing_plan_exception => "WAFFeatureNotIncludedInPricingPlanException",
                .waf_internal_error_exception => "WAFInternalErrorException",
                .waf_invalid_operation_exception => "WAFInvalidOperationException",
                .waf_invalid_parameter_exception => "WAFInvalidParameterException",
                .waf_invalid_permission_policy_exception => "WAFInvalidPermissionPolicyException",
                .waf_invalid_resource_exception => "WAFInvalidResourceException",
                .waf_limits_exceeded_exception => "WAFLimitsExceededException",
                .waf_log_destination_permission_issue_exception => "WAFLogDestinationPermissionIssueException",
                .waf_nonexistent_item_exception => "WAFNonexistentItemException",
                .waf_optimistic_lock_exception => "WAFOptimisticLockException",
                .waf_service_linked_role_error_exception => "WAFServiceLinkedRoleErrorException",
                .waf_subscription_not_found_exception => "WAFSubscriptionNotFoundException",
                .waf_tag_operation_exception => "WAFTagOperationException",
                .waf_tag_operation_internal_error_exception => "WAFTagOperationInternalErrorException",
                .waf_unavailable_entity_exception => "WAFUnavailableEntityException",
                .waf_unsupported_aggregate_key_type_exception => "WAFUnsupportedAggregateKeyTypeException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .waf_associated_item_exception => |e| e.message,
                .waf_configuration_warning_exception => |e| e.message,
                .waf_duplicate_item_exception => |e| e.message,
                .waf_expired_managed_rule_group_version_exception => |e| e.message,
                .waf_feature_not_included_in_pricing_plan_exception => |e| e.message,
                .waf_internal_error_exception => |e| e.message,
                .waf_invalid_operation_exception => |e| e.message,
                .waf_invalid_parameter_exception => |e| e.message,
                .waf_invalid_permission_policy_exception => |e| e.message,
                .waf_invalid_resource_exception => |e| e.message,
                .waf_limits_exceeded_exception => |e| e.message,
                .waf_log_destination_permission_issue_exception => |e| e.message,
                .waf_nonexistent_item_exception => |e| e.message,
                .waf_optimistic_lock_exception => |e| e.message,
                .waf_service_linked_role_error_exception => |e| e.message,
                .waf_subscription_not_found_exception => |e| e.message,
                .waf_tag_operation_exception => |e| e.message,
                .waf_tag_operation_internal_error_exception => |e| e.message,
                .waf_unavailable_entity_exception => |e| e.message,
                .waf_unsupported_aggregate_key_type_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .waf_associated_item_exception => 400,
                .waf_configuration_warning_exception => 400,
                .waf_duplicate_item_exception => 400,
                .waf_expired_managed_rule_group_version_exception => 400,
                .waf_feature_not_included_in_pricing_plan_exception => 400,
                .waf_internal_error_exception => 500,
                .waf_invalid_operation_exception => 400,
                .waf_invalid_parameter_exception => 400,
                .waf_invalid_permission_policy_exception => 400,
                .waf_invalid_resource_exception => 400,
                .waf_limits_exceeded_exception => 400,
                .waf_log_destination_permission_issue_exception => 400,
                .waf_nonexistent_item_exception => 400,
                .waf_optimistic_lock_exception => 400,
                .waf_service_linked_role_error_exception => 400,
                .waf_subscription_not_found_exception => 400,
                .waf_tag_operation_exception => 400,
                .waf_tag_operation_internal_error_exception => 500,
                .waf_unavailable_entity_exception => 400,
                .waf_unsupported_aggregate_key_type_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .waf_associated_item_exception => |e| e.request_id,
                .waf_configuration_warning_exception => |e| e.request_id,
                .waf_duplicate_item_exception => |e| e.request_id,
                .waf_expired_managed_rule_group_version_exception => |e| e.request_id,
                .waf_feature_not_included_in_pricing_plan_exception => |e| e.request_id,
                .waf_internal_error_exception => |e| e.request_id,
                .waf_invalid_operation_exception => |e| e.request_id,
                .waf_invalid_parameter_exception => |e| e.request_id,
                .waf_invalid_permission_policy_exception => |e| e.request_id,
                .waf_invalid_resource_exception => |e| e.request_id,
                .waf_limits_exceeded_exception => |e| e.request_id,
                .waf_log_destination_permission_issue_exception => |e| e.request_id,
                .waf_nonexistent_item_exception => |e| e.request_id,
                .waf_optimistic_lock_exception => |e| e.request_id,
                .waf_service_linked_role_error_exception => |e| e.request_id,
                .waf_subscription_not_found_exception => |e| e.request_id,
                .waf_tag_operation_exception => |e| e.request_id,
                .waf_tag_operation_internal_error_exception => |e| e.request_id,
                .waf_unavailable_entity_exception => |e| e.request_id,
                .waf_unsupported_aggregate_key_type_exception => |e| e.request_id,
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

/// WAF couldn’t perform the operation because your resource is being used by
/// another
/// resource or it’s associated with another resource.
pub const WAFAssociatedItemException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The operation failed because you are inspecting the web request body,
/// headers, or
/// cookies without specifying how to handle oversize components. Rules that
/// inspect the body
/// must either provide an `OversizeHandling` configuration or they must be
/// preceded
/// by a `SizeConstraintStatement` that blocks the body content from being too
/// large. Rules that inspect the headers or cookies must provide an
/// `OversizeHandling` configuration.
///
/// Provide the handling configuration and retry your operation.
///
/// Alternately, you can suppress this warning by adding the following tag to
/// the resource
/// that you provide to this operation: `Tag`
/// (key:`WAF:OversizeFieldsHandlingConstraintOptOut`,
/// value:`true`).
pub const WAFConfigurationWarningException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// WAF couldn’t perform the operation because the resource that you tried to
/// save is
/// a duplicate of an existing one.
pub const WAFDuplicateItemException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The operation failed because the specified version for the managed rule
/// group has
/// expired. You can retrieve the available versions for the managed rule group
/// by calling
/// ListAvailableManagedRuleGroupVersions.
pub const WAFExpiredManagedRuleGroupVersionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The operation failed because the specified WAF feature isn't supported by
/// the CloudFront pricing plan associated with the web ACL.
pub const WAFFeatureNotIncludedInPricingPlanException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The names of the disallowed WAF features.
    disallowed_features: ?[]const DisallowedFeature = null,

    pub const json_field_names = .{
        .disallowed_features = "DisallowedFeatures",
        .message = "Message",
    };
};

/// Your request is valid, but WAF couldn’t perform the operation because of a
/// system
/// problem. Retry your request.
pub const WAFInternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The operation isn't valid.
pub const WAFInvalidOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The operation failed because WAF didn't recognize a parameter in the
/// request. For
/// example:
///
/// * You specified a parameter name or value that isn't valid.
///
/// * Your nested statement isn't valid. You might have tried to nest a
///   statement that
/// can’t be nested.
///
/// * You tried to update a `WebACL` with a `DefaultAction` that
/// isn't among the types available at DefaultAction.
///
/// * Your request references an ARN that is malformed, or corresponds to a
///   resource
/// with which a web ACL can't be associated.
pub const WAFInvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The settings where the invalid parameter was found.
    field: ?ParameterExceptionField = null,

    /// The invalid parameter that resulted in the exception.
    parameter: ?[]const u8 = null,

    /// Additional information about the exception.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .field = "Field",
        .message = "message",
        .parameter = "Parameter",
        .reason = "Reason",
    };
};

/// The operation failed because the specified policy isn't in the proper
/// format.
///
/// The policy specifications must conform to the following:
///
/// * The policy must be composed using IAM Policy version 2012-10-17.
///
/// * The policy must include specifications for `Effect`, `Action`, and
///   `Principal`.
///
/// * `Effect` must specify `Allow`.
///
/// * `Action` must specify `wafv2:CreateWebACL`, `wafv2:UpdateWebACL`, and
/// `wafv2:PutFirewallManagerRuleGroups` and may optionally specify
/// `wafv2:GetRuleGroup`.
/// WAF rejects any extra actions or wildcard actions in the policy.
///
/// * The policy must not include a `Resource` parameter.
///
/// For more information, see [IAM
/// Policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html).
pub const WAFInvalidPermissionPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// WAF couldn’t perform the operation because the resource that you requested
/// isn’t
/// valid. Check the resource, and try again.
pub const WAFInvalidResourceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// WAF couldn’t perform the operation because you exceeded your resource limit.
/// For
/// example, the maximum number of `WebACL` objects that you can create for an
/// Amazon Web Services
/// account. For more information, see [WAF
/// quotas](https://docs.aws.amazon.com/waf/latest/developerguide/limits.html)
/// in the
/// *WAF Developer Guide*.
pub const WAFLimitsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Source type for the exception.
    source_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .source_type = "SourceType",
    };
};

/// The operation failed because you don't have the permissions that your
/// logging
/// configuration requires. For information, see [Logging web ACL traffic
/// information](https://docs.aws.amazon.com/waf/latest/developerguide/logging.html)
/// in the *WAF Developer Guide*.
pub const WAFLogDestinationPermissionIssueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// WAF couldn’t perform the operation because your resource doesn't exist.
/// If you've just created a resource that you're using in this operation, you
/// might
/// just need to wait a few minutes. It can take from a few seconds to a number
/// of minutes
/// for changes to propagate.
pub const WAFNonexistentItemException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// WAF couldn’t save your changes because you tried to update or delete a
/// resource
/// that has changed since you last retrieved it. Get the resource again, make
/// any changes you
/// need to make to the new copy, and retry your operation.
pub const WAFOptimisticLockException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// WAF is not able to access the service linked role. This can be caused by a
/// previous `PutLoggingConfiguration` request, which can lock the service
/// linked
/// role for about 20 seconds. Please try your request again. The service linked
/// role can also
/// be locked by a previous `DeleteServiceLinkedRole` request, which can lock
/// the
/// role for 15 minutes or more. If you recently made a call to
/// `DeleteServiceLinkedRole`, wait at least 15 minutes and try the request
/// again. If you receive this same exception again, you will have to wait
/// additional time
/// until the role is unlocked.
pub const WAFServiceLinkedRoleErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You tried to use a managed rule group that's available by subscription, but
/// you aren't
/// subscribed to it yet.
pub const WAFSubscriptionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// An error occurred during the tagging operation. Retry your request.
pub const WAFTagOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// WAF couldn’t perform your tagging operation because of an internal error.
/// Retry
/// your request.
pub const WAFTagOperationInternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// WAF couldn’t retrieve a resource that you specified for this operation.
/// If you've just created a resource that you're using in this operation, you
/// might
/// just need to wait a few minutes. It can take from a few seconds to a number
/// of minutes
/// for changes to propagate. Verify the resource specifications in your request
/// parameters and then retry the operation.
pub const WAFUnavailableEntityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The rule that you've named doesn't aggregate solely on the IP address or
/// solely on the forwarded IP address. This call
/// is only available for rate-based rules with an `AggregateKeyType` setting of
/// `IP` or `FORWARDED_IP`.
pub const WAFUnsupportedAggregateKeyTypeException = struct {
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

    if (std.mem.eql(u8, error_code, "WAFAssociatedItemException")) {
        const parsed_error: ?WAFAssociatedItemException = aws.json.parseJsonObject(WAFAssociatedItemException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_associated_item_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFConfigurationWarningException")) {
        const parsed_error: ?WAFConfigurationWarningException = aws.json.parseJsonObject(WAFConfigurationWarningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_configuration_warning_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFDuplicateItemException")) {
        const parsed_error: ?WAFDuplicateItemException = aws.json.parseJsonObject(WAFDuplicateItemException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_duplicate_item_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFExpiredManagedRuleGroupVersionException")) {
        const parsed_error: ?WAFExpiredManagedRuleGroupVersionException = aws.json.parseJsonObject(WAFExpiredManagedRuleGroupVersionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_expired_managed_rule_group_version_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFFeatureNotIncludedInPricingPlanException")) {
        const parsed_error: ?WAFFeatureNotIncludedInPricingPlanException = aws.json.parseJsonObject(WAFFeatureNotIncludedInPricingPlanException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_feature_not_included_in_pricing_plan_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFInternalErrorException")) {
        const parsed_error: ?WAFInternalErrorException = aws.json.parseJsonObject(WAFInternalErrorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_internal_error_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFInvalidOperationException")) {
        const parsed_error: ?WAFInvalidOperationException = aws.json.parseJsonObject(WAFInvalidOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_invalid_operation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFInvalidParameterException")) {
        const parsed_error: ?WAFInvalidParameterException = aws.json.parseJsonObject(WAFInvalidParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_invalid_parameter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFInvalidPermissionPolicyException")) {
        const parsed_error: ?WAFInvalidPermissionPolicyException = aws.json.parseJsonObject(WAFInvalidPermissionPolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_invalid_permission_policy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFInvalidResourceException")) {
        const parsed_error: ?WAFInvalidResourceException = aws.json.parseJsonObject(WAFInvalidResourceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_invalid_resource_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFLimitsExceededException")) {
        const parsed_error: ?WAFLimitsExceededException = aws.json.parseJsonObject(WAFLimitsExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_limits_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFLogDestinationPermissionIssueException")) {
        const parsed_error: ?WAFLogDestinationPermissionIssueException = aws.json.parseJsonObject(WAFLogDestinationPermissionIssueException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_log_destination_permission_issue_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFNonexistentItemException")) {
        const parsed_error: ?WAFNonexistentItemException = aws.json.parseJsonObject(WAFNonexistentItemException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_nonexistent_item_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFOptimisticLockException")) {
        const parsed_error: ?WAFOptimisticLockException = aws.json.parseJsonObject(WAFOptimisticLockException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_optimistic_lock_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFServiceLinkedRoleErrorException")) {
        const parsed_error: ?WAFServiceLinkedRoleErrorException = aws.json.parseJsonObject(WAFServiceLinkedRoleErrorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_service_linked_role_error_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFSubscriptionNotFoundException")) {
        const parsed_error: ?WAFSubscriptionNotFoundException = aws.json.parseJsonObject(WAFSubscriptionNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_subscription_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFTagOperationException")) {
        const parsed_error: ?WAFTagOperationException = aws.json.parseJsonObject(WAFTagOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_tag_operation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFTagOperationInternalErrorException")) {
        const parsed_error: ?WAFTagOperationInternalErrorException = aws.json.parseJsonObject(WAFTagOperationInternalErrorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_tag_operation_internal_error_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFUnavailableEntityException")) {
        const parsed_error: ?WAFUnavailableEntityException = aws.json.parseJsonObject(WAFUnavailableEntityException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_unavailable_entity_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFUnsupportedAggregateKeyTypeException")) {
        const parsed_error: ?WAFUnsupportedAggregateKeyTypeException = aws.json.parseJsonObject(WAFUnsupportedAggregateKeyTypeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_unsupported_aggregate_key_type_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
