const CardType = @import("card_type.zig").CardType;

/// The input shape for defining a text input card in an Amazon Q App.
pub const TextInputCardInput = struct {
    /// The default value to pre-populate in the text input field.
    default_value: ?[]const u8,

    /// The unique identifier of the text input card.
    id: []const u8,

    /// The placeholder text to display in the text input field.
    placeholder: ?[]const u8,

    /// The title or label of the text input card.
    title: []const u8,

    /// The type of the card.
    @"type": CardType = "text-input",

    pub const json_field_names = .{
        .default_value = "defaultValue",
        .id = "id",
        .placeholder = "placeholder",
        .title = "title",
        .@"type" = "type",
    };
};
