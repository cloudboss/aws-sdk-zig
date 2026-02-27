pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the
    /// [RepositoryAssociation](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_RepositoryAssociation.html) object. You can retrieve this ARN by calling [ListRepositoryAssociations](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_ListRepositoryAssociations.html).
    resource_arn: []const u8,

    /// A list of the keys for each tag you want to remove from an associated
    /// repository.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tag_keys = "TagKeys",
    };
};
