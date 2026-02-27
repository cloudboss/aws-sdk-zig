const VolumeDetail = @import("volume_detail.zig").VolumeDetail;
const ResourceDetails = @import("resource_details.zig").ResourceDetails;
const ScanResultDetails = @import("scan_result_details.zig").ScanResultDetails;
const ScanStatus = @import("scan_status.zig").ScanStatus;
const ScanType = @import("scan_type.zig").ScanType;
const TriggerDetails = @import("trigger_details.zig").TriggerDetails;

/// Contains information about malware scans associated with GuardDuty Malware
/// Protection for EC2.
pub const Scan = struct {
    /// The ID for the account that belongs to the scan.
    account_id: ?[]const u8,

    /// The unique detector ID of the administrator account that the request is
    /// associated with.
    /// If the account is an administrator, the `AdminDetectorId` will be the same
    /// as the one used for
    /// `DetectorId`.
    ///
    /// To find the `detectorId` in the current Region, see the
    /// Settings page in the GuardDuty console, or run the
    /// [ListDetectors](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_ListDetectors.html) API.
    admin_detector_id: ?[]const u8,

    /// List of volumes that were attached to the original instance to be scanned.
    attached_volumes: ?[]const VolumeDetail,

    /// The unique ID of the detector that is associated with the request.
    ///
    /// To find the `detectorId` in the current Region, see the
    /// Settings page in the GuardDuty console, or run the
    /// [ListDetectors](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_ListDetectors.html) API.
    detector_id: ?[]const u8,

    /// Represents the reason for `FAILED` scan status.
    failure_reason: ?[]const u8,

    /// Represents the number of files that were scanned.
    file_count: ?i64,

    /// Represents the resources that were scanned in the scan entry.
    resource_details: ?ResourceDetails,

    /// The timestamp of when the scan was finished.
    scan_end_time: ?i64,

    /// The unique scan ID associated with a scan entry.
    scan_id: ?[]const u8,

    /// Represents the result of the scan.
    scan_result_details: ?ScanResultDetails,

    /// The timestamp of when the scan was triggered.
    scan_start_time: ?i64,

    /// An enum value representing possible scan statuses.
    scan_status: ?ScanStatus,

    /// Specifies the scan type that invoked the malware scan.
    scan_type: ?ScanType,

    /// Represents total bytes that were scanned.
    total_bytes: ?i64,

    /// Specifies the reason why the scan was initiated.
    trigger_details: ?TriggerDetails,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .admin_detector_id = "AdminDetectorId",
        .attached_volumes = "AttachedVolumes",
        .detector_id = "DetectorId",
        .failure_reason = "FailureReason",
        .file_count = "FileCount",
        .resource_details = "ResourceDetails",
        .scan_end_time = "ScanEndTime",
        .scan_id = "ScanId",
        .scan_result_details = "ScanResultDetails",
        .scan_start_time = "ScanStartTime",
        .scan_status = "ScanStatus",
        .scan_type = "ScanType",
        .total_bytes = "TotalBytes",
        .trigger_details = "TriggerDetails",
    };
};
