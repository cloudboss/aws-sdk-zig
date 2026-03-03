const ContainerInfo = @import("container_info.zig").ContainerInfo;
const ContainerProviderType = @import("container_provider_type.zig").ContainerProviderType;

/// The information about the container provider.
pub const ContainerProvider = struct {
    /// The ID of the container cluster.
    id: []const u8,

    /// The information about the container cluster.
    info: ?ContainerInfo = null,

    /// The type of the container provider. Amazon EKS is the only supported type as
    /// of
    /// now.
    @"type": ContainerProviderType,

    pub const json_field_names = .{
        .id = "id",
        .info = "info",
        .@"type" = "type",
    };
};
