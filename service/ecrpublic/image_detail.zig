/// An object that describes an image that's returned by a DescribeImages
/// operation.
pub const ImageDetail = struct {
    /// The artifact media type of the image.
    artifact_media_type: ?[]const u8,

    /// The `sha256` digest of the image manifest.
    image_digest: ?[]const u8,

    /// The media type of the image manifest.
    image_manifest_media_type: ?[]const u8,

    /// The date and time, expressed in standard JavaScript date format, that the
    /// current image
    /// was pushed to the repository at.
    image_pushed_at: ?i64,

    /// The size, in bytes, of the image in the repository.
    ///
    /// If the image is a manifest list, this is the max size of all manifests in
    /// the
    /// list.
    ///
    /// Beginning with Docker version 1.9, the Docker client compresses image layers
    /// before
    /// pushing them to a V2 Docker registry. The output of the `docker images`
    /// command shows the uncompressed image size, so it might return a larger image
    /// size than
    /// the image sizes that are returned by DescribeImages.
    image_size_in_bytes: ?i64,

    /// The list of tags that's associated with this image.
    image_tags: ?[]const []const u8,

    /// The Amazon Web Services account ID that's associated with the public
    /// registry where this image
    /// belongs.
    registry_id: ?[]const u8,

    /// The name of the repository where this image belongs.
    repository_name: ?[]const u8,

    pub const json_field_names = .{
        .artifact_media_type = "artifactMediaType",
        .image_digest = "imageDigest",
        .image_manifest_media_type = "imageManifestMediaType",
        .image_pushed_at = "imagePushedAt",
        .image_size_in_bytes = "imageSizeInBytes",
        .image_tags = "imageTags",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
    };
};
