/// Identifies the entity or change set that was assessed.
pub const AssessmentTargetSummary = struct {
    /// The unique ID of the change set that was assessed.
    change_set_id: ?[]const u8 = null,

    /// The unique ID of the entity that was assessed.
    entity_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .change_set_id = "ChangeSetId",
        .entity_id = "EntityId",
    };
};
