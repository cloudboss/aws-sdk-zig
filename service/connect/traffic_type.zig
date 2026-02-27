pub const TrafficType = enum {
    general,
    campaign,

    pub const json_field_names = .{
        .general = "GENERAL",
        .campaign = "CAMPAIGN",
    };
};
