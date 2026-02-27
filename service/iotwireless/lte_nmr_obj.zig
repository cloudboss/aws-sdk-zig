/// LTE object for network measurement reports.
pub const LteNmrObj = struct {
    /// E-UTRA (Evolved universal terrestrial Radio Access) absolute radio frequency
    /// channel
    /// Number (EARFCN).
    earfcn: i32,

    /// E-UTRAN (Evolved Universal Terrestrial Radio Access Network) cell global
    /// identifier
    /// (EUTRANCID).
    eutran_cid: i32 = 0,

    /// Physical cell ID.
    pci: i32,

    /// Signal power of the reference signal received, measured in dBm
    /// (decibel-milliwatts).
    rsrp: ?i32,

    /// Signal quality of the reference Signal received, measured in decibels (dB).
    rsrq: ?f32,

    pub const json_field_names = .{
        .earfcn = "Earfcn",
        .eutran_cid = "EutranCid",
        .pci = "Pci",
        .rsrp = "Rsrp",
        .rsrq = "Rsrq",
    };
};
