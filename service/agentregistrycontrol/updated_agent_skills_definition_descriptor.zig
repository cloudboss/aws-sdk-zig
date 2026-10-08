const UpdatedAgentSkillsDefinitionDescriptorFields = @import("updated_agent_skills_definition_descriptor_fields.zig").UpdatedAgentSkillsDefinitionDescriptorFields;

/// The agent skills definition descriptor patch wrapper. Omit to leave the
/// descriptor unchanged; supply an empty object to remove it; supply
/// optionalValue to patch its fields.
pub const UpdatedAgentSkillsDefinitionDescriptor = struct {
    /// The value to set for this field. Omit the wrapper to leave the field
    /// unchanged.
    optional_value: ?UpdatedAgentSkillsDefinitionDescriptorFields = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
