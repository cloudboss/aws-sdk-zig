/// Filters assessment list results by the resource that was assessed. Provide
/// an entity
/// identifier, a change set identifier, or both.
pub const AssessmentTargetFilter = struct {
    /// The unique ID of the change set that triggered the assessments you want to
    /// list.
    change_set_id: ?[]const u8 = null,

    /// The unique ID of the entity whose assessments you want to list.
    entity_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .change_set_id = "ChangeSetId",
        .entity_id = "EntityId",
    };
};
