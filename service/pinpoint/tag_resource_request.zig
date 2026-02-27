const TagsModel = @import("tags_model.zig").TagsModel;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: []const u8,

    tags_model: TagsModel,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags_model = "TagsModel",
    };
};
