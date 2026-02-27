const CisScanStatusComparison = @import("cis_scan_status_comparison.zig").CisScanStatusComparison;
const CisScanStatus = @import("cis_scan_status.zig").CisScanStatus;

/// The CIS scan status filter.
pub const CisScanStatusFilter = struct {
    /// The filter comparison value.
    comparison: CisScanStatusComparison,

    /// The filter value.
    value: CisScanStatus,

    pub const json_field_names = .{
        .comparison = "comparison",
        .value = "value",
    };
};
