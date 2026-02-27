const CisTargetStatusComparison = @import("cis_target_status_comparison.zig").CisTargetStatusComparison;
const CisTargetStatusReason = @import("cis_target_status_reason.zig").CisTargetStatusReason;

/// The CIS target status reason filter.
pub const CisTargetStatusReasonFilter = struct {
    /// The comparison value of the CIS target status reason filter.
    comparison: CisTargetStatusComparison,

    /// The value of the CIS target status reason filter.
    value: CisTargetStatusReason,

    pub const json_field_names = .{
        .comparison = "comparison",
        .value = "value",
    };
};
