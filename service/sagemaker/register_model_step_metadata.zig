/// Metadata for a register model job step.
pub const RegisterModelStepMetadata = struct {
    /// The Amazon Resource Name (ARN) of the model package.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
