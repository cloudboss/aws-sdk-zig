pub const ShipmentCarrier = enum {
    dhl,
    dbs,
    fedex,
    ups,
    expeditors,

    pub const json_field_names = .{
        .dhl = "DHL",
        .dbs = "DBS",
        .fedex = "FEDEX",
        .ups = "UPS",
        .expeditors = "EXPEDITORS",
    };
};
