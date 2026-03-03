/// Contains information about a model.
pub const InferenceProfileModel = struct {
    /// The Amazon Resource Name (ARN) of the model.
    model_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_arn = "modelArn",
    };
};
