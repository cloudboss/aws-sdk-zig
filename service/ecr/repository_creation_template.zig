const RCTAppliedFor = @import("rct_applied_for.zig").RCTAppliedFor;
const EncryptionConfigurationForRepositoryCreationTemplate = @import("encryption_configuration_for_repository_creation_template.zig").EncryptionConfigurationForRepositoryCreationTemplate;
const ImageTagMutability = @import("image_tag_mutability.zig").ImageTagMutability;
const ImageTagMutabilityExclusionFilter = @import("image_tag_mutability_exclusion_filter.zig").ImageTagMutabilityExclusionFilter;
const Tag = @import("tag.zig").Tag;

/// The details of the repository creation template associated with the request.
pub const RepositoryCreationTemplate = struct {
    /// A list of enumerable Strings representing the repository creation scenarios
    /// that this
    /// template will apply towards. The supported scenarios are PULL_THROUGH_CACHE,
    /// REPLICATION, and
    /// CREATE_ON_PUSH
    applied_for: ?[]const RCTAppliedFor,

    /// The date and time, in JavaScript date format, when the repository creation
    /// template
    /// was created.
    created_at: ?i64,

    /// The ARN of the role to be assumed by Amazon ECR. Amazon ECR will assume your
    /// supplied role
    /// when the customRoleArn is specified. When this field isn't specified, Amazon
    /// ECR will use the
    /// service-linked role for the repository creation template.
    custom_role_arn: ?[]const u8,

    /// The description associated with the repository creation template.
    description: ?[]const u8,

    /// The encryption configuration associated with the repository creation
    /// template.
    encryption_configuration: ?EncryptionConfigurationForRepositoryCreationTemplate,

    /// The tag mutability setting for the repository. If this parameter is omitted,
    /// the
    /// default setting of `MUTABLE` will be used which will allow image tags to be
    /// overwritten. If `IMMUTABLE` is specified, all image tags within the
    /// repository will be immutable which will prevent them from being overwritten.
    image_tag_mutability: ?ImageTagMutability,

    /// A list of filters that specify which image tags are excluded from the
    /// repository
    /// creation template's image tag mutability setting.
    image_tag_mutability_exclusion_filters: ?[]const ImageTagMutabilityExclusionFilter,

    /// The lifecycle policy to use for repositories created using the template.
    lifecycle_policy: ?[]const u8,

    /// The repository namespace prefix associated with the repository creation
    /// template.
    prefix: ?[]const u8,

    /// The repository policy to apply to repositories created using the template. A
    /// repository policy is a permissions policy associated with a repository to
    /// control access
    /// permissions.
    repository_policy: ?[]const u8,

    /// The metadata to apply to the repository to help you categorize and organize.
    /// Each tag
    /// consists of a key and an optional value, both of which you define. Tag keys
    /// can have a maximum character length of 128 characters, and tag values can
    /// have
    /// a maximum length of 256 characters.
    resource_tags: ?[]const Tag,

    /// The date and time, in JavaScript date format, when the repository creation
    /// template
    /// was last updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .applied_for = "appliedFor",
        .created_at = "createdAt",
        .custom_role_arn = "customRoleArn",
        .description = "description",
        .encryption_configuration = "encryptionConfiguration",
        .image_tag_mutability = "imageTagMutability",
        .image_tag_mutability_exclusion_filters = "imageTagMutabilityExclusionFilters",
        .lifecycle_policy = "lifecyclePolicy",
        .prefix = "prefix",
        .repository_policy = "repositoryPolicy",
        .resource_tags = "resourceTags",
        .updated_at = "updatedAt",
    };
};
