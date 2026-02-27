const CisTargetStatusComparison = @import("cis_target_status_comparison.zig").CisTargetStatusComparison;
const CisTargetStatus = @import("cis_target_status.zig").CisTargetStatus;

/// The CIS target status filter.
pub const CisTargetStatusFilter = struct {
    /// The comparison value of the CIS target status filter.
    comparison: CisTargetStatusComparison,

    /// The value of the CIS target status filter.
    value: CisTargetStatus,

    pub const json_field_names = .{
        .comparison = "comparison",
        .value = "value",
    };
};
