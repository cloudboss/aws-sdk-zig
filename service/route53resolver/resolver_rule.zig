const RuleTypeOption = @import("rule_type_option.zig").RuleTypeOption;
const ShareStatus = @import("share_status.zig").ShareStatus;
const ResolverRuleStatus = @import("resolver_rule_status.zig").ResolverRuleStatus;
const TargetAddress = @import("target_address.zig").TargetAddress;

/// For queries that originate in your VPC, detailed information about a
/// Resolver rule, which specifies how to route DNS queries
/// out of the VPC. The `ResolverRule` parameter appears in the response to a
/// [CreateResolverRule](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_CreateResolverRule.html),
/// [DeleteResolverRule](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_DeleteResolverRule.html),
/// [GetResolverRule](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_GetResolverRule.html),
/// [ListResolverRules](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_ListResolverRules.html),
/// or
/// [UpdateResolverRule](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_UpdateResolverRule.html) request.
pub const ResolverRule = struct {
    /// The ARN (Amazon Resource Name) for the Resolver rule specified by `Id`.
    arn: ?[]const u8 = null,

    /// The date and time that the Resolver rule was created, in Unix time format
    /// and Coordinated Universal Time (UTC).
    creation_time: ?[]const u8 = null,

    /// A unique string that you specified when you created the Resolver rule.
    /// `CreatorRequestId` identifies the request and allows failed requests to
    /// be retried without the risk of running the operation twice.
    creator_request_id: ?[]const u8 = null,

    /// DNS queries with delegation records that point to this domain name are
    /// forwarded to resolvers on your network.
    delegation_record: ?[]const u8 = null,

    /// DNS queries for this domain name are forwarded to the IP addresses that are
    /// specified in `TargetIps`. If a query matches
    /// multiple Resolver rules (example.com and www.example.com), the query is
    /// routed using the Resolver rule that contains the most specific domain name
    /// (www.example.com).
    domain_name: ?[]const u8 = null,

    /// The ID that Resolver assigned to the Resolver rule when you created it.
    id: ?[]const u8 = null,

    /// The date and time that the Resolver rule was last updated, in Unix time
    /// format and Coordinated Universal Time (UTC).
    modification_time: ?[]const u8 = null,

    /// The name for the Resolver rule, which you specified when you created the
    /// Resolver rule.
    ///
    /// The name can be up to 64 characters long and can contain letters (a-z, A-Z),
    /// numbers (0-9), hyphens (-), underscores (_), and spaces. The name cannot
    /// consist of only numbers.
    name: ?[]const u8 = null,

    /// When a rule is shared with another Amazon Web Services account, the account
    /// ID of the account that the rule is shared with.
    owner_id: ?[]const u8 = null,

    /// The ID of the endpoint that the rule is associated with.
    resolver_endpoint_id: ?[]const u8 = null,

    /// When you want to forward DNS queries for specified domain name to resolvers
    /// on your network, specify `FORWARD` or `DELEGATE`.
    /// If a query matches multiple Resolver rules (example.com and
    /// www.example.com), outbound DNS queries are routed using the Resolver rule
    /// that contains
    /// the most specific domain name (www.example.com).
    ///
    /// When you have a forwarding rule to forward DNS queries for a domain to your
    /// network and you want Resolver to process queries for
    /// a subdomain of that domain, specify `SYSTEM`.
    ///
    /// For example, to forward DNS queries for example.com to resolvers on your
    /// network, you create a rule and specify `FORWARD`
    /// for `RuleType`. To then have Resolver process queries for apex.example.com,
    /// you create a rule and specify
    /// `SYSTEM` for `RuleType`.
    ///
    /// Currently, only Resolver can create rules that have a value of `RECURSIVE`
    /// for `RuleType`.
    rule_type: ?RuleTypeOption = null,

    /// Whether the rule is shared and, if so, whether the current account is
    /// sharing the rule with
    /// another account, or another account is sharing the rule with the current
    /// account.
    share_status: ?ShareStatus = null,

    /// A code that specifies the current status of the Resolver rule.
    status: ?ResolverRuleStatus = null,

    /// A detailed description of the status of a Resolver rule.
    status_message: ?[]const u8 = null,

    /// An array that contains the IP addresses and ports that an outbound endpoint
    /// forwards DNS queries to. Typically,
    /// these are the IP addresses of DNS resolvers on your network.
    target_ips: ?[]const TargetAddress = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .creator_request_id = "CreatorRequestId",
        .delegation_record = "DelegationRecord",
        .domain_name = "DomainName",
        .id = "Id",
        .modification_time = "ModificationTime",
        .name = "Name",
        .owner_id = "OwnerId",
        .resolver_endpoint_id = "ResolverEndpointId",
        .rule_type = "RuleType",
        .share_status = "ShareStatus",
        .status = "Status",
        .status_message = "StatusMessage",
        .target_ips = "TargetIps",
    };
};
