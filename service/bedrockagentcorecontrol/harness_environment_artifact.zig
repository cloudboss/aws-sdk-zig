const ContainerConfiguration = @import("container_configuration.zig").ContainerConfiguration;

/// The environment artifact for a harness, such as a container image containing
/// custom dependencies.
pub const HarnessEnvironmentArtifact = union(enum) {
    container_configuration: ?ContainerConfiguration,

    pub const json_field_names = .{
        .container_configuration = "containerConfiguration",
    };
};
