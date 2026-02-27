const WorkloadStatus = @import("workload_status.zig").WorkloadStatus;

/// Describes workload data.
pub const WorkloadDataSummary = struct {
    /// The display name of the workload data.
    display_name: ?[]const u8,

    /// The status of the workload.
    status: ?WorkloadStatus,

    /// The name of the workload.
    workload_name: ?[]const u8,

    pub const json_field_names = .{
        .display_name = "displayName",
        .status = "status",
        .workload_name = "workloadName",
    };
};
