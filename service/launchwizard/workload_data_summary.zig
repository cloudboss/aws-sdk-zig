const WorkloadStatus = @import("workload_status.zig").WorkloadStatus;

/// Describes workload data.
pub const WorkloadDataSummary = struct {
    /// The display name of the workload data.
    display_name: ?[]const u8 = null,

    /// The status of the workload.
    status: ?WorkloadStatus = null,

    /// The name of the workload.
    workload_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_name = "displayName",
        .status = "status",
        .workload_name = "workloadName",
    };
};
