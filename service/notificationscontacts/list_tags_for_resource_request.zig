pub const ListTagsForResourceRequest = struct {
    /// The ARN you specified to list the tags of.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
