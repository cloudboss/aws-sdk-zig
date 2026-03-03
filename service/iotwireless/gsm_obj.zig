const GsmLocalId = @import("gsm_local_id.zig").GsmLocalId;
const GsmNmrObj = @import("gsm_nmr_obj.zig").GsmNmrObj;

/// GSM object.
pub const GsmObj = struct {
    /// GERAN (GSM EDGE Radio Access Network) Cell Global Identifier.
    geran_cid: i32,

    /// GSM local identification (local ID) information.
    gsm_local_id: ?GsmLocalId = null,

    /// GSM object for network measurement reports.
    gsm_nmr: ?[]const GsmNmrObj = null,

    /// Timing advance value, which corresponds to the length of time a signal takes
    /// to reach
    /// the base station from a mobile phone.
    gsm_timing_advance: ?i32 = null,

    /// Location area code.
    lac: i32,

    /// Mobile Country Code.
    mcc: i32,

    /// Mobile Network Code.
    mnc: i32,

    /// Rx level, which is the received signal power, measured in dBm
    /// (decibel-milliwatts).
    rx_level: ?i32 = null,

    pub const json_field_names = .{
        .geran_cid = "GeranCid",
        .gsm_local_id = "GsmLocalId",
        .gsm_nmr = "GsmNmr",
        .gsm_timing_advance = "GsmTimingAdvance",
        .lac = "Lac",
        .mcc = "Mcc",
        .mnc = "Mnc",
        .rx_level = "RxLevel",
    };
};
