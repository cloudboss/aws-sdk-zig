const ApplicationConfig = @import("application_config.zig").ApplicationConfig;
const Positioning = @import("positioning.zig").Positioning;

/// List of FPort assigned for different LoRaWAN application packages to use
pub const FPorts = struct {
    /// Optional LoRaWAN application information, which can be used for geolocation.
    applications: ?[]const ApplicationConfig,

    clock_sync: ?i32,

    fuota: ?i32,

    multicast: ?i32,

    /// FPort values for the GNSS, stream, and ClockSync functions of the
    /// positioning
    /// information.
    positioning: ?Positioning,

    pub const json_field_names = .{
        .applications = "Applications",
        .clock_sync = "ClockSync",
        .fuota = "Fuota",
        .multicast = "Multicast",
        .positioning = "Positioning",
    };
};
