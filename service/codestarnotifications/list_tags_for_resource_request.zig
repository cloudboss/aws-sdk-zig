pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) for the notification rule.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
