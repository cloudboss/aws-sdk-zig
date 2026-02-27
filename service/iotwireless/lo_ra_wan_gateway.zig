const Beaconing = @import("beaconing.zig").Beaconing;

/// LoRaWANGateway object.
pub const LoRaWANGateway = struct {
    /// Beaconing object information, which consists of the data rate and frequency
    /// parameters.
    beaconing: ?Beaconing,

    /// The gateway's EUI value.
    gateway_eui: ?[]const u8,

    join_eui_filters: ?[]const []const []const u8,

    /// The MaxEIRP value.
    max_eirp: ?f32,

    net_id_filters: ?[]const []const u8,

    /// The frequency band (RFRegion) value.
    rf_region: ?[]const u8,

    sub_bands: ?[]const i32,

    pub const json_field_names = .{
        .beaconing = "Beaconing",
        .gateway_eui = "GatewayEui",
        .join_eui_filters = "JoinEuiFilters",
        .max_eirp = "MaxEirp",
        .net_id_filters = "NetIdFilters",
        .rf_region = "RfRegion",
        .sub_bands = "SubBands",
    };
};
