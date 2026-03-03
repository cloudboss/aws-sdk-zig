const SelectedPillar = @import("selected_pillar.zig").SelectedPillar;

/// Selected questions in the workload.
pub const JiraSelectedQuestionConfiguration = struct {
    /// Selected pillars in the workload.
    selected_pillars: ?[]const SelectedPillar = null,

    pub const json_field_names = .{
        .selected_pillars = "SelectedPillars",
    };
};
