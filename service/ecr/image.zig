const ImageIdentifier = @import("image_identifier.zig").ImageIdentifier;

/// An object representing an Amazon ECR image.
pub const Image = struct {
    /// An object containing the image tag and image digest associated with an
    /// image.
    image_id: ?ImageIdentifier,

    /// The image manifest associated with the image.
    image_manifest: ?[]const u8,

    /// The manifest media type of the image.
    image_manifest_media_type: ?[]const u8,

    /// The Amazon Web Services account ID associated with the registry containing
    /// the image.
    registry_id: ?[]const u8,

    /// The name of the repository associated with the image.
    repository_name: ?[]const u8,

    pub const json_field_names = .{
        .image_id = "imageId",
        .image_manifest = "imageManifest",
        .image_manifest_media_type = "imageManifestMediaType",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
    };
};
