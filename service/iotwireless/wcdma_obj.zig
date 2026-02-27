const WcdmaLocalId = @import("wcdma_local_id.zig").WcdmaLocalId;
const WcdmaNmrObj = @import("wcdma_nmr_obj.zig").WcdmaNmrObj;

/// WCDMA.
pub const WcdmaObj = struct {
    /// Location Area Code.
    lac: ?i32,

    /// Mobile Country Code.
    mcc: i32,

    /// Mobile Network Code.
    mnc: i32,

    /// Path loss, or path attenuation, is the reduction in power density of an
    /// electromagnetic wave as it propagates through space.
    path_loss: ?i32,

    /// Received Signal Code Power (signal power) (dBm).
    rscp: ?i32,

    /// UTRAN (UMTS Terrestrial Radio Access Network) Cell Global Identifier.
    utran_cid: i32,

    /// WCDMA local ID information.
    wcdma_local_id: ?WcdmaLocalId,

    /// WCDMA object for network measurement reports.
    wcdma_nmr: ?[]const WcdmaNmrObj,

    pub const json_field_names = .{
        .lac = "Lac",
        .mcc = "Mcc",
        .mnc = "Mnc",
        .path_loss = "PathLoss",
        .rscp = "Rscp",
        .utran_cid = "UtranCid",
        .wcdma_local_id = "WcdmaLocalId",
        .wcdma_nmr = "WcdmaNmr",
    };
};
