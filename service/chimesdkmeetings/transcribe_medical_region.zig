pub const TranscribeMedicalRegion = enum {
    us_east_1,
    us_east_2,
    us_west_2,
    ap_southeast_2,
    ca_central_1,
    eu_west_1,
    auto,

    pub const json_field_names = .{
        .us_east_1 = "US_EAST_1",
        .us_east_2 = "US_EAST_2",
        .us_west_2 = "US_WEST_2",
        .ap_southeast_2 = "AP_SOUTHEAST_2",
        .ca_central_1 = "CA_CENTRAL_1",
        .eu_west_1 = "EU_WEST_1",
        .auto = "AUTO",
    };
};
