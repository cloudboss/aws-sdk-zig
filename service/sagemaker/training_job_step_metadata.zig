/// Metadata for a training job step.
pub const TrainingJobStepMetadata = struct {
    /// The Amazon Resource Name (ARN) of the training job that was run by this step
    /// execution.
    arn: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
