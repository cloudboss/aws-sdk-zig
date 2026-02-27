/// Retrieves a list of tags applied to the specified resource.
pub const ListTagsForResourceRequest = struct {
    /// The ARN of the resource to retrieve tags from.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
