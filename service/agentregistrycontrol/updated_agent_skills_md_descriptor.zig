const UpdatedAgentSkillsMdDescriptorFields = @import("updated_agent_skills_md_descriptor_fields.zig").UpdatedAgentSkillsMdDescriptorFields;

/// The agent skills markdown descriptor patch wrapper. Omit to leave the
/// descriptor unchanged; supply an empty object to remove it; supply
/// optionalValue to patch its fields.
pub const UpdatedAgentSkillsMdDescriptor = struct {
    /// The value to set for this field. Omit the wrapper to leave the field
    /// unchanged.
    optional_value: ?UpdatedAgentSkillsMdDescriptorFields = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
