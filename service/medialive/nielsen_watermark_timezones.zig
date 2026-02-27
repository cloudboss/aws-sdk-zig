/// Nielsen Watermark Timezones
pub const NielsenWatermarkTimezones = enum {
    america_puerto_rico,
    us_alaska,
    us_arizona,
    us_central,
    us_eastern,
    us_hawaii,
    us_mountain,
    us_pacific,
    us_samoa,
    utc,

    pub const json_field_names = .{
        .america_puerto_rico = "AMERICA_PUERTO_RICO",
        .us_alaska = "US_ALASKA",
        .us_arizona = "US_ARIZONA",
        .us_central = "US_CENTRAL",
        .us_eastern = "US_EASTERN",
        .us_hawaii = "US_HAWAII",
        .us_mountain = "US_MOUNTAIN",
        .us_pacific = "US_PACIFIC",
        .us_samoa = "US_SAMOA",
        .utc = "UTC",
    };
};
