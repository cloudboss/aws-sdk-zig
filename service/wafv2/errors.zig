const std = @import("std");

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

pub const WAFAssociatedItemException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFConfigurationWarningException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFDuplicateItemException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFExpiredManagedRuleGroupVersionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFFeatureNotIncludedInPricingPlanException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFInternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFInvalidOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFInvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFInvalidPermissionPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFInvalidResourceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFLimitsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFLogDestinationPermissionIssueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFNonexistentItemException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFOptimisticLockException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFServiceLinkedRoleErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFSubscriptionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFTagOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFTagOperationInternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFUnavailableEntityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFUnsupportedAggregateKeyTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
