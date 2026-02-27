const ServiceActionDefinitionType = @import("service_action_definition_type.zig").ServiceActionDefinitionType;

/// Detailed information about the self-service action.
pub const ServiceActionSummary = struct {
    /// The self-service action definition type. For example, `SSM_AUTOMATION`.
    definition_type: ?ServiceActionDefinitionType,

    /// The self-service action description.
    description: ?[]const u8,

    /// The self-service action identifier.
    id: ?[]const u8,

    /// The self-service action name.
    name: ?[]const u8,

    pub const json_field_names = .{
        .definition_type = "DefinitionType",
        .description = "Description",
        .id = "Id",
        .name = "Name",
    };
};
