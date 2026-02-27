/// Represents the set of radios and their states on a device. Examples of
/// radios
/// include Wi-Fi, GPS, Bluetooth, and NFC.
pub const Radios = struct {
    /// True if Bluetooth is enabled at the beginning of the test. Otherwise, false.
    bluetooth: ?bool,

    /// True if GPS is enabled at the beginning of the test. Otherwise, false.
    gps: ?bool,

    /// True if NFC is enabled at the beginning of the test. Otherwise, false.
    nfc: ?bool,

    /// True if Wi-Fi is enabled at the beginning of the test. Otherwise, false.
    wifi: ?bool,

    pub const json_field_names = .{
        .bluetooth = "bluetooth",
        .gps = "gps",
        .nfc = "nfc",
        .wifi = "wifi",
    };
};
