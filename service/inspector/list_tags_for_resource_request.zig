pub const ListTagsForResourceRequest = struct {
    /// The ARN that specifies the assessment template whose tags you want to list.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
