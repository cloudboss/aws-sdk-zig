const MotionGraphicsInsertion = @import("motion_graphics_insertion.zig").MotionGraphicsInsertion;
const MotionGraphicsSettings = @import("motion_graphics_settings.zig").MotionGraphicsSettings;

/// Motion Graphics Configuration
pub const MotionGraphicsConfiguration = struct {
    motion_graphics_insertion: ?MotionGraphicsInsertion,

    /// Motion Graphics Settings
    motion_graphics_settings: MotionGraphicsSettings,

    pub const json_field_names = .{
        .motion_graphics_insertion = "MotionGraphicsInsertion",
        .motion_graphics_settings = "MotionGraphicsSettings",
    };
};
