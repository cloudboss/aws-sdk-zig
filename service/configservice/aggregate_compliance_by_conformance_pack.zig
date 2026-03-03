const AggregateConformancePackCompliance = @import("aggregate_conformance_pack_compliance.zig").AggregateConformancePackCompliance;

/// Provides aggregate compliance of the conformance pack. Indicates whether a
/// conformance pack is compliant based on the name of the conformance pack,
/// account ID, and region.
///
/// A conformance pack is compliant if all of the rules in a conformance packs
/// are compliant. It is noncompliant if any of the rules are not compliant.
/// The compliance status of a conformance pack is INSUFFICIENT_DATA only if all
/// rules within a conformance pack cannot be evaluated due to insufficient
/// data.
/// If some of the rules in a conformance pack are compliant but the compliance
/// status of other rules in that same conformance pack is INSUFFICIENT_DATA,
/// the conformance pack shows
/// compliant.
pub const AggregateComplianceByConformancePack = struct {
    /// The 12-digit Amazon Web Services account ID of the source account.
    account_id: ?[]const u8 = null,

    /// The source Amazon Web Services Region from where the data is aggregated.
    aws_region: ?[]const u8 = null,

    /// The compliance status of the conformance pack.
    compliance: ?AggregateConformancePackCompliance = null,

    /// The name of the conformance pack.
    conformance_pack_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .aws_region = "AwsRegion",
        .compliance = "Compliance",
        .conformance_pack_name = "ConformancePackName",
    };
};
