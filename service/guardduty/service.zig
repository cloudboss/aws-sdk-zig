const Action = @import("action.zig").Action;
const ServiceAdditionalInfo = @import("service_additional_info.zig").ServiceAdditionalInfo;
const Detection = @import("detection.zig").Detection;
const EbsVolumeScanDetails = @import("ebs_volume_scan_details.zig").EbsVolumeScanDetails;
const Evidence = @import("evidence.zig").Evidence;
const MalwareScanDetails = @import("malware_scan_details.zig").MalwareScanDetails;
const RuntimeDetails = @import("runtime_details.zig").RuntimeDetails;

/// Contains additional information about the generated finding.
pub const Service = struct {
    /// Information about the activity that is described in a finding.
    action: ?Action,

    /// Contains additional information about the generated finding.
    additional_info: ?ServiceAdditionalInfo,

    /// Indicates whether this finding is archived.
    archived: ?bool,

    /// The total count of the occurrences of this finding type.
    count: ?i32,

    /// Contains information about the detected unusual behavior.
    detection: ?Detection,

    /// The detector ID for the GuardDuty service.
    detector_id: ?[]const u8,

    /// Returns details from the malware scan that created a finding.
    ebs_volume_scan_details: ?EbsVolumeScanDetails,

    /// The first-seen timestamp of the activity that prompted GuardDuty to generate
    /// this
    /// finding.
    event_first_seen: ?[]const u8,

    /// The last-seen timestamp of the activity that prompted GuardDuty to generate
    /// this
    /// finding.
    event_last_seen: ?[]const u8,

    /// An evidence object associated with the service.
    evidence: ?Evidence,

    /// The name of the feature that generated a finding.
    feature_name: ?[]const u8,

    /// Returns details from the malware scan that generated a GuardDuty finding.
    malware_scan_details: ?MalwareScanDetails,

    /// The resource role information for this finding.
    resource_role: ?[]const u8,

    /// Information about the process and any required context values for a specific
    /// finding
    runtime_details: ?RuntimeDetails,

    /// The name of the Amazon Web Services service (GuardDuty) that generated a
    /// finding.
    service_name: ?[]const u8,

    /// Feedback that was submitted about the finding.
    user_feedback: ?[]const u8,

    pub const json_field_names = .{
        .action = "Action",
        .additional_info = "AdditionalInfo",
        .archived = "Archived",
        .count = "Count",
        .detection = "Detection",
        .detector_id = "DetectorId",
        .ebs_volume_scan_details = "EbsVolumeScanDetails",
        .event_first_seen = "EventFirstSeen",
        .event_last_seen = "EventLastSeen",
        .evidence = "Evidence",
        .feature_name = "FeatureName",
        .malware_scan_details = "MalwareScanDetails",
        .resource_role = "ResourceRole",
        .runtime_details = "RuntimeDetails",
        .service_name = "ServiceName",
        .user_feedback = "UserFeedback",
    };
};
