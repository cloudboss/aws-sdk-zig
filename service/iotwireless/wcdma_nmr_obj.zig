/// Network Measurement Reports.
pub const WcdmaNmrObj = struct {
    /// Path loss, or path attenuation, is the reduction in power density of an
    /// electromagnetic wave as it propagates through space.
    path_loss: ?i32,

    /// Primary Scrambling Code.
    psc: i32,

    /// Received Signal Code Power (signal power) (dBm)
    rscp: ?i32,

    /// WCDMA UTRA Absolute RF Channel Number downlink.
    uarfcndl: i32,

    /// UTRAN (UMTS Terrestrial Radio Access Network) Cell Global Identifier.
    utran_cid: i32,

    pub const json_field_names = .{
        .path_loss = "PathLoss",
        .psc = "Psc",
        .rscp = "Rscp",
        .uarfcndl = "Uarfcndl",
        .utran_cid = "UtranCid",
    };
};
