pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) for the resource that you want to remove tags
    /// from. To get the ARN for a resource, use the applicable
    /// `Get` or `List` command:
    ///
    /// *
    ///   [GetResolverEndpoint](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_GetResolverEndpoint.html)
    ///
    /// *
    ///   [GetResolverRule](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_GetResolverRule.html)
    ///
    /// *
    ///   [GetResolverRuleAssociation](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_GetResolverRuleAssociation.html)
    ///
    /// *
    ///   [ListResolverEndpoints](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_ListResolverEndpoints.html)
    ///
    /// *
    ///   [ListResolverRuleAssociations](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_ListResolverRuleAssociations.html)
    ///
    /// *
    ///   [ListResolverRules](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_ListResolverRules.html)
    resource_arn: []const u8,

    /// The tags that you want to remove to the specified resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
