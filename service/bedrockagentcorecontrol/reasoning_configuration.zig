/// The reasoning configuration that controls how a reasoning model allocates
/// effort during evaluation.
pub const ReasoningConfiguration = struct {
    /// The level of reasoning effort the model applies when generating a response.
    /// For supported values, see the model provider's documentation.
    effort: ?[]const u8 = null,

    pub const json_field_names = .{
        .effort = "effort",
    };
};
