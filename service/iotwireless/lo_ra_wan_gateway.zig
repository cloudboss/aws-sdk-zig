const Beaconing = @import("beaconing.zig").Beaconing;

/// LoRaWANGateway object.
pub const LoRaWANGateway = struct {
    /// Beaconing object information, which consists of the data rate and frequency
    /// parameters.
    beaconing: ?Beaconing = null,

    /// The gateway's EUI value.
    gateway_eui: ?[]const u8 = null,

    join_eui_filters: ?[]const []const []const u8 = null,

    /// The MaxEIRP value.
    max_eirp: ?f32 = null,

    net_id_filters: ?[]const []const u8 = null,

    /// The frequency band (RFRegion) value.
    rf_region: ?[]const u8 = null,

    sub_bands: ?[]const i32 = null,

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
