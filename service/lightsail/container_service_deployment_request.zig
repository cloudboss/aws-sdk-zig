const aws = @import("aws");

const Container = @import("container.zig").Container;
const EndpointRequest = @import("endpoint_request.zig").EndpointRequest;

/// Describes a container deployment configuration of an Amazon Lightsail
/// container
/// service.
///
/// A deployment specifies the settings, such as the ports and launch command,
/// of containers
/// that are deployed to your container service.
pub const ContainerServiceDeploymentRequest = struct {
    /// An object that describes the configuration for the containers of the
    /// deployment.
    containers: ?[]const aws.map.MapEntry(Container) = null,

    /// An object that describes the endpoint of the deployment.
    public_endpoint: ?EndpointRequest = null,

    pub const json_field_names = .{
        .containers = "containers",
        .public_endpoint = "publicEndpoint",
    };
};
