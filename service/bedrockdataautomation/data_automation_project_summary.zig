const DataAutomationProjectStage = @import("data_automation_project_stage.zig").DataAutomationProjectStage;
const DataAutomationProjectType = @import("data_automation_project_type.zig").DataAutomationProjectType;

/// Summary of a DataAutomationProject
pub const DataAutomationProjectSummary = struct {
    creation_time: i64,

    project_arn: []const u8,

    project_name: ?[]const u8,

    project_stage: ?DataAutomationProjectStage,

    project_type: ?DataAutomationProjectType,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .project_arn = "projectArn",
        .project_name = "projectName",
        .project_stage = "projectStage",
        .project_type = "projectType",
    };
};
