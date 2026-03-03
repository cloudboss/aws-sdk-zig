const CompliantSummary = @import("compliant_summary.zig").CompliantSummary;
const NonCompliantSummary = @import("non_compliant_summary.zig").NonCompliantSummary;

/// A summary of compliance information by compliance type.
pub const ComplianceSummaryItem = struct {
    /// The type of compliance item. For example, the compliance type can be
    /// Association, Patch, or
    /// Custom:string.
    compliance_type: ?[]const u8 = null,

    /// A list of COMPLIANT items for the specified compliance type.
    compliant_summary: ?CompliantSummary = null,

    /// A list of NON_COMPLIANT items for the specified compliance type.
    non_compliant_summary: ?NonCompliantSummary = null,

    pub const json_field_names = .{
        .compliance_type = "ComplianceType",
        .compliant_summary = "CompliantSummary",
        .non_compliant_summary = "NonCompliantSummary",
    };
};
