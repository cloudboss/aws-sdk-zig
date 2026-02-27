pub const ViewerMinimumTlsProtocolVersionEnum = enum {
    tl_sv_11_2016,
    tl_sv_12_2018,
    tl_sv_12_2019,
    tl_sv_12_2021,

    pub const json_field_names = .{
        .tl_sv_11_2016 = "TLSv11_2016",
        .tl_sv_12_2018 = "TLSv12_2018",
        .tl_sv_12_2019 = "TLSv12_2019",
        .tl_sv_12_2021 = "TLSv12_2021",
    };
};
