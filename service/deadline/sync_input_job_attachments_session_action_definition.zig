/// The session action definition for syncing input job attachments.
pub const SyncInputJobAttachmentsSessionActionDefinition = struct {
    /// The step ID for the sync input job attachments session action.
    step_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .step_id = "stepId",
    };
};
