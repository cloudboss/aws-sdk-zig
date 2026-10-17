/// The configuration for the base model used in a training session.
pub const TrainingSessionModelConfig = struct {
    /// Specifies whether you accept the end-user license agreement (EULA) for gated
    /// models.
    accept_eula: ?bool = null,

    /// The Amazon Resource Name (ARN) of the base foundation model from SageMaker
    /// Hub.
    base_model_arn: []const u8,

    pub const json_field_names = .{
        .accept_eula = "AcceptEula",
        .base_model_arn = "BaseModelArn",
    };
};
