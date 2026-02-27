/// CDMA local ID information, which corresponds to the local identification
/// parameters of
/// a CDMA cell.
pub const CdmaLocalId = struct {
    /// CDMA channel information.
    cdma_channel: i32,

    /// Pseudo-noise offset, which is a characteristic of the signal from a cell on
    /// a radio
    /// tower.
    pn_offset: i32,

    pub const json_field_names = .{
        .cdma_channel = "CdmaChannel",
        .pn_offset = "PnOffset",
    };
};
