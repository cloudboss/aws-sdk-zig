/// Contains a definition for an action.
pub const ActionDefinition = struct {
    /// The ID of the action definition.
    action_definition_id: []const u8,

    /// The name of the action definition.
    action_name: []const u8,

    /// The type of the action definition.
    action_type: []const u8,

    pub const json_field_names = .{
        .action_definition_id = "actionDefinitionId",
        .action_name = "actionName",
        .action_type = "actionType",
    };
};
