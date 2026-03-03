/// The configuration of spacing (often a margin or padding).
pub const Spacing = struct {
    /// Define the bottom spacing.
    bottom: ?[]const u8 = null,

    /// Define the left spacing.
    left: ?[]const u8 = null,

    /// Define the right spacing.
    right: ?[]const u8 = null,

    /// Define the top spacing.
    top: ?[]const u8 = null,

    pub const json_field_names = .{
        .bottom = "Bottom",
        .left = "Left",
        .right = "Right",
        .top = "Top",
    };
};
