const TargetContainerRepository = @import("target_container_repository.zig").TargetContainerRepository;

/// Defines how the output container image is distributed in a specific
/// Amazon Web Services Region: the target repository, the image tags to apply
/// to the
/// distributed image, and an optional description.
pub const ContainerDistributionConfiguration = struct {
    /// Tags that Image Builder applies to the distributed container image in the
    /// target
    /// repository. These are repository image tags, not resource tags.
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
