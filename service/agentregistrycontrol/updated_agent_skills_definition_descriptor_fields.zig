const UpdatedAgentSkillsAdditionalData = @import("updated_agent_skills_additional_data.zig").UpdatedAgentSkillsAdditionalData;
const UpdatedDescriptorData = @import("updated_descriptor_data.zig").UpdatedDescriptorData;
const UpdatedDataSchemaVersion = @import("updated_data_schema_version.zig").UpdatedDataSchemaVersion;

/// The set of agent skills definition descriptor fields that can be
/// individually updated.
pub const UpdatedAgentSkillsDefinitionDescriptorFields = struct {
    /// The patch for the descriptor's additional data field.
    additional_data: ?UpdatedAgentSkillsAdditionalData = null,

    /// The patch for the descriptor's data field.
    data: ?UpdatedDescriptorData = null,

    /// The patch for the descriptor's data schema version field.
    data_schema_version: ?UpdatedDataSchemaVersion = null,

    pub const json_field_names = .{
        .additional_data = "additionalData",
        .data = "data",
        .data_schema_version = "dataSchemaVersion",
    };
};
