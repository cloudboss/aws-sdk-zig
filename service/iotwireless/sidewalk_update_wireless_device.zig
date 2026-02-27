const SidewalkPositioning = @import("sidewalk_positioning.zig").SidewalkPositioning;

/// Sidewalk object for updating a wireless device.
pub const SidewalkUpdateWirelessDevice = struct {
    /// The Positioning object of the Sidewalk device.
    positioning: ?SidewalkPositioning,

    pub const json_field_names = .{
        .positioning = "Positioning",
    };
};
