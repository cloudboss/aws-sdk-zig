/// The image details of the Amazon ECR container image.
pub const AwsEcrContainerImageDetails = struct {
    /// The architecture of the Amazon ECR container image.
    architecture: ?[]const u8 = null,

    /// The image author of the Amazon ECR container image.
    author: ?[]const u8 = null,

    /// The image hash of the Amazon ECR container image.
    image_hash: ?[]const u8 = null,

    /// The image tags attached to the Amazon ECR container image.
    image_tags: ?[]const []const u8 = null,

    /// The number of Amazon ECS or Amazon EKS clusters currently running the
    /// image.
    in_use_count: ?i64 = null,

    /// The most recent date and time a cluster was running the image.
    last_in_use_at: ?i64 = null,

    /// The platform of the Amazon ECR container image.
    platform: ?[]const u8 = null,

    /// The date and time the Amazon ECR container image was pushed.
    pushed_at: ?i64 = null,

    /// The registry the Amazon ECR container image belongs to.
    registry: ?[]const u8 = null,

    /// The name of the repository the Amazon ECR container image resides in.
    repository_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .architecture = "architecture",
        .author = "author",
        .image_hash = "imageHash",
        .image_tags = "imageTags",
        .in_use_count = "inUseCount",
        .last_in_use_at = "lastInUseAt",
        .platform = "platform",
        .pushed_at = "pushedAt",
        .registry = "registry",
        .repository_name = "repositoryName",
    };
};
