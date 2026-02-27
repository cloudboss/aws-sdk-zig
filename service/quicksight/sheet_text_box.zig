const TextBoxInteractionOptions = @import("text_box_interaction_options.zig").TextBoxInteractionOptions;

/// A text box.
pub const SheetTextBox = struct {
    /// The content that is displayed in the text box.
    content: ?[]const u8,

    /// The general textbox interactions setup for a textbox.
    interactions: ?TextBoxInteractionOptions,

    /// The unique identifier for a text box. This identifier must be unique within
    /// the context of a dashboard, template, or analysis. Two dashboards, analyses,
    /// or templates can have text boxes that share identifiers.
    sheet_text_box_id: []const u8,

    pub const json_field_names = .{
        .content = "Content",
        .interactions = "Interactions",
        .sheet_text_box_id = "SheetTextBoxId",
    };
};
