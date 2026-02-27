const ContainerRepositoryService = @import("container_repository_service.zig").ContainerRepositoryService;

/// The container repository where the output container image is stored.
pub const TargetContainerRepository = struct {
    /// The name of the container repository where the output container image is
    /// stored.
    /// This name is prefixed by the repository location. For example,
    /// `/repository_name`.
    repository_name: []const u8,

    /// Specifies the service in which this image was registered.
    service: ContainerRepositoryService,

    pub const json_field_names = .{
        .repository_name = "repositoryName",
        .service = "service",
    };
};
