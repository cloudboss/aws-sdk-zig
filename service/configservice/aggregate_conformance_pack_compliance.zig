const ConformancePackComplianceType = @import("conformance_pack_compliance_type.zig").ConformancePackComplianceType;

/// Provides the number of compliant and noncompliant rules within a conformance
/// pack.
/// Also provides the compliance status of the conformance pack and the total
/// rule count which includes compliant rules, noncompliant rules, and rules
/// that cannot be evaluated due to insufficient data.
///
/// A conformance pack is compliant if all of the rules in a conformance packs
/// are compliant. It is noncompliant if any of the rules are not compliant.
/// The compliance status of a conformance pack is INSUFFICIENT_DATA only if all
/// rules within a conformance pack cannot be evaluated due to insufficient
/// data.
/// If some of the rules in a conformance pack are compliant but the compliance
/// status of other rules in that same conformance pack is INSUFFICIENT_DATA,
/// the conformance pack shows compliant.
pub const AggregateConformancePackCompliance = struct {
    /// The compliance status of the conformance pack.
    compliance_type: ?ConformancePackComplianceType = null,

    /// The number of compliant Config Rules.
    compliant_rule_count: i32 = 0,

    /// The number of noncompliant Config Rules.
    non_compliant_rule_count: i32 = 0,

    /// Total number of compliant rules, noncompliant rules, and the rules that do
    /// not have any applicable resources to evaluate upon resulting in insufficient
    /// data.
    total_rule_count: i32 = 0,

    pub const json_field_names = .{
        .compliance_type = "ComplianceType",
        .compliant_rule_count = "CompliantRuleCount",
        .non_compliant_rule_count = "NonCompliantRuleCount",
        .total_rule_count = "TotalRuleCount",
    };
};
