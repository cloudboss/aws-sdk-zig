pub const NumberType = enum {
    short_code,
    long_code,
    toll_free,
    ten_dlc,
    simulator,

    pub const json_field_names = .{
        .short_code = "SHORT_CODE",
        .long_code = "LONG_CODE",
        .toll_free = "TOLL_FREE",
        .ten_dlc = "TEN_DLC",
        .simulator = "SIMULATOR",
    };
};
