const ContainerServiceHealthCheckConfig = @import("container_service_health_check_config.zig").ContainerServiceHealthCheckConfig;

/// Describes the public endpoint configuration of a deployment of an Amazon
/// Lightsail
/// container service.
pub const ContainerServiceEndpoint = struct {
    /// The name of the container entry of the deployment that the endpoint
    /// configuration applies
    /// to.
    container_name: ?[]const u8,

    /// The port of the specified container to which traffic is forwarded to.
    container_port: ?i32,

    /// An object that describes the health check configuration of the container.
    health_check: ?ContainerServiceHealthCheckConfig,

    pub const json_field_names = .{
        .container_name = "containerName",
        .container_port = "containerPort",
        .health_check = "healthCheck",
    };
};
