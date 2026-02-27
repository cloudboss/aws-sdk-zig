const DataAutomationStage = @import("data_automation_stage.zig").DataAutomationStage;

/// Data automation configuration.
pub const DataAutomationConfiguration = struct {
    /// Data automation project arn.
    data_automation_project_arn: []const u8,

    /// Data automation stage.
    stage: ?DataAutomationStage,

    pub const json_field_names = .{
        .data_automation_project_arn = "dataAutomationProjectArn",
        .stage = "stage",
    };
};
