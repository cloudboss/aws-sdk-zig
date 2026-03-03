/// Metadata for an AutoML job step.
pub const AutoMLJobStepMetadata = struct {
    /// The Amazon Resource Name (ARN) of the AutoML job.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
