pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource that you want to remove one
    /// or more
    /// tags from.
    resource_arn: []const u8,

    /// The tags (tag keys) that you want to remove from the resource. When you
    /// specify a tag
    /// key, the action removes both that key and its associated tag value.
    ///
    /// To remove more than one tag from the resource, append the `TagKeys`
    /// parameter and argument for each additional tag to remove, separated by an
    /// ampersand. For
    /// example:
    /// `/v1/email/tags?ResourceArn=ResourceArn&TagKeys=Key1&TagKeys=Key2`
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
