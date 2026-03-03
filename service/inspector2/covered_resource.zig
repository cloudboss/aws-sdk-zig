const ResourceScanMetadata = @import("resource_scan_metadata.zig").ResourceScanMetadata;
const CoverageResourceType = @import("coverage_resource_type.zig").CoverageResourceType;
const ScanMode = @import("scan_mode.zig").ScanMode;
const ScanStatus = @import("scan_status.zig").ScanStatus;
const ScanType = @import("scan_type.zig").ScanType;

/// An object that contains details about a resource covered by Amazon
/// Inspector.
pub const CoveredResource = struct {
    /// The Amazon Web Services account ID of the covered resource.
    account_id: []const u8,

    /// The date and time the resource was last checked for vulnerabilities.
    last_scanned_at: ?i64 = null,

    /// The ID of the covered resource.
    resource_id: []const u8,

    /// An object that contains details about the metadata.
    resource_metadata: ?ResourceScanMetadata = null,

    /// The type of the covered resource.
    resource_type: CoverageResourceType,

    /// The scan method that is applied to the instance.
    scan_mode: ?ScanMode = null,

    /// The status of the scan covering the resource.
    scan_status: ?ScanStatus = null,

    /// The Amazon Inspector scan type covering the resource.
    scan_type: ScanType,

    pub const json_field_names = .{
        .account_id = "accountId",
        .last_scanned_at = "lastScannedAt",
        .resource_id = "resourceId",
        .resource_metadata = "resourceMetadata",
        .resource_type = "resourceType",
        .scan_mode = "scanMode",
        .scan_status = "scanStatus",
        .scan_type = "scanType",
    };
};
