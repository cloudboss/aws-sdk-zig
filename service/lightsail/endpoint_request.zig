const ContainerServiceHealthCheckConfig = @import("container_service_health_check_config.zig").ContainerServiceHealthCheckConfig;

/// Describes the settings of a public endpoint for an Amazon Lightsail
/// container
/// service.
pub const EndpointRequest = struct {
    /// The name of the container for the endpoint.
    container_name: []const u8,

    /// The port of the container to which traffic is forwarded to.
    container_port: i32,

    /// An object that describes the health check configuration of the container.
    health_check: ?ContainerServiceHealthCheckConfig = null,

    pub const json_field_names = .{
        .container_name = "containerName",
        .container_port = "containerPort",
        .health_check = "healthCheck",
    };
};
