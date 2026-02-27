pub const FrequencyUnits = enum {
    ghz,
    mhz,
    khz,

    pub const json_field_names = .{
        .ghz = "GHZ",
        .mhz = "MHZ",
        .khz = "KHZ",
    };
};
