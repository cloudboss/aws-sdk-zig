const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the
    /// [RepositoryAssociation](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_RepositoryAssociation.html) object. You can retrieve this ARN by calling [ListRepositoryAssociations](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_ListRepositoryAssociations.html).
    resource_arn: []const u8,

    /// An array of key-value pairs used to tag an associated repository. A tag is a
    /// custom attribute label with two parts:
    ///
    /// * A *tag key* (for example, `CostCenter`,
    /// `Environment`, `Project`, or `Secret`). Tag
    /// keys are case sensitive.
    ///
    /// * An optional field known as a *tag value* (for example,
    /// `111122223333`, `Production`, or a team name).
    /// Omitting the tag value is the same as using an empty string. Like tag keys,
    /// tag
    /// values are case sensitive.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "Tags",
    };
};
