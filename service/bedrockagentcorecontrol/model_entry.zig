/// A model entry that specifies a model supported for an inference operation.
pub const ModelEntry = struct {
    /// The model ID or glob pattern that identifies the model (for example,
    /// `anthropic.claude-opus-*` or `openai.gpt-oss-*`).
    model: []const u8,

    pub const json_field_names = .{
        .model = "model",
    };
};
