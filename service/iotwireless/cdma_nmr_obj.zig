/// CDMA object for network measurement reports.
pub const CdmaNmrObj = struct {
    /// CDMA base station ID (BSID).
    base_station_id: ?i32 = null,

    /// CDMA channel information.
    cdma_channel: i32,

    /// Transmit power level of the pilot signal, measured in dBm
    /// (decibel-milliwatts).
    pilot_power: ?i32 = null,

    /// Pseudo-noise offset, which is a characteristic of the signal from a cell on
    /// a radio
    /// tower.
    pn_offset: i32,

    pub const json_field_names = .{
        .base_station_id = "BaseStationId",
        .cdma_channel = "CdmaChannel",
        .pilot_power = "PilotPower",
        .pn_offset = "PnOffset",
    };
};
