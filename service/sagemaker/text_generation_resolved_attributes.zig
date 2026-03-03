/// The resolved attributes specific to the text generation problem type.
pub const TextGenerationResolvedAttributes = struct {
    /// The name of the base model to fine-tune.
    base_model_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .base_model_name = "BaseModelName",
    };
};
