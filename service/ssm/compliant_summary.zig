const SeveritySummary = @import("severity_summary.zig").SeveritySummary;

/// A summary of resources that are compliant. The summary is organized
/// according to the
/// resource count for each compliance type.
pub const CompliantSummary = struct {
    /// The total number of resources that are compliant.
    compliant_count: i32 = 0,

    /// A summary of the compliance severity by compliance type.
    severity_summary: ?SeveritySummary = null,

    pub const json_field_names = .{
        .compliant_count = "CompliantCount",
        .severity_summary = "SeveritySummary",
    };
};
