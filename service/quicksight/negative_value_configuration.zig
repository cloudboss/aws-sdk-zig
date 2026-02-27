const NegativeValueDisplayMode = @import("negative_value_display_mode.zig").NegativeValueDisplayMode;

/// The options that determine the negative value configuration.
pub const NegativeValueConfiguration = struct {
    /// Determines the display mode of the negative value configuration.
    display_mode: NegativeValueDisplayMode,

    pub const json_field_names = .{
        .display_mode = "DisplayMode",
    };
};
