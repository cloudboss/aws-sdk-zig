const CisResultStatusComparison = @import("cis_result_status_comparison.zig").CisResultStatusComparison;
const CisResultStatus = @import("cis_result_status.zig").CisResultStatus;

/// The CIS result status filter.
pub const CisResultStatusFilter = struct {
    /// The comparison value of the CIS result status filter.
    comparison: CisResultStatusComparison,

    /// The value of the CIS result status filter.
    value: CisResultStatus,

    pub const json_field_names = .{
        .comparison = "comparison",
        .value = "value",
    };
};
