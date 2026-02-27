/// The request information to remove a tag from a rescore
/// execution plan. A rescore execution plan is an
/// Amazon Kendra Intelligent Ranking resource used for
/// provisioning the `Rescore` API.
pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the rescore execution
    /// plan to remove the tag.
    resource_arn: []const u8,

    /// A list of tag keys to remove from the rescore execution
    /// plan. If a tag key does not exist on the resource, it is
    /// ignored.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
