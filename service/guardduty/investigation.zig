const CloudDetails = @import("cloud_details.zig").CloudDetails;
const Confidence = @import("confidence.zig").Confidence;
const InvestigationMetadata = @import("investigation_metadata.zig").InvestigationMetadata;
const RiskLevel = @import("risk_level.zig").RiskLevel;
const InvestigationStatus = @import("investigation_status.zig").InvestigationStatus;

/// Contains the details and results of a GuardDuty investigation.
pub const Investigation = struct {
    /// Details about the cloud environment in which the investigation was
    /// performed, including the provider, region, and account.
    cloud: ?CloudDetails = null,

    /// The confidence level of the investigation's assessment. Possible values are
    /// `Unknown`, `Low`, `Medium`, and `High`.
    confidence: ?Confidence = null,

    /// The timestamp at which the investigation completed.
    end_time: ?i64 = null,

    /// Details about the error if the investigation status is `FAILED`.
    @"error": ?[]const u8 = null,

    /// The unique identifier of the investigation.
    investigation_id: []const u8,

    /// Metadata about the product and version that produced the investigation.
    metadata: ?InvestigationMetadata = null,

    /// A human-readable description of the assessed risk.
    risk: ?[]const u8 = null,

    /// The assessed risk level of the investigated threat. Possible values are
    /// `Info`, `Low`, `Medium`, `High`, and `Critical`.
    risk_level: ?RiskLevel = null,

    /// The timestamp at which the investigation started.
    start_time: ?i64 = null,

    /// The current status of the investigation. Possible values are `RUNNING`,
    /// `COMPLETED`, and `FAILED`.
    status: InvestigationStatus,

    /// A structured summary of the investigation findings, including affected
    /// resources, threat assessment, and recommended remediation steps.
    summary: ?[]const u8 = null,

    /// The account that initiated the investigation.
    triggered_by: []const u8,

    /// The natural-language prompt that initiated this investigation.
    trigger_prompt: []const u8,

    pub const json_field_names = .{
        .cloud = "Cloud",
        .confidence = "Confidence",
        .end_time = "EndTime",
        .@"error" = "Error",
        .investigation_id = "InvestigationId",
        .metadata = "Metadata",
        .risk = "Risk",
        .risk_level = "RiskLevel",
        .start_time = "StartTime",
        .status = "Status",
        .summary = "Summary",
        .triggered_by = "TriggeredBy",
        .trigger_prompt = "TriggerPrompt",
    };
};
