/// LoRaWANGetServiceProfileInfo object.
pub const LoRaWANGetServiceProfileInfo = struct {
    /// The AddGWMetaData value.
    add_gw_metadata: bool = false,

    /// The ChannelMask value.
    channel_mask: ?[]const u8 = null,

    /// The DevStatusReqFreq value.
    dev_status_req_freq: ?i32 = null,

    /// The DLBucketSize value.
    dl_bucket_size: ?i32 = null,

    /// The DLRate value.
    dl_rate: ?i32 = null,

    /// The DLRatePolicy value.
    dl_rate_policy: ?[]const u8 = null,

    /// The DRMax value.
    dr_max: i32 = 0,

    /// The DRMin value.
    dr_min: i32 = 0,

    /// The HRAllowed value that describes whether handover roaming is allowed.
    hr_allowed: bool = false,

    /// The MinGwDiversity value.
    min_gw_diversity: ?i32 = null,

    /// The maximum number of transmissions.
    ///
    /// Default: `3`
    nb_trans_max: ?i32 = null,

    /// The minimum number of transmissions.
    ///
    /// Default: `0`
    nb_trans_min: ?i32 = null,

    /// The NwkGeoLoc value.
    nwk_geo_loc: bool = false,

    /// The PRAllowed value that describes whether passive roaming is allowed.
    pr_allowed: bool = false,

    /// The RAAllowed value that describes whether roaming activation is allowed.
    ra_allowed: bool = false,

    /// The ReportDevStatusBattery value.
    report_dev_status_battery: bool = false,

    /// The ReportDevStatusMargin value.
    report_dev_status_margin: bool = false,

    /// The TargetPER value.
    target_per: i32 = 0,

    /// The Transmit Power Index maximum value.
    ///
    /// Default: `15`
    tx_power_index_max: ?i32 = null,

    /// The Transmit Power Index minimum value.
    ///
    /// Default: `0`
    tx_power_index_min: ?i32 = null,

    /// The ULBucketSize value.
    ul_bucket_size: ?i32 = null,

    /// The ULRate value.
    ul_rate: ?i32 = null,

    /// The ULRatePolicy value.
    ul_rate_policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .add_gw_metadata = "AddGwMetadata",
        .channel_mask = "ChannelMask",
        .dev_status_req_freq = "DevStatusReqFreq",
        .dl_bucket_size = "DlBucketSize",
        .dl_rate = "DlRate",
        .dl_rate_policy = "DlRatePolicy",
        .dr_max = "DrMax",
        .dr_min = "DrMin",
        .hr_allowed = "HrAllowed",
        .min_gw_diversity = "MinGwDiversity",
        .nb_trans_max = "NbTransMax",
        .nb_trans_min = "NbTransMin",
        .nwk_geo_loc = "NwkGeoLoc",
        .pr_allowed = "PrAllowed",
        .ra_allowed = "RaAllowed",
        .report_dev_status_battery = "ReportDevStatusBattery",
        .report_dev_status_margin = "ReportDevStatusMargin",
        .target_per = "TargetPer",
        .tx_power_index_max = "TxPowerIndexMax",
        .tx_power_index_min = "TxPowerIndexMin",
        .ul_bucket_size = "UlBucketSize",
        .ul_rate = "UlRate",
        .ul_rate_policy = "UlRatePolicy",
    };
};
