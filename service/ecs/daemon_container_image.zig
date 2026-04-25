/// The details about the container image a daemon revision uses.
pub const DaemonContainerImage = struct {
    /// The name of the container.
    container_name: ?[]const u8 = null,

    /// The container image.
    image: ?[]const u8 = null,

    /// The container image digest.
    image_digest: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_name = "containerName",
        .image = "image",
        .image_digest = "imageDigest",
    };
};
