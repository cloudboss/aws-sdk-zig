/// The request information for listing tags associated with
/// a rescore execution plan. A rescore execution plan is an
/// Amazon Kendra Intelligent Ranking resource used for
/// provisioning the `Rescore` API.
pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the rescore execution
    /// plan to get a list of tags for.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
    };
};
