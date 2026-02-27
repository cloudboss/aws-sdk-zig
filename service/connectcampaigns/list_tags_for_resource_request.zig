/// ListTagsForResource
pub const ListTagsForResourceRequest = struct {
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
