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

/// You don't have authorization to perform the requested action.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You can apply up to 10 custom attributes for each resource. You can view the
/// attributes of a resource with
/// [ListAttributes](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ListAttributes.html). You can remove existing attributes on a resource with [DeleteAttributes](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DeleteAttributes.html).
pub const AttributeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Your Amazon Web Services account was blocked. For more information, contact
/// [ Amazon Web Services Support](http://aws.amazon.com/contact-us/).
pub const BlockedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// These errors are usually caused by a client action. This client action might
/// be using an action or resource on behalf of a user that doesn't have
/// permissions to use the action or resource. Or, it might be specifying an
/// identifier that isn't valid.
pub const ClientException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The cluster contains one or more capacity providers that prevent the
/// requested operation. This exception occurs when you try to delete a cluster
/// that still has active capacity providers, including Amazon ECS Managed
/// Instances capacity providers. You must first delete all capacity providers
/// from the cluster before you can delete the cluster itself.
pub const ClusterContainsCapacityProviderException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You can't delete a cluster that has registered container instances. First,
/// deregister the container instances before you can delete the cluster. For
/// more information, see
/// [DeregisterContainerInstance](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DeregisterContainerInstance.html).
pub const ClusterContainsContainerInstancesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You can't delete a cluster that contains services. First, update the service
/// to reduce its desired task count to 0, and then delete the service. For more
/// information, see
/// [UpdateService](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_UpdateService.html) and [DeleteService](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DeleteService.html).
pub const ClusterContainsServicesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// You can't delete a cluster that has active tasks.
pub const ClusterContainsTasksException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified cluster wasn't found. You can view your available clusters
/// with
/// [ListClusters](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ListClusters.html). Amazon ECS clusters are Region specific.
pub const ClusterNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request could not be processed because of conflict in the current state
/// of the resource.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The existing task ARNs which are already associated with the `clientToken`.
    resource_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .resource_ids = "resourceIds",
    };
};

/// The specified daemon isn't active. You can't update a daemon that's
/// inactive. If you have previously deleted a daemon, you can re-create it with
/// [CreateDaemon](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_CreateDaemon.html).
pub const DaemonNotActiveException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified daemon wasn't found. You can view your available daemons with
/// [ListDaemons](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ListDaemons.html). Amazon ECS daemons are cluster specific and Region specific.
pub const DaemonNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified parameter isn't valid. Review the available parameters for the
/// API request.
///
/// For more information about service event errors, see [Amazon ECS service
/// event
/// messages](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-event-messages-list.html).
pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The limit for the resource was exceeded.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Amazon ECS can't determine the current version of the Amazon ECS container
/// agent on the container instance and doesn't have enough information to
/// proceed with an update. This could be because the agent running on the
/// container instance is a previous or custom version that doesn't use our
/// version information.
pub const MissingVersionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified namespace wasn't found.
pub const NamespaceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// There's no update available for this Amazon ECS container agent. This might
/// be because the agent is already running the latest version or because it's
/// so old that there's no update path to the current version.
pub const NoUpdateAvailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified platform version doesn't satisfy the required capabilities of
/// the task definition.
pub const PlatformTaskDefinitionIncompatibilityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified platform version doesn't exist.
pub const PlatformUnknownException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified resource is in-use and can't be removed.
pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified resource wasn't found.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// These errors are usually caused by a server issue.
pub const ServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The service deploy ARN that you specified in the `StopServiceDeployment`
/// doesn't exist. You can use `ListServiceDeployments` to retrieve the service
/// deployment ARNs.
pub const ServiceDeploymentNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified service isn't active. You can't update a service that's
/// inactive. If you have previously deleted a service, you can re-create it
/// with
/// [CreateService](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_CreateService.html).
pub const ServiceNotActiveException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified service wasn't found. You can view your available services
/// with
/// [ListServices](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ListServices.html). Amazon ECS services are cluster specific and Region specific.
pub const ServiceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The execute command cannot run. This error can be caused by any of the
/// following configuration issues:
///
/// * Incorrect IAM permissions
/// * The SSM agent is not installed or is not running
/// * There is an interface Amazon VPC endpoint for Amazon ECS, but there is not
///   one for Systems Manager Session Manager
///
/// For information about how to troubleshoot the issues, see [Troubleshooting
/// issues with ECS
/// Exec](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-exec.html) in the *Amazon Elastic Container Service Developer Guide*.
pub const TargetNotConnectedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified target wasn't found. You can view your available container
/// instances with
/// [ListContainerInstances](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ListContainerInstances.html). Amazon ECS container instances are cluster-specific and Region-specific.
pub const TargetNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified task set wasn't found. You can view your available task sets
/// with
/// [DescribeTaskSets](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DescribeTaskSets.html). Task sets are specific to each cluster, service and Region.
pub const TaskSetNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified task isn't supported in this Region.
pub const UnsupportedFeatureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// There's already a current Amazon ECS container agent update in progress on
/// the container instance that's specified. If the container agent becomes
/// disconnected while it's in a transitional stage, such as `PENDING` or
/// `STAGING`, the update process can get stuck in that state. However, when the
/// agent reconnects, it resumes where it stopped previously.
pub const UpdateInProgressException = struct {
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
