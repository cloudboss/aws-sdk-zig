const aws = @import("aws");

const ComponentConfiguration = @import("component_configuration.zig").ComponentConfiguration;
const ContainerType = @import("container_type.zig").ContainerType;
const InstanceConfiguration = @import("instance_configuration.zig").InstanceConfiguration;
const Platform = @import("platform.zig").Platform;
const TargetContainerRepository = @import("target_container_repository.zig").TargetContainerRepository;

/// A container recipe.
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
    /// Recipes require a minimum of one build component, and can
    /// have a maximum of 20 build and test components in any combination.
    components: ?[]const ComponentConfiguration = null,

    /// Specifies the type of container, such as Docker.
    container_type: ?ContainerType = null,

    /// The date when this container recipe was created.
    date_created: ?[]const u8 = null,

    /// The description of the container recipe.
    description: ?[]const u8 = null,

    /// Dockerfiles are text documents that are used to build Docker containers, and
    /// ensure
    /// that they contain all of the elements required by the application running
    /// inside. The
    /// template data consists of contextual variables where Image Builder places
    /// build information or
    /// scripts, based on your container image recipe.
    dockerfile_template_data: ?[]const u8 = null,

    /// A flag that indicates if the target container is encrypted.
    encrypted: ?bool = null,

    /// A group of options that can be used to configure an instance for building
    /// and testing
    /// container images.
    instance_configuration: ?InstanceConfiguration = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies which KMS key is
    /// used to encrypt the container image
    /// for distribution to the target Region. This can be either the Key ARN or the
    /// Alias ARN. For more information, see [Key identifiers
    /// (KeyId)](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)
    /// in the *Key Management Service Developer Guide*.
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

    /// The system platform for the container, such as Windows or Linux.
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
    /// **Assignment:** For the first three nodes you can assign any positive
    /// integer value, including
    /// zero, with an upper limit of 2^30-1, or 1073741823 for each node. Image
    /// Builder automatically assigns the
    /// build number to the fourth node.
    ///
    /// **Patterns:** You can use any numeric pattern that adheres to the assignment
    /// requirements for
    /// the nodes that you can assign. For example, you might choose a software
    /// version pattern, such as 1.0.0, or
    /// a date, such as 2021.01.01.
    ///
    /// **Filtering:** With semantic versioning, you have the flexibility to use
    /// wildcards (x)
    /// to specify the most recent versions or nodes when selecting the base image
    /// or components for your
    /// recipe. When you use a wildcard in any node, all nodes to the right of the
    /// first wildcard must also be
    /// wildcards.
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
