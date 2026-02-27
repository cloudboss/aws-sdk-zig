/// A host device to expose to the container.
pub const AwsEcsTaskDefinitionContainerDefinitionsLinuxParametersDevicesDetails = struct {
    /// The path inside the container at which to expose the host device.
    container_path: ?[]const u8,

    /// The path for the device on the host container instance.
    host_path: ?[]const u8,

    /// The explicit permissions to provide to the container for the device. By
    /// default, the container has permissions for read, write, and `mknod` for the
    /// device.
    permissions: ?[]const []const u8,

    pub const json_field_names = .{
        .container_path = "ContainerPath",
        .host_path = "HostPath",
        .permissions = "Permissions",
    };
};
