const CardType = @import("card_type.zig").CardType;

/// A card in an Amazon Q App that allows the user to input text.
pub const TextInputCard = struct {
    /// The default value to pre-populate in the text input field.
    default_value: ?[]const u8 = null,

    /// Any dependencies or requirements for the text input card.
    dependencies: []const []const u8,

    /// The unique identifier of the text input card.
    id: []const u8,

    /// The placeholder text to display in the text input field.
    placeholder: ?[]const u8 = null,

    /// The title or label of the text input card.
    title: []const u8,

    /// The type of the card.
    @"type": CardType,

    pub const json_field_names = .{
        .default_value = "defaultValue",
        .dependencies = "dependencies",
        .id = "id",
        .placeholder = "placeholder",
        .title = "title",
        .@"type" = "type",
    };
};
