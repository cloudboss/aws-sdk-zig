/// TD-SCDMA object for network measurement reports.
pub const TdscdmaNmrObj = struct {
    /// Cell parameters for TD-SCDMA network measurement reports object.
    cell_params: i32,

    /// Path loss, or path attenuation, is the reduction in power density of an
    /// electromagnetic wave as it propagates through space.
    path_loss: ?i32,

    /// Code power of the received signal, measured in decibel-milliwatts (dBm).
    rscp: ?i32,

    /// TD-SCDMA UTRA (Universal Terrestrial Radio Access Network) absolute RF
    /// channel
    /// number.
    uarfcn: i32,

    /// UTRAN (UMTS Terrestrial Radio Access Network) cell global identifier.
    utran_cid: ?i32,

    pub const json_field_names = .{
        .cell_params = "CellParams",
        .path_loss = "PathLoss",
        .rscp = "Rscp",
        .uarfcn = "Uarfcn",
        .utran_cid = "UtranCid",
    };
};
