const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const ImageScanningConfiguration = @import("image_scanning_configuration.zig").ImageScanningConfiguration;
const ImageTagMutability = @import("image_tag_mutability.zig").ImageTagMutability;
const ImageTagMutabilityExclusionFilter = @import("image_tag_mutability_exclusion_filter.zig").ImageTagMutabilityExclusionFilter;

/// An object representing a repository.
pub const Repository = struct {
    /// The date and time, in JavaScript date format, when the repository was
    /// created.
    created_at: ?i64,

    /// The encryption configuration for the repository. This determines how the
    /// contents of
    /// your repository are encrypted at rest.
    encryption_configuration: ?EncryptionConfiguration,

    image_scanning_configuration: ?ImageScanningConfiguration,

    /// The tag mutability setting for the repository.
    image_tag_mutability: ?ImageTagMutability,

    /// A list of filters that specify which image tags are excluded from the
    /// repository's
    /// image tag mutability setting.
    image_tag_mutability_exclusion_filters: ?[]const ImageTagMutabilityExclusionFilter,

    /// The Amazon Web Services account ID associated with the registry that
    /// contains the repository.
    registry_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) that identifies the repository. The ARN
    /// contains the `arn:aws:ecr` namespace, followed by the region of the
    /// repository, Amazon Web Services account ID of the repository owner,
    /// repository namespace, and repository name.
    /// For example,
    /// `arn:aws:ecr:region:012345678910:repository-namespace/repository-name`.
    repository_arn: ?[]const u8,

    /// The name of the repository.
    repository_name: ?[]const u8,

    /// The URI for the repository. You can use this URI for container image `push`
    /// and `pull` operations.
    repository_uri: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .encryption_configuration = "encryptionConfiguration",
        .image_scanning_configuration = "imageScanningConfiguration",
        .image_tag_mutability = "imageTagMutability",
        .image_tag_mutability_exclusion_filters = "imageTagMutabilityExclusionFilters",
        .registry_id = "registryId",
        .repository_arn = "repositoryArn",
        .repository_name = "repositoryName",
        .repository_uri = "repositoryUri",
    };
};
