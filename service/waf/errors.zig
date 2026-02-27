const std = @import("std");

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
};

pub const WAFDisallowedNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFEntityMigrationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFInternalErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFInvalidAccountException = struct {
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

pub const WAFInvalidRegexPatternException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFLimitsExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFNonEmptyEntityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFNonexistentContainerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFNonexistentItemException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFReferencedItemException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFServiceLinkedRoleErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WAFStaleDataException = struct {
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

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
