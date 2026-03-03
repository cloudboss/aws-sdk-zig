/// Metadata for Model steps.
pub const ModelStepMetadata = struct {
    /// The Amazon Resource Name (ARN) of the created model.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
