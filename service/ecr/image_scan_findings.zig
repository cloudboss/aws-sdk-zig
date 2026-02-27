const aws = @import("aws");

const EnhancedImageScanFinding = @import("enhanced_image_scan_finding.zig").EnhancedImageScanFinding;
const ImageScanFinding = @import("image_scan_finding.zig").ImageScanFinding;

/// The details of an image scan.
pub const ImageScanFindings = struct {
    /// Details about the enhanced scan findings from Amazon Inspector.
    enhanced_findings: ?[]const EnhancedImageScanFinding,

    /// The findings from the image scan.
    findings: ?[]const ImageScanFinding,

    /// The image vulnerability counts, sorted by severity.
    finding_severity_counts: ?[]const aws.map.MapEntry(i32),

    /// The time of the last completed image scan.
    image_scan_completed_at: ?i64,

    /// The time when the vulnerability data was last scanned.
    vulnerability_source_updated_at: ?i64,

    pub const json_field_names = .{
        .enhanced_findings = "enhancedFindings",
        .findings = "findings",
        .finding_severity_counts = "findingSeverityCounts",
        .image_scan_completed_at = "imageScanCompletedAt",
        .vulnerability_source_updated_at = "vulnerabilitySourceUpdatedAt",
    };
};
