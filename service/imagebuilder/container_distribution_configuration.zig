const TargetContainerRepository = @import("target_container_repository.zig").TargetContainerRepository;

/// Container distribution settings for encryption, licensing, and sharing in a
/// specific
/// Region.
pub const ContainerDistributionConfiguration = struct {
    /// Tags that are attached to the container distribution configuration.
    container_tags: ?[]const []const u8 = null,

    /// The description of the container distribution configuration.
    description: ?[]const u8 = null,

    /// The destination repository for the container distribution configuration.
    target_repository: TargetContainerRepository,

    pub const json_field_names = .{
        .container_tags = "containerTags",
        .description = "description",
        .target_repository = "targetRepository",
    };
};
