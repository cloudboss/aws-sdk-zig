const PricingRuleScope = @import("pricing_rule_scope.zig").PricingRuleScope;
const Tiering = @import("tiering.zig").Tiering;
const PricingRuleType = @import("pricing_rule_type.zig").PricingRuleType;

/// A representation of a pricing rule.
pub const PricingRuleListElement = struct {
    /// The Amazon Resource Name (ARN) used to uniquely identify a pricing rule.
    arn: ?[]const u8,

    /// The pricing plans count that this pricing rule is associated with.
    associated_pricing_plan_count: i64 = 0,

    /// The seller of services provided by Amazon Web Services, their affiliates, or
    /// third-party providers selling services via Amazon Web Services Marketplace.
    billing_entity: ?[]const u8,

    /// The time when the pricing rule was created.
    creation_time: i64 = 0,

    /// The pricing rule description.
    description: ?[]const u8,

    /// The most recent time when the pricing rule was modified.
    last_modified_time: i64 = 0,

    /// A percentage modifier applied on the public pricing rates.
    modifier_percentage: ?f64,

    /// The name of a pricing rule.
    name: ?[]const u8,

    /// Operation is the specific Amazon Web Services action covered by this line
    /// item. This describes the specific usage of the line item.
    ///
    /// If the `Scope` attribute is set to `SKU`, this attribute indicates which
    /// operation the `PricingRule` is modifying. For example, a value of
    /// `RunInstances:0202` indicates the operation of running an Amazon EC2
    /// instance.
    operation: ?[]const u8,

    /// The scope of pricing rule that indicates if it is globally applicable, or if
    /// it is service-specific.
    scope: ?PricingRuleScope,

    /// If the `Scope` attribute is `SERVICE`, this attribute indicates which
    /// service the `PricingRule` is applicable for.
    service: ?[]const u8,

    /// The set of tiering configurations for the pricing rule.
    tiering: ?Tiering,

    /// The type of pricing rule.
    @"type": ?PricingRuleType,

    /// Usage type is the unit that each service uses to measure the usage of a
    /// specific type of resource.
    ///
    /// If the `Scope` attribute is set to `SKU`, this attribute indicates which
    /// usage type the `PricingRule` is modifying. For example,
    /// `USW2-BoxUsage:m2.2xlarge` describes an` M2 High Memory Double Extra Large`
    /// instance in the US West (Oregon) Region.
    usage_type: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .associated_pricing_plan_count = "AssociatedPricingPlanCount",
        .billing_entity = "BillingEntity",
        .creation_time = "CreationTime",
        .description = "Description",
        .last_modified_time = "LastModifiedTime",
        .modifier_percentage = "ModifierPercentage",
        .name = "Name",
        .operation = "Operation",
        .scope = "Scope",
        .service = "Service",
        .tiering = "Tiering",
        .@"type" = "Type",
        .usage_type = "UsageType",
    };
};
