/// Metadata for a processing job step.
pub const ProcessingJobStepMetadata = struct {
    /// The Amazon Resource Name (ARN) of the processing job.
    arn: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
