/// Provides summary information about a model.
pub const ModelSummary = struct {
    /// A timestamp that indicates when the model was created.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the model.
    model_arn: []const u8,

    /// The name of the model that you want a summary for.
    model_name: []const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .model_arn = "ModelArn",
        .model_name = "ModelName",
    };
};
