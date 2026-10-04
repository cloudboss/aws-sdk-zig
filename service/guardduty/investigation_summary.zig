const Confidence = @import("confidence.zig").Confidence;
const RiskLevel = @import("risk_level.zig").RiskLevel;
const InvestigationStatus = @import("investigation_status.zig").InvestigationStatus;

/// Contains summary information about a GuardDuty investigation.
pub const InvestigationSummary = struct {
    /// The Amazon Web Services account ID associated with the investigation.
    account_id: ?[]const u8 = null,

    /// The confidence level of the investigation's assessment.
    confidence: ?Confidence = null,

    /// The timestamp at which the investigation completed.
    end_time: ?i64 = null,

    /// The unique identifier of the investigation.
    investigation_id: ?[]const u8 = null,

    /// The assessed risk level of the investigated threat.
    risk_level: ?RiskLevel = null,

    /// The timestamp at which the investigation started.
    start_time: ?i64 = null,

    /// The current status of the investigation.
    status: ?InvestigationStatus = null,

    /// A short title summarizing the investigation.
    title: ?[]const u8 = null,

    /// The natural-language prompt that initiated this investigation.
    trigger_prompt: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .confidence = "Confidence",
        .end_time = "EndTime",
        .investigation_id = "InvestigationId",
        .risk_level = "RiskLevel",
        .start_time = "StartTime",
        .status = "Status",
        .title = "Title",
        .trigger_prompt = "TriggerPrompt",
    };
};
