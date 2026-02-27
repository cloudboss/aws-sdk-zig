/// LTE local identification information (local ID).
pub const LteLocalId = struct {
    /// E-UTRA (Evolved Universal Terrestrial Radio Access) absolute radio frequency
    /// channel number (EARFCN).
    earfcn: i32 = 0,

    /// Physical Cell ID (PCI).
    pci: i32 = 0,

    pub const json_field_names = .{
        .earfcn = "Earfcn",
        .pci = "Pci",
    };
};
