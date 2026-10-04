/// A single GNSS scan capture containing the scan payload and optional capture
/// time.
pub const GnssCapture = struct {
    /// Optional parameter that gives an estimate of the time when the GNSS scan
    /// information
    /// is taken, in seconds GPS time (GPST). If capture time is not specified, the
    /// local server
    /// time is used.
    capture_time: ?f32 = null,

    /// Payload that contains the GNSS scan result, or NAV message, in hexadecimal
    /// notation.
    payload: []const u8,

    pub const json_field_names = .{
        .capture_time = "CaptureTime",
        .payload = "Payload",
    };
};
