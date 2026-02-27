const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        already_exists_exception: AlreadyExistsException,
        cfn_registry_exception: CFNRegistryException,
        change_set_not_found_exception: ChangeSetNotFoundException,
        concurrent_resources_limit_exceeded_exception: ConcurrentResourcesLimitExceededException,
        created_but_modified_exception: CreatedButModifiedException,
        generated_template_not_found_exception: GeneratedTemplateNotFoundException,
        hook_result_not_found_exception: HookResultNotFoundException,
        insufficient_capabilities_exception: InsufficientCapabilitiesException,
        invalid_change_set_status_exception: InvalidChangeSetStatusException,
        invalid_operation_exception: InvalidOperationException,
        invalid_state_transition_exception: InvalidStateTransitionException,
        limit_exceeded_exception: LimitExceededException,
        name_already_exists_exception: NameAlreadyExistsException,
        operation_id_already_exists_exception: OperationIdAlreadyExistsException,
        operation_in_progress_exception: OperationInProgressException,
        operation_not_found_exception: OperationNotFoundException,
        operation_status_check_failed_exception: OperationStatusCheckFailedException,
        resource_scan_in_progress_exception: ResourceScanInProgressException,
        resource_scan_limit_exceeded_exception: ResourceScanLimitExceededException,
        resource_scan_not_found_exception: ResourceScanNotFoundException,
        stack_instance_not_found_exception: StackInstanceNotFoundException,
        stack_not_found_exception: StackNotFoundException,
        stack_refactor_not_found_exception: StackRefactorNotFoundException,
        stack_set_not_empty_exception: StackSetNotEmptyException,
        stack_set_not_found_exception: StackSetNotFoundException,
        stale_request_exception: StaleRequestException,
        token_already_exists_exception: TokenAlreadyExistsException,
        type_configuration_not_found_exception: TypeConfigurationNotFoundException,
        type_not_found_exception: TypeNotFoundException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .already_exists_exception => "AlreadyExistsException",
                .cfn_registry_exception => "CFNRegistryException",
                .change_set_not_found_exception => "ChangeSetNotFoundException",
                .concurrent_resources_limit_exceeded_exception => "ConcurrentResourcesLimitExceededException",
                .created_but_modified_exception => "CreatedButModifiedException",
                .generated_template_not_found_exception => "GeneratedTemplateNotFoundException",
                .hook_result_not_found_exception => "HookResultNotFoundException",
                .insufficient_capabilities_exception => "InsufficientCapabilitiesException",
                .invalid_change_set_status_exception => "InvalidChangeSetStatusException",
                .invalid_operation_exception => "InvalidOperationException",
                .invalid_state_transition_exception => "InvalidStateTransitionException",
                .limit_exceeded_exception => "LimitExceededException",
                .name_already_exists_exception => "NameAlreadyExistsException",
                .operation_id_already_exists_exception => "OperationIdAlreadyExistsException",
                .operation_in_progress_exception => "OperationInProgressException",
                .operation_not_found_exception => "OperationNotFoundException",
                .operation_status_check_failed_exception => "OperationStatusCheckFailedException",
                .resource_scan_in_progress_exception => "ResourceScanInProgressException",
                .resource_scan_limit_exceeded_exception => "ResourceScanLimitExceededException",
                .resource_scan_not_found_exception => "ResourceScanNotFoundException",
                .stack_instance_not_found_exception => "StackInstanceNotFoundException",
                .stack_not_found_exception => "StackNotFoundException",
                .stack_refactor_not_found_exception => "StackRefactorNotFoundException",
                .stack_set_not_empty_exception => "StackSetNotEmptyException",
                .stack_set_not_found_exception => "StackSetNotFoundException",
                .stale_request_exception => "StaleRequestException",
                .token_already_exists_exception => "TokenAlreadyExistsException",
                .type_configuration_not_found_exception => "TypeConfigurationNotFoundException",
                .type_not_found_exception => "TypeNotFoundException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .already_exists_exception => |e| e.message,
                .cfn_registry_exception => |e| e.message,
                .change_set_not_found_exception => |e| e.message,
                .concurrent_resources_limit_exceeded_exception => |e| e.message,
                .created_but_modified_exception => |e| e.message,
                .generated_template_not_found_exception => |e| e.message,
                .hook_result_not_found_exception => |e| e.message,
                .insufficient_capabilities_exception => |e| e.message,
                .invalid_change_set_status_exception => |e| e.message,
                .invalid_operation_exception => |e| e.message,
                .invalid_state_transition_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .name_already_exists_exception => |e| e.message,
                .operation_id_already_exists_exception => |e| e.message,
                .operation_in_progress_exception => |e| e.message,
                .operation_not_found_exception => |e| e.message,
                .operation_status_check_failed_exception => |e| e.message,
                .resource_scan_in_progress_exception => |e| e.message,
                .resource_scan_limit_exceeded_exception => |e| e.message,
                .resource_scan_not_found_exception => |e| e.message,
                .stack_instance_not_found_exception => |e| e.message,
                .stack_not_found_exception => |e| e.message,
                .stack_refactor_not_found_exception => |e| e.message,
                .stack_set_not_empty_exception => |e| e.message,
                .stack_set_not_found_exception => |e| e.message,
                .stale_request_exception => |e| e.message,
                .token_already_exists_exception => |e| e.message,
                .type_configuration_not_found_exception => |e| e.message,
                .type_not_found_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .already_exists_exception => 400,
                .cfn_registry_exception => 400,
                .change_set_not_found_exception => 404,
                .concurrent_resources_limit_exceeded_exception => 429,
                .created_but_modified_exception => 409,
                .generated_template_not_found_exception => 404,
                .hook_result_not_found_exception => 404,
                .insufficient_capabilities_exception => 400,
                .invalid_change_set_status_exception => 400,
                .invalid_operation_exception => 400,
                .invalid_state_transition_exception => 400,
                .limit_exceeded_exception => 400,
                .name_already_exists_exception => 409,
                .operation_id_already_exists_exception => 409,
                .operation_in_progress_exception => 409,
                .operation_not_found_exception => 404,
                .operation_status_check_failed_exception => 400,
                .resource_scan_in_progress_exception => 400,
                .resource_scan_limit_exceeded_exception => 400,
                .resource_scan_not_found_exception => 400,
                .stack_instance_not_found_exception => 404,
                .stack_not_found_exception => 404,
                .stack_refactor_not_found_exception => 404,
                .stack_set_not_empty_exception => 409,
                .stack_set_not_found_exception => 404,
                .stale_request_exception => 409,
                .token_already_exists_exception => 400,
                .type_configuration_not_found_exception => 404,
                .type_not_found_exception => 404,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .already_exists_exception => |e| e.request_id,
                .cfn_registry_exception => |e| e.request_id,
                .change_set_not_found_exception => |e| e.request_id,
                .concurrent_resources_limit_exceeded_exception => |e| e.request_id,
                .created_but_modified_exception => |e| e.request_id,
                .generated_template_not_found_exception => |e| e.request_id,
                .hook_result_not_found_exception => |e| e.request_id,
                .insufficient_capabilities_exception => |e| e.request_id,
                .invalid_change_set_status_exception => |e| e.request_id,
                .invalid_operation_exception => |e| e.request_id,
                .invalid_state_transition_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .name_already_exists_exception => |e| e.request_id,
                .operation_id_already_exists_exception => |e| e.request_id,
                .operation_in_progress_exception => |e| e.request_id,
                .operation_not_found_exception => |e| e.request_id,
                .operation_status_check_failed_exception => |e| e.request_id,
                .resource_scan_in_progress_exception => |e| e.request_id,
                .resource_scan_limit_exceeded_exception => |e| e.request_id,
                .resource_scan_not_found_exception => |e| e.request_id,
                .stack_instance_not_found_exception => |e| e.request_id,
                .stack_not_found_exception => |e| e.request_id,
                .stack_refactor_not_found_exception => |e| e.request_id,
                .stack_set_not_empty_exception => |e| e.request_id,
                .stack_set_not_found_exception => |e| e.request_id,
                .stale_request_exception => |e| e.request_id,
                .token_already_exists_exception => |e| e.request_id,
                .type_configuration_not_found_exception => |e| e.request_id,
                .type_not_found_exception => |e| e.request_id,
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

pub const AlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CFNRegistryException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ChangeSetNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConcurrentResourcesLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CreatedButModifiedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GeneratedTemplateNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const HookResultNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientCapabilitiesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidChangeSetStatusException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidOperationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidStateTransitionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NameAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationIdAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationStatusCheckFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceScanInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceScanLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceScanNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StackInstanceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StackNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StackRefactorNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StackSetNotEmptyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StackSetNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StaleRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TokenAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TypeConfigurationNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TypeNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
