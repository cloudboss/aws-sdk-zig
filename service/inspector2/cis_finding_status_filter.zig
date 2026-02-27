const CisFindingStatusComparison = @import("cis_finding_status_comparison.zig").CisFindingStatusComparison;
const CisFindingStatus = @import("cis_finding_status.zig").CisFindingStatus;

/// The CIS finding status filter.
pub const CisFindingStatusFilter = struct {
    /// The comparison value of the CIS finding status filter.
    comparison: CisFindingStatusComparison,

    /// The value of the CIS finding status filter.
    value: CisFindingStatus,

    pub const json_field_names = .{
        .comparison = "comparison",
        .value = "value",
    };
};
