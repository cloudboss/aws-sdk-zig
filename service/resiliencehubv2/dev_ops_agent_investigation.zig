const DevOpsAgentConfidence = @import("dev_ops_agent_confidence.zig").DevOpsAgentConfidence;
const DevOpsAgentInvestigationStatus = @import("dev_ops_agent_investigation_status.zig").DevOpsAgentInvestigationStatus;
const DevOpsAgentVerdict = @import("dev_ops_agent_verdict.zig").DevOpsAgentVerdict;

/// The result when DevOps Agent investigates a resilience test run. The verdict
/// is advisory and builds on the test run's own result, which remains
/// authoritative.
pub const DevOpsAgentInvestigation = struct {
    /// The confidence level of the verdict. Valid values:
    ///
    /// * HIGH - The verdict is highly reliable.
    /// * MEDIUM - The verdict has moderate reliability.
    /// * LOW - The verdict has low reliability.
    confidence: ?DevOpsAgentConfidence = null,

    /// A deep link to the interactive DevOps Agent investigation session.
    deep_link: ?[]const u8 = null,

    /// The lifecycle status of the investigation. Valid values:
    ///
    /// * PENDING - The investigation has been created but has not started.
    /// * IN_PROGRESS - The investigation is running.
    /// * COMPLETED - The investigation finished successfully.
    /// * FAILED - The investigation failed to complete.
    /// * TIMED_OUT - The investigation did not complete within the allotted time.
    /// * CANCELED - The investigation was canceled.
    status: ?DevOpsAgentInvestigationStatus = null,

    /// The DevOps Agent analysis summary for the investigation.
    summary: ?[]const u8 = null,

    /// The investigation verdict. Valid values:
    ///
    /// * PASS - The resilience test run passed.
    /// * FAIL - The resilience test run failed.
    /// * INCONCLUSIVE - The investigation could not determine a clear outcome.
    verdict: ?DevOpsAgentVerdict = null,

    pub const json_field_names = .{
        .confidence = "confidence",
        .deep_link = "deepLink",
        .status = "status",
        .summary = "summary",
        .verdict = "verdict",
    };
};
