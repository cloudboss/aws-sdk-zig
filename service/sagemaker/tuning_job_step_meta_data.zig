/// Metadata for a tuning step.
pub const TuningJobStepMetaData = struct {
    /// The Amazon Resource Name (ARN) of the tuning job that was run by this step
    /// execution.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
