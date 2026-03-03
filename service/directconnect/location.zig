/// Information about an Direct Connect location.
pub const Location = struct {
    /// The available MAC Security (MACsec) port speeds for the location.
    available_mac_sec_port_speeds: ?[]const []const u8 = null,

    /// The available port speeds for the location.
    available_port_speeds: ?[]const []const u8 = null,

    /// The name of the service provider for the location.
    available_providers: ?[]const []const u8 = null,

    /// The code for the location.
    location_code: ?[]const u8 = null,

    /// The name of the location. This includes the name of the colocation partner
    /// and the physical site of the building.
    location_name: ?[]const u8 = null,

    /// The Amazon Web Services Region for the location.
    region: ?[]const u8 = null,

    pub const json_field_names = .{
        .available_mac_sec_port_speeds = "availableMacSecPortSpeeds",
        .available_port_speeds = "availablePortSpeeds",
        .available_providers = "availableProviders",
        .location_code = "locationCode",
        .location_name = "locationName",
        .region = "region",
    };
};
