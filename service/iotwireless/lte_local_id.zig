/// LTE local identification (local ID) information.
pub const LteLocalId = struct {
    /// Evolved universal terrestrial radio access (E-UTRA) absolute radio frequency
    /// channel
    /// number (FCN).
    earfcn: i32,

    /// Physical cell ID.
    pci: i32,

    pub const json_field_names = .{
        .earfcn = "Earfcn",
        .pci = "Pci",
    };
};
