const ApplicationConfig = @import("application_config.zig").ApplicationConfig;
const Positioning = @import("positioning.zig").Positioning;

/// Object for updating the FPorts information.
pub const UpdateFPorts = struct {
    /// LoRaWAN application, which can be used for geolocation by activating
    /// positioning.
    applications: ?[]const ApplicationConfig,

    /// Positioning FPorts for the ClockSync, Stream, and GNSS functions.
    positioning: ?Positioning,

    pub const json_field_names = .{
        .applications = "Applications",
        .positioning = "Positioning",
    };
};
