const Owner = @import("owner.zig").Owner;
const StepGroupStatus = @import("step_group_status.zig").StepGroupStatus;

/// The summary of a step group in a workflow.
pub const WorkflowStepGroupSummary = struct {
    /// The ID of the step group.
    id: ?[]const u8 = null,

    /// The name of the step group.
    name: ?[]const u8 = null,

    /// The next step group.
    next: ?[]const []const u8 = null,

    /// The owner of the step group.
    owner: ?Owner = null,

    /// The previous step group.
    previous: ?[]const []const u8 = null,

    /// The status of the step group.
    status: ?StepGroupStatus = null,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .next = "next",
        .owner = "owner",
        .previous = "previous",
        .status = "status",
    };
};
