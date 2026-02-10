const AnalysisComponent = @import("analysis_component.zig").AnalysisComponent;
const RuleGroupRuleOptionsPair = @import("rule_group_rule_options_pair.zig").RuleGroupRuleOptionsPair;
const RuleGroupTypePair = @import("rule_group_type_pair.zig").RuleGroupTypePair;
const RuleOption = @import("rule_option.zig").RuleOption;

/// Describes an additional detail for a path analysis. For more information,
/// see [Reachability Analyzer additional detail
/// codes](https://docs.aws.amazon.com/vpc/latest/reachability/additional-detail-codes.html).
pub const AdditionalDetail = struct {
    /// The additional detail code.
    additional_detail_type: ?[]const u8,

    /// The path component.
    component: ?AnalysisComponent,

    /// The load balancers.
    load_balancers: ?[]const AnalysisComponent,

    /// The rule options.
    rule_group_rule_options_pairs: ?[]const RuleGroupRuleOptionsPair,

    /// The rule group type.
    rule_group_type_pairs: ?[]const RuleGroupTypePair,

    /// The rule options.
    rule_options: ?[]const RuleOption,

    /// The name of the VPC endpoint service.
    service_name: ?[]const u8,

    /// The VPC endpoint service.
    vpc_endpoint_service: ?AnalysisComponent,
};
