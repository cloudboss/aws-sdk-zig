const WorkloadSummary = @import("workload_summary.zig").WorkloadSummary;

/// A milestone summary return object.
pub const MilestoneSummary = struct {
    milestone_name: ?[]const u8 = null,

    milestone_number: ?i32 = null,

    recorded_at: ?i64 = null,

    workload_summary: ?WorkloadSummary = null,

    pub const json_field_names = .{
        .milestone_name = "MilestoneName",
        .milestone_number = "MilestoneNumber",
        .recorded_at = "RecordedAt",
        .workload_summary = "WorkloadSummary",
    };
};
