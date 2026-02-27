const ScannedResourceDetails = @import("scanned_resource_details.zig").ScannedResourceDetails;
const MalwareProtectionScanStatus = @import("malware_protection_scan_status.zig").MalwareProtectionScanStatus;
const MalwareProtectionResourceType = @import("malware_protection_resource_type.zig").MalwareProtectionResourceType;
const ScanStatusReason = @import("scan_status_reason.zig").ScanStatusReason;

/// Contains information about a resource that was scanned as part of the
/// malware scan operation.
pub const ScannedResource = struct {
    /// Information about the scanned resource.
    resource_details: ?ScannedResourceDetails,

    /// Amazon Resource Name (ARN) of the scanned resource.
    scanned_resource_arn: ?[]const u8,

    /// The status of the scanned resource.
    scanned_resource_status: ?MalwareProtectionScanStatus,

    /// The resource type of the scanned resource.
    scanned_resource_type: ?MalwareProtectionResourceType,

    /// The reason for the scan status of this particular resource, if applicable.
    scan_status_reason: ?ScanStatusReason,

    pub const json_field_names = .{
        .resource_details = "ResourceDetails",
        .scanned_resource_arn = "ScannedResourceArn",
        .scanned_resource_status = "ScannedResourceStatus",
        .scanned_resource_type = "ScannedResourceType",
        .scan_status_reason = "ScanStatusReason",
    };
};
