const CardInput = @import("card_input.zig").CardInput;

/// The input for defining an Q App.
pub const AppDefinitionInput = struct {
    /// The cards that make up the Q App definition.
    cards: []const CardInput,

    /// The initial prompt displayed when the Q App is started.
    initial_prompt: ?[]const u8,

    pub const json_field_names = .{
        .cards = "cards",
        .initial_prompt = "initialPrompt",
    };
};
