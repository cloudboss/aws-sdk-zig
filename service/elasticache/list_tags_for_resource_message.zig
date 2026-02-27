/// The input parameters for the `ListTagsForResource` operation.
pub const ListTagsForResourceMessage = struct {
    /// The Amazon Resource Name (ARN) of the resource for which you want the list
    /// of tags,
    /// for example `arn:aws:elasticache:us-west-2:0123456789:cluster:myCluster` or
    /// `arn:aws:elasticache:us-west-2:0123456789:snapshot:mySnapshot`.
    ///
    /// For more information about ARNs, see [Amazon Resource Names (ARNs)
    /// and Amazon Web
    /// Services Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    resource_name: []const u8,
};
