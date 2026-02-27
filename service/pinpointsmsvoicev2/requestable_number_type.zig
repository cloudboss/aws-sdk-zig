pub const RequestableNumberType = enum {
    long_code,
    toll_free,
    ten_dlc,
    simulator,

    pub const json_field_names = .{
        .long_code = "LONG_CODE",
        .toll_free = "TOLL_FREE",
        .ten_dlc = "TEN_DLC",
        .simulator = "SIMULATOR",
    };
};
