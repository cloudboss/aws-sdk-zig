/// LTE network measurements.
pub const LteNetworkMeasurements = struct {
    /// E-UTRAN Cell Identifier (ECI).
    cell_id: i32 = 0,

    /// E-UTRA (Evolved Universal Terrestrial Radio Access) absolute radio frequency
    /// channel number (EARFCN).
    earfcn: i32 = 0,

    /// Physical Cell ID (PCI).
    pci: i32 = 0,

    /// Signal power of the reference signal received, measured in dBm
    /// (decibel-milliwatts).
    rsrp: ?i32 = null,

    /// Signal quality of the reference Signal received, measured in decibels (dB).
    rsrq: ?f32 = null,

    pub const json_field_names = .{
        .cell_id = "CellId",
        .earfcn = "Earfcn",
        .pci = "Pci",
        .rsrp = "Rsrp",
        .rsrq = "Rsrq",
    };
};
