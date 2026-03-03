const aws = @import("aws");

const Container = @import("container.zig").Container;
const ContainerServiceEndpoint = @import("container_service_endpoint.zig").ContainerServiceEndpoint;
const ContainerServiceDeploymentState = @import("container_service_deployment_state.zig").ContainerServiceDeploymentState;

/// Describes a container deployment configuration of an Amazon Lightsail
/// container
/// service.
///
/// A deployment specifies the settings, such as the ports and launch command,
/// of containers
/// that are deployed to your container service.
pub const ContainerServiceDeployment = struct {
    /// An object that describes the configuration for the containers of the
    /// deployment.
    containers: ?[]const aws.map.MapEntry(Container) = null,

    /// The timestamp when the deployment was created.
    created_at: ?i64 = null,

    /// An object that describes the endpoint of the deployment.
    public_endpoint: ?ContainerServiceEndpoint = null,

    /// The state of the deployment.
    ///
    /// A deployment can be in one of the following states:
    ///
    /// * `ACTIVATING` - The deployment is being created.
    ///
    /// * `ACTIVE` - The deployment was successfully created, and it's currently
    /// running on the container service. The container service can have only one
    /// deployment in an
    /// active state at a time.
    ///
    /// * `INACTIVE` - The deployment was previously successfully created, but it is
    /// not currently running on the container service.
    ///
    /// * `FAILED` - The deployment failed. Use the `GetContainerLog`
    /// action to view the log events for the containers in the deployment to try to
    /// determine the
    /// reason for the failure.
    state: ?ContainerServiceDeploymentState = null,

    /// The version number of the deployment.
    version: ?i32 = null,

    pub const json_field_names = .{
        .containers = "containers",
        .created_at = "createdAt",
        .public_endpoint = "publicEndpoint",
        .state = "state",
        .version = "version",
    };
};
