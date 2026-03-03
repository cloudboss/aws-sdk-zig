const ContextMenuOption = @import("context_menu_option.zig").ContextMenuOption;
const VisualMenuOption = @import("visual_menu_option.zig").VisualMenuOption;

/// The general visual interactions setup for visual publish options
pub const VisualInteractionOptions = struct {
    /// The context menu options for a visual.
    context_menu_option: ?ContextMenuOption = null,

    /// The on-visual menu options for a visual.
    visual_menu_option: ?VisualMenuOption = null,

    pub const json_field_names = .{
        .context_menu_option = "ContextMenuOption",
        .visual_menu_option = "VisualMenuOption",
    };
};
