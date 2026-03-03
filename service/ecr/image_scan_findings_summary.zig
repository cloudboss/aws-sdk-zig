const aws = @import("aws");

/// A summary of the last completed image scan.
pub const ImageScanFindingsSummary = struct {
    /// The image vulnerability counts, sorted by severity.
    finding_severity_counts: ?[]const aws.map.MapEntry(i32) = null,

    /// The time of the last completed image scan.
    image_scan_completed_at: ?i64 = null,

    /// The time when the vulnerability data was last scanned.
    vulnerability_source_updated_at: ?i64 = null,

    pub const json_field_names = .{
        .finding_severity_counts = "findingSeverityCounts",
        .image_scan_completed_at = "imageScanCompletedAt",
        .vulnerability_source_updated_at = "vulnerabilitySourceUpdatedAt",
    };
};
