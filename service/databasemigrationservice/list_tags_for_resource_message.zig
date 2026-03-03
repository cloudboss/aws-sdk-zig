pub const ListTagsForResourceMessage = struct {
    /// The Amazon Resource Name (ARN) string that uniquely identifies the DMS
    /// resource to
    /// list tags for. This returns a list of keys (names of tags) created for the
    /// resource and
    /// their associated tag values.
    resource_arn: ?[]const u8 = null,

    /// List of ARNs that identify multiple DMS resources that you want to list tags
    /// for. This
    /// returns a list of keys (tag names) and their associated tag values. It also
    /// returns each
    /// tag's associated `ResourceArn` value, which is the ARN of the resource for
    /// which
    /// each listed tag is created.
    resource_arn_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .resource_arn_list = "ResourceArnList",
    };
};
