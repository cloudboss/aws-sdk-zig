/// TD-SCDMA local identification (local Id) information.
pub const TdscdmaLocalId = struct {
    /// Cell parameters for TD-SCDMA.
    cell_params: i32,

    /// TD-SCDMA UTRA (Universal Terrestrial Radio Access Network) absolute RF
    /// channel number
    /// (UARFCN).
    uarfcn: i32,

    pub const json_field_names = .{
        .cell_params = "CellParams",
        .uarfcn = "Uarfcn",
    };
};
