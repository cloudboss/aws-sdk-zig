const Card = @import("card.zig").Card;

/// The definition of the Q App, specifying the cards and flow.
pub const AppDefinition = struct {
    /// The version of the app definition schema or specification.
    app_definition_version: []const u8,

    /// A flag indicating whether the Q App's definition can be edited by the user.
    can_edit: ?bool,

    /// The cards that make up the Q App, such as text input, file upload, or query
    /// cards.
    cards: []const Card,

    pub const json_field_names = .{
        .app_definition_version = "appDefinitionVersion",
        .can_edit = "canEdit",
        .cards = "cards",
    };
};
