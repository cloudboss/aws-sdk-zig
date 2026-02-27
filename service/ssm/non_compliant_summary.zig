const SeveritySummary = @import("severity_summary.zig").SeveritySummary;

/// A summary of resources that aren't compliant. The summary is organized
/// according to resource
/// type.
pub const NonCompliantSummary = struct {
    /// The total number of compliance items that aren't compliant.
    non_compliant_count: i32 = 0,

    /// A summary of the non-compliance severity by compliance type
    severity_summary: ?SeveritySummary,

    pub const json_field_names = .{
        .non_compliant_count = "NonCompliantCount",
        .severity_summary = "SeveritySummary",
    };
};
