/// The assigned session action definition for syncing input job attachments.
pub const AssignedSyncInputJobAttachmentsSessionActionDefinition = struct {
    /// The step ID for the assigned sync input job attachments session action.
    step_id: ?[]const u8,

    pub const json_field_names = .{
        .step_id = "stepId",
    };
};
