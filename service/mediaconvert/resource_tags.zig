const aws = @import("aws");

/// The Amazon Resource Name (ARN) and tags for an AWS Elemental MediaConvert
/// resource.
pub const ResourceTags = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: ?[]const u8 = null,

    /// The tags for the resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .tags = "Tags",
    };
};
