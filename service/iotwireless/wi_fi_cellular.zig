/// Configuration for WiFi and cellular location payloads.
pub const WiFiCellular = struct {
    /// Confidence level for WiFi and cellular position estimates, expressed as a
    /// percentage. Valid range: 50–99 inclusive. Defaults to 68 if not specified.
    confidence_percent: i32 = 68,

    pub const json_field_names = .{
        .confidence_percent = "ConfidencePercent",
    };
};
