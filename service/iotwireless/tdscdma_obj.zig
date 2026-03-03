const TdscdmaLocalId = @import("tdscdma_local_id.zig").TdscdmaLocalId;
const TdscdmaNmrObj = @import("tdscdma_nmr_obj.zig").TdscdmaNmrObj;

/// TD-SCDMA object.
pub const TdscdmaObj = struct {
    /// Location Area Code.
    lac: ?i32 = null,

    /// Mobile Country Code.
    mcc: i32,

    /// Mobile Network Code.
    mnc: i32,

    /// Path loss, or path attenuation, is the reduction in power density of an
    /// electromagnetic wave as it propagates through space.
    path_loss: ?i32 = null,

    /// Signal power of the received signal (Received Signal Code Power), measured
    /// in
    /// decibel-milliwatts (dBm).
    rscp: ?i32 = null,

    /// TD-SCDMA local identification (local ID) information.
    tdscdma_local_id: ?TdscdmaLocalId = null,

    /// TD-SCDMA object for network measurement reports.
    tdscdma_nmr: ?[]const TdscdmaNmrObj = null,

    /// TD-SCDMA Timing advance.
    tdscdma_timing_advance: ?i32 = null,

    /// UTRAN (UMTS Terrestrial Radio Access Network) Cell Global Identifier.
    utran_cid: i32,

    pub const json_field_names = .{
        .lac = "Lac",
        .mcc = "Mcc",
        .mnc = "Mnc",
        .path_loss = "PathLoss",
        .rscp = "Rscp",
        .tdscdma_local_id = "TdscdmaLocalId",
        .tdscdma_nmr = "TdscdmaNmr",
        .tdscdma_timing_advance = "TdscdmaTimingAdvance",
        .utran_cid = "UtranCid",
    };
};
