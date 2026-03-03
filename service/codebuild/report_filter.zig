const ReportStatusType = @import("report_status_type.zig").ReportStatusType;

/// A filter used to return reports with the status specified by the input
/// `status` parameter.
pub const ReportFilter = struct {
    /// The status used to filter reports. You can filter using one status only.
    status: ?ReportStatusType = null,

    pub const json_field_names = .{
        .status = "status",
    };
};
