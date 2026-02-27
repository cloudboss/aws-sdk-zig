pub const Profile = enum {
    none,
    hbbtv_1_5,
    hybridcast,
    dvb_dash_2014,

    pub const json_field_names = .{
        .none = "NONE",
        .hbbtv_1_5 = "HBBTV_1_5",
        .hybridcast = "HYBRIDCAST",
        .dvb_dash_2014 = "DVB_DASH_2014",
    };
};
