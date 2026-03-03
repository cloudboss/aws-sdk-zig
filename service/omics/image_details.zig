/// Information about the container image used for a task.
pub const ImageDetails = struct {
    /// The URI of the container image.
    image: ?[]const u8 = null,

    /// The container image digest. If the image URI was transformed, this will be
    /// the digest of the container image referenced by the transformed URI.
    image_digest: ?[]const u8 = null,

    /// URI of the source registry. If the URI is from a third-party registry,
    /// Amazon Web Services HealthOmics transforms the URI to the corresponding ECR
    /// path, using the pull-through cache mapping rules.
    source_image: ?[]const u8 = null,

    pub const json_field_names = .{
        .image = "image",
        .image_digest = "imageDigest",
        .source_image = "sourceImage",
    };
};
