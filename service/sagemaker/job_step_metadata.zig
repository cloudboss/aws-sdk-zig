/// Metadata for a SageMaker job step.
pub const JobStepMetadata = struct {
    /// The Amazon Resource Name (ARN) of the SageMaker job that was run by this
    /// step execution.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
