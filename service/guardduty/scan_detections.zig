const HighestSeverityThreatDetails = @import("highest_severity_threat_details.zig").HighestSeverityThreatDetails;
const ScannedItemCount = @import("scanned_item_count.zig").ScannedItemCount;
const ThreatDetectedByName = @import("threat_detected_by_name.zig").ThreatDetectedByName;
const ThreatsDetectedItemCount = @import("threats_detected_item_count.zig").ThreatsDetectedItemCount;

/// Contains a complete view providing malware scan result details.
pub const ScanDetections = struct {
    /// Details of the highest severity threat detected during malware scan and
    /// number of infected files.
    highest_severity_threat_details: ?HighestSeverityThreatDetails = null,

    /// Total number of scanned files.
    scanned_item_count: ?ScannedItemCount = null,

    /// Contains details about identified threats organized by threat name.
    threat_detected_by_name: ?ThreatDetectedByName = null,

    /// Total number of infected files.
    threats_detected_item_count: ?ThreatsDetectedItemCount = null,

    pub const json_field_names = .{
        .highest_severity_threat_details = "HighestSeverityThreatDetails",
        .scanned_item_count = "ScannedItemCount",
        .threat_detected_by_name = "ThreatDetectedByName",
        .threats_detected_item_count = "ThreatsDetectedItemCount",
    };
};
