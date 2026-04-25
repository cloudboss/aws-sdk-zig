const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to add tags to. Currently,
    /// the supported resources are Amazon ECS capacity providers, tasks, services,
    /// task definitions, clusters, and container instances.
    ///
    /// In order to tag a service that has the following ARN format, you need to
    /// migrate the service to the long ARN. For more information, see [Migrate an
    /// Amazon ECS short service ARN to a long
    /// ARN](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-arn-migration.html) in the *Amazon Elastic Container Service Developer Guide*.
    ///
    /// `arn:aws:ecs:region:aws_account_id:service/service-name`
    ///
    /// After the migration is complete, the service has the long ARN format, as
    /// shown below. Use this ARN to tag the service.
    ///
    /// `arn:aws:ecs:region:aws_account_id:service/cluster-name/service-name`
    ///
    /// If you try to tag a service with a short ARN, you receive an
    /// `InvalidParameterException` error.
    resource_arn: []const u8,

    /// The tags to add to the resource. A tag is an array of key-value pairs.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only one value.
    /// * Maximum key length - 128 Unicode characters in UTF-8
    /// * Maximum value length - 256 Unicode characters in UTF-8
    /// * If your tagging schema is used across multiple services and resources,
    ///   remember that other services may have restrictions on allowed characters.
    ///   Generally allowed characters are: letters, numbers, and spaces
    ///   representable in UTF-8, and the following characters: + - = . _ : / @.
    /// * Tag keys and values are case-sensitive.
    /// * Do not use `aws:`, `AWS:`, or any upper or lowercase combination of such
    ///   as a prefix for either keys or values as it is reserved for Amazon Web
    ///   Services use. You cannot edit or delete tag keys or values with this
    ///   prefix. Tags with this prefix do not count against your tags per resource
    ///   limit.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
