const BuildType = @import("build_type.zig").BuildType;
const ImageSource = @import("image_source.zig").ImageSource;
const Platform = @import("platform.zig").Platform;
const ImageType = @import("image_type.zig").ImageType;

/// The defining characteristics of a specific version of an Image Builder
/// image.
pub const ImageVersion = struct {
    /// The Amazon Resource Name (ARN) of a specific version of an Image Builder
    /// image.
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
    arn: ?[]const u8,

    /// Indicates the type of build that created this image. The build can be
    /// initiated in the
    /// following ways:
    ///
    /// * **USER_INITIATED** – A manual
    /// pipeline build request.
    ///
    /// * **SCHEDULED** – A pipeline build
    /// initiated by a cron expression in the Image Builder pipeline, or from
    /// EventBridge.
    ///
    /// * **IMPORT** – A VM import created
    /// the image to use as the base image for the recipe.
    ///
    /// * **IMPORT_ISO** – An ISO disk import created
    /// the image.
    build_type: ?BuildType,

    /// The date on which this specific version of the Image Builder image was
    /// created.
    date_created: ?[]const u8,

    /// The origin of the base image that Image Builder used to build this image.
    image_source: ?ImageSource,

    /// The name of this specific version of an Image Builder image.
    name: ?[]const u8,

    /// The operating system version of the Amazon EC2 build instance. For example,
    /// Amazon Linux 2,
    /// Ubuntu 18, or Microsoft Windows Server 2019.
    os_version: ?[]const u8,

    /// The owner of the image version.
    owner: ?[]const u8,

    /// The operating system platform of the image version, for example "Windows" or
    /// "Linux".
    platform: ?Platform,

    /// Specifies whether this image produces an AMI or a container image.
    @"type": ?ImageType,

    /// Details for a specific version of an Image Builder image. This version
    /// follows the semantic
    /// version syntax.
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
    version: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .build_type = "buildType",
        .date_created = "dateCreated",
        .image_source = "imageSource",
        .name = "name",
        .os_version = "osVersion",
        .owner = "owner",
        .platform = "platform",
        .@"type" = "type",
        .version = "version",
    };
};
