/// Configuration for WiFi and cellular location payloads. Contains the
/// confidence
/// level that determines the size of the uncertainty radius in the position
/// estimate.
pub const WiFiCellular = struct {
    /// The confidence level for WiFi and cellular position estimates, expressed as
    /// a
    /// percentage. This value determines the size of the confidence area or
    /// uncertainty
    /// radius for the estimated position. A higher confidence level produces a
    /// larger uncertainty radius, while a lower
    /// confidence level produces a smaller, more precise radius.
    ///
    /// Valid range: 50 to 99 inclusive. If not specified, the default value of 68
    /// is
    /// used, which corresponds to approximately one standard deviation of the
    /// normal
    /// distribution.
    confidence_percent: i32 = 68,

    pub const json_field_names = .{
        .confidence_percent = "ConfidencePercent",
    };
};
