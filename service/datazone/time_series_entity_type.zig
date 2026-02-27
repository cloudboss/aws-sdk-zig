pub const TimeSeriesEntityType = enum {
    asset,
    listing,

    pub const json_field_names = .{
        .asset = "ASSET",
        .listing = "LISTING",
    };
};
