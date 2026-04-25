const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        attribute_limit_exceeded_exception: AttributeLimitExceededException,
        blocked_exception: BlockedException,
        client_exception: ClientException,
        cluster_contains_capacity_provider_exception: ClusterContainsCapacityProviderException,
        cluster_contains_container_instances_exception: ClusterContainsContainerInstancesException,
        cluster_contains_services_exception: ClusterContainsServicesException,
        cluster_contains_tasks_exception: ClusterContainsTasksException,
        cluster_not_found_exception: ClusterNotFoundException,
        conflict_exception: ConflictException,
        daemon_not_active_exception: DaemonNotActiveException,
        daemon_not_found_exception: DaemonNotFoundException,
        invalid_parameter_exception: InvalidParameterException,
        limit_exceeded_exception: LimitExceededException,
        missing_version_exception: MissingVersionException,
        namespace_not_found_exception: NamespaceNotFoundException,
        no_update_available_exception: NoUpdateAvailableException,
        platform_task_definition_incompatibility_exception: PlatformTaskDefinitionIncompatibilityException,
        platform_unknown_exception: PlatformUnknownException,
        resource_in_use_exception: ResourceInUseException,
        resource_not_found_exception: ResourceNotFoundException,
        server_exception: ServerException,
        service_deployment_not_found_exception: ServiceDeploymentNotFoundException,
        service_not_active_exception: ServiceNotActiveException,
        service_not_found_exception: ServiceNotFoundException,
        target_not_connected_exception: TargetNotConnectedException,
        target_not_found_exception: TargetNotFoundException,
        task_set_not_found_exception: TaskSetNotFoundException,
        unsupported_feature_exception: UnsupportedFeatureException,
        update_in_progress_exception: UpdateInProgressException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .attribute_limit_exceeded_exception => "AttributeLimitExceededException",
                .blocked_exception => "BlockedException",
                .client_exception => "ClientException",
                .cluster_contains_capacity_provider_exception => "ClusterContainsCapacityProviderException",
                .cluster_contains_container_instances_exception => "ClusterContainsContainerInstancesException",
                .cluster_contains_services_exception => "ClusterContainsServicesException",
                .cluster_contains_tasks_exception => "ClusterContainsTasksException",
                .cluster_not_found_exception => "ClusterNotFoundException",
                .conflict_exception => "ConflictException",
                .daemon_not_active_exception => "DaemonNotActiveException",
                .daemon_not_found_exception => "DaemonNotFoundException",
                .invalid_parameter_exception => "InvalidParameterException",
                .limit_exceeded_exception => "LimitExceededException",
                .missing_version_exception => "MissingVersionException",
                .namespace_not_found_exception => "NamespaceNotFoundException",
                .no_update_available_exception => "NoUpdateAvailableException",
                .platform_task_definition_incompatibility_exception => "PlatformTaskDefinitionIncompatibilityException",
                .platform_unknown_exception => "PlatformUnknownException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .server_exception => "ServerException",
                .service_deployment_not_found_exception => "ServiceDeploymentNotFoundException",
                .service_not_active_exception => "ServiceNotActiveException",
                .service_not_found_exception => "ServiceNotFoundException",
                .target_not_connected_exception => "TargetNotConnectedException",
                .target_not_found_exception => "TargetNotFoundException",
                .task_set_not_found_exception => "TaskSetNotFoundException",
                .unsupported_feature_exception => "UnsupportedFeatureException",
                .update_in_progress_exception => "UpdateInProgressException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .attribute_limit_exceeded_exception => |e| e.message,
                .blocked_exception => |e| e.message,
                .client_exception => |e| e.message,
                .cluster_contains_capacity_provider_exception => |e| e.message,
                .cluster_contains_container_instances_exception => |e| e.message,
                .cluster_contains_services_exception => |e| e.message,
                .cluster_contains_tasks_exception => |e| e.message,
                .cluster_not_found_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .daemon_not_active_exception => |e| e.message,
                .daemon_not_found_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .missing_version_exception => |e| e.message,
                .namespace_not_found_exception => |e| e.message,
                .no_update_available_exception => |e| e.message,
                .platform_task_definition_incompatibility_exception => |e| e.message,
                .platform_unknown_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .server_exception => |e| e.message,
                .service_deployment_not_found_exception => |e| e.message,
                .service_not_active_exception => |e| e.message,
                .service_not_found_exception => |e| e.message,
                .target_not_connected_exception => |e| e.message,
                .target_not_found_exception => |e| e.message,
                .task_set_not_found_exception => |e| e.message,
                .unsupported_feature_exception => |e| e.message,
                .update_in_progress_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .attribute_limit_exceeded_exception => 400,
                .blocked_exception => 400,
                .client_exception => 400,
                .cluster_contains_capacity_provider_exception => 400,
                .cluster_contains_container_instances_exception => 400,
                .cluster_contains_services_exception => 400,
                .cluster_contains_tasks_exception => 400,
                .cluster_not_found_exception => 400,
                .conflict_exception => 400,
                .daemon_not_active_exception => 400,
                .daemon_not_found_exception => 400,
                .invalid_parameter_exception => 400,
                .limit_exceeded_exception => 400,
                .missing_version_exception => 400,
                .namespace_not_found_exception => 400,
                .no_update_available_exception => 400,
                .platform_task_definition_incompatibility_exception => 400,
                .platform_unknown_exception => 400,
                .resource_in_use_exception => 400,
                .resource_not_found_exception => 400,
                .server_exception => 500,
                .service_deployment_not_found_exception => 400,
                .service_not_active_exception => 400,
                .service_not_found_exception => 400,
                .target_not_connected_exception => 400,
                .target_not_found_exception => 400,
                .task_set_not_found_exception => 400,
                .unsupported_feature_exception => 400,
                .update_in_progress_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .attribute_limit_exceeded_exception => |e| e.request_id,
                .blocked_exception => |e| e.request_id,
                .client_exception => |e| e.request_id,
                .cluster_contains_capacity_provider_exception => |e| e.request_id,
                .cluster_contains_container_instances_exception => |e| e.request_id,
                .cluster_contains_services_exception => |e| e.request_id,
                .cluster_contains_tasks_exception => |e| e.request_id,
                .cluster_not_found_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .daemon_not_active_exception => |e| e.request_id,
                .daemon_not_found_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .missing_version_exception => |e| e.request_id,
                .namespace_not_found_exception => |e| e.request_id,
                .no_update_available_exception => |e| e.request_id,
                .platform_task_definition_incompatibility_exception => |e| e.request_id,
                .platform_unknown_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .server_exception => |e| e.request_id,
                .service_deployment_not_found_exception => |e| e.request_id,
                .service_not_active_exception => |e| e.request_id,
                .service_not_found_exception => |e| e.request_id,
                .target_not_connected_exception => |e| e.request_id,
                .target_not_found_exception => |e| e.request_id,
                .task_set_not_found_exception => |e| e.request_id,
                .unsupported_feature_exception => |e| e.request_id,
                .update_in_progress_exception => |e| e.request_id,
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

pub const AttributeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BlockedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClientException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterContainsCapacityProviderException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterContainsContainerInstancesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterContainsServicesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterContainsTasksException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClusterNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DaemonNotActiveException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DaemonNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MissingVersionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NamespaceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoUpdateAvailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PlatformTaskDefinitionIncompatibilityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PlatformUnknownException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceDeploymentNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceNotActiveException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TargetNotConnectedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TargetNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TaskSetNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedFeatureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UpdateInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
