pub const VoiceConnectorAwsRegion = enum {
    us_east_1,
    us_west_2,
    ca_central_1,
    eu_central_1,
    eu_west_1,
    eu_west_2,
    ap_northeast_2,
    ap_northeast_1,
    ap_southeast_1,
    ap_southeast_2,

    pub const json_field_names = .{
        .us_east_1 = "US_EAST_1",
        .us_west_2 = "US_WEST_2",
        .ca_central_1 = "CA_CENTRAL_1",
        .eu_central_1 = "EU_CENTRAL_1",
        .eu_west_1 = "EU_WEST_1",
        .eu_west_2 = "EU_WEST_2",
        .ap_northeast_2 = "AP_NORTHEAST_2",
        .ap_northeast_1 = "AP_NORTHEAST_1",
        .ap_southeast_1 = "AP_SOUTHEAST_1",
        .ap_southeast_2 = "AP_SOUTHEAST_2",
    };
};
