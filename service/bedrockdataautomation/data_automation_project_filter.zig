const DataAutomationProjectStage = @import("data_automation_project_stage.zig").DataAutomationProjectStage;

/// Data Automation Project Filter
pub const DataAutomationProjectFilter = struct {
    project_arn: []const u8,

    project_stage: ?DataAutomationProjectStage = null,

    pub const json_field_names = .{
        .project_arn = "projectArn",
        .project_stage = "projectStage",
    };
};
