const ComplianceSummary = @import("compliance_summary.zig").ComplianceSummary;

/// The number of Amazon Web Services resources of a specific type that are
/// compliant or noncompliant, up to a maximum of 100 for
/// each.
pub const ComplianceSummaryByResourceType = struct {
    /// The number of Amazon Web Services resources that are compliant or
    /// noncompliant,
    /// up to a maximum of 100 for each.
    compliance_summary: ?ComplianceSummary = null,

    /// The type of Amazon Web Services resource.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .compliance_summary = "ComplianceSummary",
        .resource_type = "ResourceType",
    };
};
