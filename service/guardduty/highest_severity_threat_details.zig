/// Contains details of the highest severity threat detected during scan and
/// number of
/// infected files.
pub const HighestSeverityThreatDetails = struct {
    /// Total number of infected files with the highest severity threat detected.
    count: ?i32,

    /// Severity level of the highest severity threat detected.
    severity: ?[]const u8,

    /// Threat name of the highest severity threat detected as part of the malware
    /// scan.
    threat_name: ?[]const u8,

    pub const json_field_names = .{
        .count = "Count",
        .severity = "Severity",
        .threat_name = "ThreatName",
    };
};
