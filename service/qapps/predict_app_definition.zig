const AppDefinitionInput = @import("app_definition_input.zig").AppDefinitionInput;

/// The definition of an Amazon Q App generated based on input such as a
/// conversation or problem statement.
pub const PredictAppDefinition = struct {
    /// The definition specifying the cards and flow of the generated Q App.
    app_definition: AppDefinitionInput,

    /// The description of the generated Q App definition.
    description: ?[]const u8,

    /// The title of the generated Q App definition.
    title: []const u8,

    pub const json_field_names = .{
        .app_definition = "appDefinition",
        .description = "description",
        .title = "title",
    };
};
