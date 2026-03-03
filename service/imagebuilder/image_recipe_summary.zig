const aws = @import("aws");

const Platform = @import("platform.zig").Platform;

/// A summary of an image recipe.
pub const ImageRecipeSummary = struct {
    /// The Amazon Resource Name (ARN) of the image recipe.
    arn: ?[]const u8 = null,

    /// The date on which this image recipe was created.
    date_created: ?[]const u8 = null,

    /// The name of the image recipe.
    name: ?[]const u8 = null,

    /// The owner of the image recipe.
    owner: ?[]const u8 = null,

    /// The base image of the image recipe.
    parent_image: ?[]const u8 = null,

    /// The platform of the image recipe.
    platform: ?Platform = null,

    /// The tags of the image recipe.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .date_created = "dateCreated",
        .name = "name",
        .owner = "owner",
        .parent_image = "parentImage",
        .platform = "platform",
        .tags = "tags",
    };
};
