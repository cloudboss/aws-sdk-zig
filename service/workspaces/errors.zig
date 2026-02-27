const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        application_not_supported_exception: ApplicationNotSupportedException,
        compute_not_compatible_exception: ComputeNotCompatibleException,
        conflict_exception: ConflictException,
        incompatible_applications_exception: IncompatibleApplicationsException,
        internal_server_exception: InternalServerException,
        invalid_parameter_combination_exception: InvalidParameterCombinationException,
        invalid_parameter_values_exception: InvalidParameterValuesException,
        invalid_resource_state_exception: InvalidResourceStateException,
        operating_system_not_compatible_exception: OperatingSystemNotCompatibleException,
        operation_in_progress_exception: OperationInProgressException,
        operation_not_supported_exception: OperationNotSupportedException,
        resource_already_exists_exception: ResourceAlreadyExistsException,
        resource_associated_exception: ResourceAssociatedException,
        resource_creation_failed_exception: ResourceCreationFailedException,
        resource_in_use_exception: ResourceInUseException,
        resource_limit_exceeded_exception: ResourceLimitExceededException,
        resource_not_found_exception: ResourceNotFoundException,
        resource_unavailable_exception: ResourceUnavailableException,
        unsupported_network_configuration_exception: UnsupportedNetworkConfigurationException,
        unsupported_workspace_configuration_exception: UnsupportedWorkspaceConfigurationException,
        validation_exception: ValidationException,
        workspaces_default_role_not_found_exception: WorkspacesDefaultRoleNotFoundException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .application_not_supported_exception => "ApplicationNotSupportedException",
                .compute_not_compatible_exception => "ComputeNotCompatibleException",
                .conflict_exception => "ConflictException",
                .incompatible_applications_exception => "IncompatibleApplicationsException",
                .internal_server_exception => "InternalServerException",
                .invalid_parameter_combination_exception => "InvalidParameterCombinationException",
                .invalid_parameter_values_exception => "InvalidParameterValuesException",
                .invalid_resource_state_exception => "InvalidResourceStateException",
                .operating_system_not_compatible_exception => "OperatingSystemNotCompatibleException",
                .operation_in_progress_exception => "OperationInProgressException",
                .operation_not_supported_exception => "OperationNotSupportedException",
                .resource_already_exists_exception => "ResourceAlreadyExistsException",
                .resource_associated_exception => "ResourceAssociatedException",
                .resource_creation_failed_exception => "ResourceCreationFailedException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_limit_exceeded_exception => "ResourceLimitExceededException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .resource_unavailable_exception => "ResourceUnavailableException",
                .unsupported_network_configuration_exception => "UnsupportedNetworkConfigurationException",
                .unsupported_workspace_configuration_exception => "UnsupportedWorkspaceConfigurationException",
                .validation_exception => "ValidationException",
                .workspaces_default_role_not_found_exception => "WorkspacesDefaultRoleNotFoundException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .application_not_supported_exception => |e| e.message,
                .compute_not_compatible_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .incompatible_applications_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .invalid_parameter_combination_exception => |e| e.message,
                .invalid_parameter_values_exception => |e| e.message,
                .invalid_resource_state_exception => |e| e.message,
                .operating_system_not_compatible_exception => |e| e.message,
                .operation_in_progress_exception => |e| e.message,
                .operation_not_supported_exception => |e| e.message,
                .resource_already_exists_exception => |e| e.message,
                .resource_associated_exception => |e| e.message,
                .resource_creation_failed_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_limit_exceeded_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .resource_unavailable_exception => |e| e.message,
                .unsupported_network_configuration_exception => |e| e.message,
                .unsupported_workspace_configuration_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .workspaces_default_role_not_found_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 400,
                .application_not_supported_exception => 400,
                .compute_not_compatible_exception => 400,
                .conflict_exception => 400,
                .incompatible_applications_exception => 400,
                .internal_server_exception => 400,
                .invalid_parameter_combination_exception => 400,
                .invalid_parameter_values_exception => 400,
                .invalid_resource_state_exception => 400,
                .operating_system_not_compatible_exception => 400,
                .operation_in_progress_exception => 400,
                .operation_not_supported_exception => 400,
                .resource_already_exists_exception => 400,
                .resource_associated_exception => 400,
                .resource_creation_failed_exception => 400,
                .resource_in_use_exception => 400,
                .resource_limit_exceeded_exception => 400,
                .resource_not_found_exception => 400,
                .resource_unavailable_exception => 400,
                .unsupported_network_configuration_exception => 400,
                .unsupported_workspace_configuration_exception => 400,
                .validation_exception => 400,
                .workspaces_default_role_not_found_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .application_not_supported_exception => |e| e.request_id,
                .compute_not_compatible_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .incompatible_applications_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .invalid_parameter_combination_exception => |e| e.request_id,
                .invalid_parameter_values_exception => |e| e.request_id,
                .invalid_resource_state_exception => |e| e.request_id,
                .operating_system_not_compatible_exception => |e| e.request_id,
                .operation_in_progress_exception => |e| e.request_id,
                .operation_not_supported_exception => |e| e.request_id,
                .resource_already_exists_exception => |e| e.request_id,
                .resource_associated_exception => |e| e.request_id,
                .resource_creation_failed_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_limit_exceeded_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .resource_unavailable_exception => |e| e.request_id,
                .unsupported_network_configuration_exception => |e| e.request_id,
                .unsupported_workspace_configuration_exception => |e| e.request_id,
                .validation_exception => |e| e.request_id,
                .workspaces_default_role_not_found_exception => |e| e.request_id,
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

pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ApplicationNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ComputeNotCompatibleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IncompatibleApplicationsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterCombinationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterValuesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidResourceStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperatingSystemNotCompatibleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceAssociatedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceCreationFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedNetworkConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedWorkspaceConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const WorkspacesDefaultRoleNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
