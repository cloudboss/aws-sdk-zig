const ConformancePackComplianceType = @import("conformance_pack_compliance_type.zig").ConformancePackComplianceType;

/// Filters the conformance packs based on an account ID, region, compliance
/// type, and the name of the conformance pack.
pub const AggregateConformancePackComplianceFilters = struct {
    /// The 12-digit Amazon Web Services account ID of the source account.
    account_id: ?[]const u8 = null,

    /// The source Amazon Web Services Region from where the data is aggregated.
    aws_region: ?[]const u8 = null,

    /// The compliance status of the conformance pack.
    compliance_type: ?ConformancePackComplianceType = null,

    /// The name of the conformance pack.
    conformance_pack_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .aws_region = "AwsRegion",
        .compliance_type = "ComplianceType",
        .conformance_pack_name = "ConformancePackName",
    };
};
