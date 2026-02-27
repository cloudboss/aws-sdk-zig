const WorkloadSummary = @import("workload_summary.zig").WorkloadSummary;

/// A milestone summary return object.
pub const MilestoneSummary = struct {
    milestone_name: ?[]const u8,

    milestone_number: ?i32,

    recorded_at: ?i64,

    workload_summary: ?WorkloadSummary,

    pub const json_field_names = .{
        .milestone_name = "MilestoneName",
        .milestone_number = "MilestoneNumber",
        .recorded_at = "RecordedAt",
        .workload_summary = "WorkloadSummary",
    };
};
