const AwsSsmComplianceSummary = @import("aws_ssm_compliance_summary.zig").AwsSsmComplianceSummary;

/// Provides details about the compliance for a patch.
pub const AwsSsmPatch = struct {
    /// The compliance status details for the patch.
    compliance_summary: ?AwsSsmComplianceSummary,

    pub const json_field_names = .{
        .compliance_summary = "ComplianceSummary",
    };
};
