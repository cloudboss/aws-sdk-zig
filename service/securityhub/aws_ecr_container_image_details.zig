/// Information about an Amazon ECR image.
pub const AwsEcrContainerImageDetails = struct {
    /// The architecture of the image. Valid values are as follows:
    ///
    /// * `arm64`
    ///
    /// * `i386`
    ///
    /// * `x86_64`
    architecture: ?[]const u8,

    /// The sha256 digest of the image manifest.
    image_digest: ?[]const u8,

    /// The date and time when the image was pushed to the repository.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    image_published_at: ?[]const u8,

    /// The list of tags that are associated with the image.
    image_tags: ?[]const []const u8,

    /// The Amazon Web Services account identifier that is associated with the
    /// registry that the image belongs
    /// to.
    registry_id: ?[]const u8,

    /// The name of the repository that the image belongs to.
    repository_name: ?[]const u8,

    pub const json_field_names = .{
        .architecture = "Architecture",
        .image_digest = "ImageDigest",
        .image_published_at = "ImagePublishedAt",
        .image_tags = "ImageTags",
        .registry_id = "RegistryId",
        .repository_name = "RepositoryName",
    };
};
