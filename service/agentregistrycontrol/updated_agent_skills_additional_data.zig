const UpdatedAgentSkillsAdditionalDataFields = @import("updated_agent_skills_additional_data_fields.zig").UpdatedAgentSkillsAdditionalDataFields;

/// The agent skills additional-data patch wrapper. Omit to leave the additional
/// data unchanged; supply an empty object to remove it; supply optionalValue to
/// patch its fields.
pub const UpdatedAgentSkillsAdditionalData = struct {
    /// The value to set for this field. Omit the wrapper to leave the field
    /// unchanged.
    optional_value: ?UpdatedAgentSkillsAdditionalDataFields = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
