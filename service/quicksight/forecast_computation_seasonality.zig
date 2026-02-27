pub const ForecastComputationSeasonality = enum {
    automatic,
    custom,

    pub const json_field_names = .{
        .automatic = "AUTOMATIC",
        .custom = "CUSTOM",
    };
};
