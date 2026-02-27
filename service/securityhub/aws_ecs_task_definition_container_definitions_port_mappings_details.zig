/// A port mapping for the container.
pub const AwsEcsTaskDefinitionContainerDefinitionsPortMappingsDetails = struct {
    /// The port number on the container that is bound to the user-specified or
    /// automatically assigned host port.
    container_port: ?i32,

    /// The port number on the container instance to reserve for the container.
    host_port: ?i32,

    /// The protocol used for the port mapping. The default is `tcp`.
    protocol: ?[]const u8,

    pub const json_field_names = .{
        .container_port = "ContainerPort",
        .host_port = "HostPort",
        .protocol = "Protocol",
    };
};
