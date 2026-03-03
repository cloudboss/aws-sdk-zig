const aws = @import("aws");

const ContainerServiceProtocol = @import("container_service_protocol.zig").ContainerServiceProtocol;

/// Describes the settings of a container that will be launched, or that is
/// launched, to an
/// Amazon Lightsail container service.
pub const Container = struct {
    /// The launch command for the container.
    command: ?[]const []const u8 = null,

    /// The environment variables of the container.
    environment: ?[]const aws.map.StringMapEntry = null,

    /// The name of the image used for the container.
    ///
    /// Container images sourced from your Lightsail container service, that are
    /// registered and
    /// stored on your service, start with a colon (`:`). For example, if your
    /// container
    /// service name is `container-service-1`, the container image label is
    /// `mystaticsite`, and you want to use the third (`3`) version of the
    /// registered container image, then you should specify
    /// `:container-service-1.mystaticsite.3`. To use the latest version of a
    /// container
    /// image, specify `latest` instead of a version number (for example,
    /// `:container-service-1.mystaticsite.latest`). Lightsail will automatically
    /// use
    /// the highest numbered version of the registered container image.
    ///
    /// Container images sourced from a public registry like Docker Hub don't start
    /// with a colon.
    /// For example, `nginx:latest` or `nginx`.
    image: ?[]const u8 = null,

    /// The open firewall ports of the container.
    ports: ?[]const aws.map.MapEntry(ContainerServiceProtocol) = null,

    pub const json_field_names = .{
        .command = "command",
        .environment = "environment",
        .image = "image",
        .ports = "ports",
    };
};
