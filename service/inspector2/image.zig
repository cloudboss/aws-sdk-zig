/// Contains details about a container image involved in a finding.
pub const Image = struct {
    /// The architecture of the container image.
    architecture: ?[]const u8 = null,

    /// The author of the container image.
    author: ?[]const u8 = null,

    /// The image digest of the container image.
    image_digest: ?[]const u8 = null,

    /// The image tags attached to the container image.
    image_tags: ?[]const []const u8 = null,

    /// The number of times the container image is in use.
    in_use_count: ?i64 = null,

    /// The last time the container image was in use.
    last_in_use_at: ?i64 = null,

    /// The platform of the container image.
    platform: ?[]const u8 = null,

    /// The date and time the container image was pushed.
    pushed_at: ?i64 = null,

    /// The registry for the container image.
    registry: ?[]const u8 = null,

    /// The name of the repository the container image resides in.
    repository_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .architecture = "architecture",
        .author = "author",
        .image_digest = "imageDigest",
        .image_tags = "imageTags",
        .in_use_count = "inUseCount",
        .last_in_use_at = "lastInUseAt",
        .platform = "platform",
        .pushed_at = "pushedAt",
        .registry = "registry",
        .repository_name = "repositoryName",
    };
};
