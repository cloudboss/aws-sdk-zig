/// Information about a collection of Amazon Web Services resources that are
/// identified by an Amazon Web Services tag.
/// This collection of resources is used to create a monthly cost estimate for
/// DevOps Guru to
/// analyze Amazon Web Services resources. The maximum number of tags you can
/// specify for a cost estimate
/// is one. The estimate created is for the cost to analyze the Amazon Web
/// Services resources defined by
/// the tag. For more information, see
/// [Stacks](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacks.html) in the
/// *Amazon Web Services CloudFormation User Guide*.
pub const TagCostEstimationResourceCollectionFilter = struct {
    /// An Amazon Web Services tag *key* that is used to identify the Amazon Web
    /// Services resources that
    /// DevOps Guru analyzes. All Amazon Web Services resources in your account and
    /// Region tagged with this *key* make
    /// up your DevOps Guru application and analysis boundary.
    ///
    /// The string used for a *key* in a tag that you use to define your resource
    /// coverage must begin with the
    /// prefix `Devops-guru-`. The tag *key* might be
    /// `DevOps-Guru-deployment-application` or
    /// `devops-guru-rds-application`. When you create a *key*, the case of
    /// characters in the *key* can be whatever you choose. After you create a
    /// *key*, it is case-sensitive.
    /// For example, DevOps Guru works with a
    /// *key* named `devops-guru-rds` and a *key* named
    /// `DevOps-Guru-RDS`, and these act as two different *keys*. Possible
    /// *key*/*value* pairs in your
    /// application might be `Devops-Guru-production-application/RDS` or
    /// `Devops-Guru-production-application/containers`.
    app_boundary_key: []const u8,

    /// The values in an Amazon Web Services tag collection.
    ///
    /// The tag's *value* is an optional field used to associate a string with
    /// the tag *key* (for example, `111122223333`, `Production`, or a team
    /// name). The *key* and *value* are the tag's *key* pair.
    /// Omitting the tag *value* is the same as using an empty
    /// string. Like tag *keys*, tag *values* are
    /// case-sensitive. You can specify a maximum of 256 characters for a tag value.
    tag_values: []const []const u8,

    pub const json_field_names = .{
        .app_boundary_key = "AppBoundaryKey",
        .tag_values = "TagValues",
    };
};
