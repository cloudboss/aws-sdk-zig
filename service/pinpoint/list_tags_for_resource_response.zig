const TagsModel = @import("tags_model.zig").TagsModel;

pub const ListTagsForResourceResponse = struct {
    tags_model: TagsModel,

    pub const json_field_names = .{
        .tags_model = "TagsModel",
    };
};
