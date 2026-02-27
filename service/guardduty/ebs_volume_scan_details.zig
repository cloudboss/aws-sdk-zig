const ScanDetections = @import("scan_detections.zig").ScanDetections;
const ScanType = @import("scan_type.zig").ScanType;

/// Contains details from the malware scan that created a finding.
pub const EbsVolumeScanDetails = struct {
    /// Returns the completion date and time of the malware scan.
    scan_completed_at: ?i64,

    /// Contains a complete view providing malware scan result details.
    scan_detections: ?ScanDetections,

    /// Unique Id of the malware scan that generated the finding.
    scan_id: ?[]const u8,

    /// Returns the start date and time of the malware scan.
    scan_started_at: ?i64,

    /// Specifies the scan type that invoked the malware scan.
    scan_type: ?ScanType,

    /// Contains list of threat intelligence sources used to detect threats.
    sources: ?[]const []const u8,

    /// GuardDuty finding ID that triggered a malware scan.
    trigger_finding_id: ?[]const u8,

    pub const json_field_names = .{
        .scan_completed_at = "ScanCompletedAt",
        .scan_detections = "ScanDetections",
        .scan_id = "ScanId",
        .scan_started_at = "ScanStartedAt",
        .scan_type = "ScanType",
        .sources = "Sources",
        .trigger_finding_id = "TriggerFindingId",
    };
};
