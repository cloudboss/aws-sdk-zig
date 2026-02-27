/// Metadata for a transform job step.
pub const TransformJobStepMetadata = struct {
    /// The Amazon Resource Name (ARN) of the transform job that was run by this
    /// step execution.
    arn: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
