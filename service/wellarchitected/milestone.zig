const Workload = @import("workload.zig").Workload;

/// A milestone return object.
pub const Milestone = struct {
    milestone_name: ?[]const u8,

    milestone_number: ?i32,

    recorded_at: ?i64,

    workload: ?Workload,

    pub const json_field_names = .{
        .milestone_name = "MilestoneName",
        .milestone_number = "MilestoneNumber",
        .recorded_at = "RecordedAt",
        .workload = "Workload",
    };
};
