const UpdatedAgentSkillsDescriptorFields = @import("updated_agent_skills_descriptor_fields.zig").UpdatedAgentSkillsDescriptorFields;

/// Wrapper for updating an agent skills descriptor with PATCH semantics. When
/// present with a value, individual fields can be updated independently. When
/// present with a null value, the entire agent skills descriptor is unset. When
/// absent, the agent skills descriptor is left unchanged.
pub const UpdatedAgentSkillsDescriptor = struct {
    /// The updated agent skills descriptor fields.
    optional_value: ?UpdatedAgentSkillsDescriptorFields = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
