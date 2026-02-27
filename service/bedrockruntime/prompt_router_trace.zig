/// A prompt router trace.
pub const PromptRouterTrace = struct {
    /// The ID of the invoked model.
    invoked_model_id: ?[]const u8,

    pub const json_field_names = .{
        .invoked_model_id = "invokedModelId",
    };
};
