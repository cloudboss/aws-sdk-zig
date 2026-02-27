/// Information about a service discovery registry to assign to the service.
pub const AwsEcsServiceServiceRegistriesDetails = struct {
    /// The container name value to use for the service discovery service.
    ///
    /// If the task definition uses the `bridge` or `host` network mode, you must
    /// specify `ContainerName` and `ContainerPort`.
    ///
    /// If the task definition uses the `awsvpc` network mode and a type SRV DNS
    /// record, you must specify either `ContainerName` and `ContainerPort`, or
    /// `Port` , but not both.
    container_name: ?[]const u8,

    /// The port value to use for the service discovery service.
    ///
    /// If the task definition uses the `bridge` or `host` network mode, you must
    /// specify `ContainerName` and `ContainerPort`.
    ///
    /// If the task definition uses the `awsvpc` network mode and a type SRV DNS
    /// record, you must specify either `ContainerName` and `ContainerPort`, or
    /// `Port` , but not both.
    container_port: ?i32,

    /// The port value to use for a service discovery service that specifies an SRV
    /// record. This field can be used if both the `awsvpc`awsvpc network mode and
    /// SRV records are used.
    port: ?i32,

    /// The ARN of the service registry.
    registry_arn: ?[]const u8,

    pub const json_field_names = .{
        .container_name = "ContainerName",
        .container_port = "ContainerPort",
        .port = "Port",
        .registry_arn = "RegistryArn",
    };
};
