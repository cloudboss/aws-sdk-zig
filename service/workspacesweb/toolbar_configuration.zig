const ToolbarItem = @import("toolbar_item.zig").ToolbarItem;
const MaxDisplayResolution = @import("max_display_resolution.zig").MaxDisplayResolution;
const ToolbarType = @import("toolbar_type.zig").ToolbarType;
const VisualMode = @import("visual_mode.zig").VisualMode;

/// The configuration of the toolbar. This allows administrators to select the
/// toolbar type and visual mode, set maximum display resolution for sessions,
/// and choose which items are visible to end users during their sessions. If
/// administrators do not modify these settings, end users retain control over
/// their toolbar preferences.
pub const ToolbarConfiguration = struct {
    /// The list of toolbar items to be hidden.
    hidden_toolbar_items: ?[]const ToolbarItem = null,

    /// The maximum display resolution that is allowed for the session.
    max_display_resolution: ?MaxDisplayResolution = null,

    /// The type of toolbar displayed during the session.
    toolbar_type: ?ToolbarType = null,

    /// The visual mode of the toolbar.
    visual_mode: ?VisualMode = null,

    pub const json_field_names = .{
        .hidden_toolbar_items = "hiddenToolbarItems",
        .max_display_resolution = "maxDisplayResolution",
        .toolbar_type = "toolbarType",
        .visual_mode = "visualMode",
    };
};
