const SidewalkPositioning = @import("sidewalk_positioning.zig").SidewalkPositioning;

/// Sidewalk object for creating a wireless device.
pub const SidewalkCreateWirelessDevice = struct {
    /// The ID of the Sidewalk device profile.
    device_profile_id: ?[]const u8,

    /// The Positioning object of the Sidewalk device.
    positioning: ?SidewalkPositioning,

    /// The Sidewalk manufacturing serial number.
    sidewalk_manufacturing_sn: ?[]const u8,

    pub const json_field_names = .{
        .device_profile_id = "DeviceProfileId",
        .positioning = "Positioning",
        .sidewalk_manufacturing_sn = "SidewalkManufacturingSn",
    };
};
