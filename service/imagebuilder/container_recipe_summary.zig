const aws = @import("aws");

const ContainerType = @import("container_type.zig").ContainerType;
const Platform = @import("platform.zig").Platform;

/// A summary of a container recipe
pub const ContainerRecipeSummary = struct {
    /// The Amazon Resource Name (ARN) of the container recipe.
    arn: ?[]const u8,

    /// Specifies the type of container, such as "Docker".
    container_type: ?ContainerType,

    /// The date when this container recipe was created.
    date_created: ?[]const u8,

    /// The base image for a container build and test instance. This can contain an
    /// AMI ID
    /// or it can specify an Amazon Web Services Systems Manager (SSM) Parameter
    /// Store Parameter, prefixed by `ssm:`,
    /// followed by the parameter name or ARN.
    ///
    /// If not specified, Image Builder uses the appropriate ECS-optimized AMI as a
    /// base image.
    instance_image: ?[]const u8,

    /// The name of the container recipe.
    name: ?[]const u8,

    /// The owner of the container recipe.
    owner: ?[]const u8,

    /// The base image for the container recipe.
    parent_image: ?[]const u8,

    /// The system platform for the container, such as Windows or Linux.
    platform: ?Platform,

    /// Tags that are attached to the container recipe.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "arn",
        .container_type = "containerType",
        .date_created = "dateCreated",
        .instance_image = "instanceImage",
        .name = "name",
        .owner = "owner",
        .parent_image = "parentImage",
        .platform = "platform",
        .tags = "tags",
    };
};
