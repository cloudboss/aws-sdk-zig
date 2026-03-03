const Workload = @import("workload.zig").Workload;

/// A milestone return object.
pub const Milestone = struct {
    milestone_name: ?[]const u8 = null,

    milestone_number: ?i32 = null,

    recorded_at: ?i64 = null,

    workload: ?Workload = null,

    pub const json_field_names = .{
        .milestone_name = "MilestoneName",
        .milestone_number = "MilestoneNumber",
        .recorded_at = "RecordedAt",
        .workload = "Workload",
    };
};
