pub const MaxDisplayResolution = enum {
    resolution_dci_4_k,
    resolution_uhd_4_k,
    resolution_1440_p_ultra_wide,
    resolution_1440_p,
    resolution_1080_p,
    resolution_720_p,
    resolution_768_p,
    resolution_600_p,

    pub const json_field_names = .{
        .resolution_dci_4_k = "RESOLUTION_DCI_4K",
        .resolution_uhd_4_k = "RESOLUTION_UHD_4K",
        .resolution_1440_p_ultra_wide = "RESOLUTION_1440P_ULTRA_WIDE",
        .resolution_1440_p = "RESOLUTION_1440P",
        .resolution_1080_p = "RESOLUTION_1080P",
        .resolution_720_p = "RESOLUTION_720P",
        .resolution_768_p = "RESOLUTION_768P",
        .resolution_600_p = "RESOLUTION_600P",
    };
};
