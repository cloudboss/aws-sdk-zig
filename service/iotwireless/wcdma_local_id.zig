/// WCDMA local identification (local ID) information.
pub const WcdmaLocalId = struct {
    /// Primary Scrambling Code.
    psc: i32,

    /// WCDMA UTRA Absolute RF Channel Number downlink.
    uarfcndl: i32,

    pub const json_field_names = .{
        .psc = "Psc",
        .uarfcndl = "Uarfcndl",
    };
};
