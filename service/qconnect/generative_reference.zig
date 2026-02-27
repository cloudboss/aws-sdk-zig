/// Reference information about generative content.
pub const GenerativeReference = struct {
    /// The identifier of the LLM model.
    generation_id: ?[]const u8,

    /// The identifier of the LLM model.
    model_id: ?[]const u8,

    pub const json_field_names = .{
        .generation_id = "generationId",
        .model_id = "modelId",
    };
};
