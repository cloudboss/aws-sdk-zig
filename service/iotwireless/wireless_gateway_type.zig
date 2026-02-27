/// The wireless gateway type.
pub const WirelessGatewayType = enum {
    lo_ra_wan,

    pub const json_field_names = .{
        .lo_ra_wan = "LoRaWAN",
    };
};
