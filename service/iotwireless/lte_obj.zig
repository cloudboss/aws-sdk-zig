const LteLocalId = @import("lte_local_id.zig").LteLocalId;
const LteNmrObj = @import("lte_nmr_obj.zig").LteNmrObj;

/// LTE object.
pub const LteObj = struct {
    /// E-UTRAN (Evolved Universal Terrestrial Radio Access Network) Cell Global
    /// Identifier.
    eutran_cid: i32,

    /// LTE local identification (local ID) information.
    lte_local_id: ?LteLocalId = null,

    /// LTE object for network measurement reports.
    lte_nmr: ?[]const LteNmrObj = null,

    /// LTE timing advance.
    lte_timing_advance: ?i32 = null,

    /// Mobile Country Code.
    mcc: i32,

    /// Mobile Network Code.
    mnc: i32,

    /// Parameter that determines whether the LTE object is capable of supporting NR
    /// (new
    /// radio).
    nr_capable: bool = false,

    /// Signal power of the reference signal received, measured in dBm
    /// (decibel-milliwatts).
    rsrp: ?i32 = null,

    /// Signal quality of the reference Signal received, measured in decibels (dB).
    rsrq: ?f32 = null,

    /// LTE tracking area code.
    tac: ?i32 = null,

    pub const json_field_names = .{
        .eutran_cid = "EutranCid",
        .lte_local_id = "LteLocalId",
        .lte_nmr = "LteNmr",
        .lte_timing_advance = "LteTimingAdvance",
        .mcc = "Mcc",
        .mnc = "Mnc",
        .nr_capable = "NrCapable",
        .rsrp = "Rsrp",
        .rsrq = "Rsrq",
        .tac = "Tac",
    };
};
