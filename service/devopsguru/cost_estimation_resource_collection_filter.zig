const CloudFormationCostEstimationResourceCollectionFilter = @import("cloud_formation_cost_estimation_resource_collection_filter.zig").CloudFormationCostEstimationResourceCollectionFilter;
const TagCostEstimationResourceCollectionFilter = @import("tag_cost_estimation_resource_collection_filter.zig").TagCostEstimationResourceCollectionFilter;

/// Information about a filter used to specify which Amazon Web Services
/// resources are analyzed to
/// create a monthly DevOps Guru cost estimate. For more information,
/// see [Estimate your
/// Amazon DevOps Guru
/// costs](https://docs.aws.amazon.com/devops-guru/latest/userguide/cost-estimate.html) and
/// [Amazon DevOps Guru pricing](http://aws.amazon.com/devops-guru/pricing/).
pub const CostEstimationResourceCollectionFilter = struct {
    /// An object that specifies the CloudFormation stack that defines the Amazon
    /// Web Services resources
    /// used to create a monthly estimate for DevOps Guru.
    cloud_formation: ?CloudFormationCostEstimationResourceCollectionFilter,

    /// The Amazon Web Services tags used to filter the resource collection that is
    /// used for a cost
    /// estimate.
    ///
    /// Tags help you identify and organize your Amazon Web Services resources. Many
    /// Amazon Web Services services support
    /// tagging, so you can assign the same tag to resources from different services
    /// to indicate
    /// that the resources are related. For example, you can assign the same tag to
    /// an Amazon DynamoDB
    /// table resource that you assign to an Lambda function. For more information
    /// about
    /// using tags, see the [Tagging
    /// best
    /// practices](https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/tagging-best-practices.html) whitepaper.
    ///
    /// Each Amazon Web Services tag has two parts.
    ///
    /// * A tag *key* (for example, `CostCenter`,
    /// `Environment`, `Project`, or `Secret`). Tag
    /// *keys* are case-sensitive.
    ///
    /// * An optional field known as a tag *value* (for example,
    /// `111122223333`, `Production`, or a team
    /// name). Omitting the tag *value* is the same as using an empty
    /// string. Like tag *keys*, tag *values* are
    /// case-sensitive.
    ///
    /// Together these are known as *key*-*value* pairs.
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
    tags: ?[]const TagCostEstimationResourceCollectionFilter,

    pub const json_field_names = .{
        .cloud_formation = "CloudFormation",
        .tags = "Tags",
    };
};
