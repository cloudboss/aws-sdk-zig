const ResolverRuleAssociationStatus = @import("resolver_rule_association_status.zig").ResolverRuleAssociationStatus;

/// In the response to an
/// [AssociateResolverRule](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_AssociateResolverRule.html),
/// [DisassociateResolverRule](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_DisassociateResolverRule.html),
/// or
/// [ListResolverRuleAssociations](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_ListResolverRuleAssociations.html)
/// request, provides information about an association between a Resolver rule
/// and a VPC.
/// The association determines which DNS queries that originate in the VPC are
/// forwarded to your network.
pub const ResolverRuleAssociation = struct {
    /// The ID of the association between a Resolver rule and a VPC. Resolver
    /// assigns this value when you submit an
    /// [AssociateResolverRule](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_AssociateResolverRule.html)
    /// request.
    id: ?[]const u8 = null,

    /// The name of an association between a Resolver rule and a VPC.
    ///
    /// The name can be up to 64 characters long and can contain letters (a-z, A-Z),
    /// numbers (0-9), hyphens (-), underscores (_), and spaces. The name cannot
    /// consist of only numbers.
    name: ?[]const u8 = null,

    /// The ID of the Resolver rule that you associated with the VPC that is
    /// specified by `VPCId`.
    resolver_rule_id: ?[]const u8 = null,

    /// A code that specifies the current status of the association between a
    /// Resolver rule and a VPC.
    status: ?ResolverRuleAssociationStatus = null,

    /// A detailed description of the status of the association between a Resolver
    /// rule and a VPC.
    status_message: ?[]const u8 = null,

    /// The ID of the VPC that you associated the Resolver rule with.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
        .resolver_rule_id = "ResolverRuleId",
        .status = "Status",
        .status_message = "StatusMessage",
        .vpc_id = "VPCId",
    };
};
