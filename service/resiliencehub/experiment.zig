/// Indicates the FIS experiment detected while running an assessment.
pub const Experiment = struct {
    /// Amazon Resource Name (ARN) of the FIS experiment.
    experiment_arn: ?[]const u8,

    /// Identifier of the FIS experiment template.
    experiment_template_id: ?[]const u8,

    pub const json_field_names = .{
        .experiment_arn = "experimentArn",
        .experiment_template_id = "experimentTemplateId",
    };
};
