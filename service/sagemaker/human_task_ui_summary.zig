/// Container for human task user interface information.
pub const HumanTaskUiSummary = struct {
    /// A timestamp when SageMaker created the human task user interface.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the human task user interface.
    human_task_ui_arn: []const u8,

    /// The name of the human task user interface.
    human_task_ui_name: []const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .human_task_ui_arn = "HumanTaskUiArn",
        .human_task_ui_name = "HumanTaskUiName",
    };
};
