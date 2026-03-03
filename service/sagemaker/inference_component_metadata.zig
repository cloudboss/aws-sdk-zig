/// The metadata of the inference component.
pub const InferenceComponentMetadata = struct {
    /// The Amazon Resource Name (ARN) of the inference component.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
