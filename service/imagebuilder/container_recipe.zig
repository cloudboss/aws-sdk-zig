const aws = @import("aws");

const ComponentConfiguration = @import("component_configuration.zig").ComponentConfiguration;
const ContainerType = @import("container_type.zig").ContainerType;
const InstanceConfiguration = @import("instance_configuration.zig").InstanceConfiguration;
const Platform = @import("platform.zig").Platform;
const TargetContainerRepository = @import("target_container_repository.zig").TargetContainerRepository;

/// Defines how Image Builder builds and tests a container image: the base
/// image,
/// components to apply, the Dockerfile template, the build and test instance
/// configuration, and the target repository for the output image.
pub const ContainerRecipe = struct {
    /// The Amazon Resource Name (ARN) of the container recipe.
    ///
    /// Semantic versioning is included in each object's Amazon Resource Name (ARN),
    /// at the level that applies to that object as follows:
    ///
    /// * Versionless ARNs and Name ARNs do not include specific values in any of
    ///   the nodes. The nodes are
    /// either left off entirely, or they are specified as wildcards, for example:
    /// x.x.x.
    ///
    /// * Version ARNs have only the first three nodes: ..
    ///
    /// * Build version ARNs have all four nodes, and point to a specific build for
    ///   a specific version of an object.
    arn: ?[]const u8 = null,

    /// Build and test components that are included in the container recipe.
    /// A recipe can contain a maximum of 20 build and test components
    /// in any combination, by default. This maximum is an adjustable quota. For
    /// more information, see
    /// [EC2 Image Builder endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/imagebuilder.html)
    /// in the *Amazon Web Services General Reference*.
    components: ?[]const ComponentConfiguration = null,

    /// Specifies the type of container, such as Docker.
    container_type: ?ContainerType = null,

    /// The date when this container recipe was created.
    date_created: ?[]const u8 = null,

    /// The description of the container recipe.
    description: ?[]const u8 = null,

    /// The Dockerfile template that Image Builder uses to build the container
    /// image. The
    /// template can include contextual variables that Image Builder replaces with
    /// build
    /// information at build time. For the contextual variables that the template
    /// can include, see [Create
    /// a new version of a container
    /// recipe](https://docs.aws.amazon.com/imagebuilder/latest/userguide/create-container-recipes.html) in the
    /// *EC2 Image Builder User Guide*.
    dockerfile_template_data: ?[]const u8 = null,

    /// Specifies whether the recipe's Dockerfile template data is encrypted at
    /// rest. Image Builder encrypts all Dockerfile template data at rest, so this
    /// value is
    /// always `true`. This field is retained for backward compatibility,
    /// and doesn't describe encryption of the output container image.
    encrypted: ?bool = null,

    /// A group of options that can be used to configure an instance for building
    /// and testing
    /// container images.
    instance_configuration: ?InstanceConfiguration = null,

    /// The KMS key that Image Builder uses to encrypt the recipe's Dockerfile
    /// template
    /// data at rest. This can be either the Key ARN or the Alias ARN. For more
    /// information, see [Key identifiers
    /// (KeyId)](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)
    /// in the *Key Management Service Developer Guide*. If you don't specify a key,
    /// Image Builder
    /// encrypts the template data with a KMS key that Image Builder owns. This key
    /// isn't used to encrypt the output container image.
    kms_key_id: ?[]const u8 = null,

    /// The name of the container recipe.
    name: ?[]const u8 = null,

    /// The owner of the container recipe.
    owner: ?[]const u8 = null,

    /// The base image for customizations specified in the container recipe. This
    /// can
    /// contain an Image Builder image resource ARN or a container image URI, for
    /// example
    /// `amazonlinux:latest`.
    parent_image: ?[]const u8 = null,

    /// The system platform for the container. Container recipes support only the
    /// Linux and Windows platforms.
    platform: ?Platform = null,

    /// Tags that are attached to the container recipe.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The destination repository for the container image.
    target_repository: ?TargetContainerRepository = null,

    /// The semantic version of the container recipe.
    ///
    /// The semantic version has four nodes: ../.
    /// You can assign values for the first three, and can filter on all of them.
    ///
    /// **Assignment:** For the first three nodes, you can assign any positive
    /// integer value, including
    /// zero. The upper limit is 2^30-1, or 1073741823, for each node. Image Builder
    /// automatically assigns the
    /// build number to the fourth node.
    ///
    /// **Patterns:** You can use any numeric pattern that adheres to the assignment
    /// requirements for
    /// the nodes that you can assign. For example, you might choose a software
    /// version pattern, such as 1.0.0, or
    /// a date, such as 2021.01.01.
    ///
    /// **Filtering:** You can use wildcards (x) to specify the most recent versions
    /// or nodes when
    /// selecting the base image or components for your recipe. When you use a
    /// wildcard in any node, all nodes
    /// to the right of the first wildcard must also be wildcards.
    version: ?[]const u8 = null,

    /// The working directory for use during build and test workflows.
    working_directory: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .components = "components",
        .container_type = "containerType",
        .date_created = "dateCreated",
        .description = "description",
        .dockerfile_template_data = "dockerfileTemplateData",
        .encrypted = "encrypted",
        .instance_configuration = "instanceConfiguration",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .owner = "owner",
        .parent_image = "parentImage",
        .platform = "platform",
        .tags = "tags",
        .target_repository = "targetRepository",
        .version = "version",
        .working_directory = "workingDirectory",
    };
};
