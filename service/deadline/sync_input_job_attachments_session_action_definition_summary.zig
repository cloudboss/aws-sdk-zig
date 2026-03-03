/// The summary of the session action definition for syncing input job
/// attachments.
pub const SyncInputJobAttachmentsSessionActionDefinitionSummary = struct {
    /// The step ID for the sync input job attachments session action summary.
    step_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .step_id = "stepId",
    };
};
